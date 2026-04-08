## Security & Infrastructure Analiz Raporu

> Lead: A13 SecLead | Worker: B13 Security Auditor, C2 Security Scanner | Model: claude-sonnet-4-6 🔶

---

### Mevcut Durum

**Güçlü yanlar:**
- `install.sh` ve `uninstall.sh` her ikisi de `set -euo pipefail` kullanıyor — hata durumunda script durur, unbound değişken kullanımı engellenir
- `PLUGIN_DIR` hesaplaması `cd + pwd` ile yapılıyor — relative path saldırısına kapalı
- `SKILL_DIR` sabit bir path (`$HOME/.claude/skills/frontend-craft`) — dinamik input yok
- Kurulum mantığı minimal: sadece `mkdir -p` + `cp` — saldırı yüzeyi küçük
- Harici komutlara (`curl`, `wget`, `git clone`) install sırasında başvurulmuyor
- `plugin.json` içinde herhangi bir executable, script referansı veya URL yok

**Puan: 6.5 / 10**

> Script güvenliği temel düzeyde sağlam. Asıl risk; SKILL.md'nin çalışma zamanında yönlendirdiği harici URL'ler ve araçlar (ffmpeg, npx netlify-cli, 21st.dev). Bunlar denetim dışı.

---

### Kritik Eksikler (hemen yapılmalı)

| # | Sorun | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| C1 | **Symlink saldırısı — `cp` hedef kontrolü yok.** `$HOME/.claude/skills/frontend-craft/SKILL.md` bir symlink'e point ediyorsa, `cp` o symlink üzerinden istenmeyen dosyayı üzerine yazar. | **High** — Arbitrary file overwrite | Kopyalamadan önce `[[ -L "$SKILL_DIR" ]]` ile symlink kontrolü ekle; varsa `rm -f` + uyarı | S |
| C2 | **`uninstall.sh` doğrulama yapmıyor.** `rm -rf "$SKILL_DIR"` çalıştırılmadan önce dizinin gerçekten plugin tarafından kurulduğu doğrulanmıyor. `$HOME` env değişkeni boş/manipüle edilmişse `rm -rf /.claude/skills/frontend-craft` gibi bir path çalışabilir. | **High** — `$HOME` boş ise `rm -rf /...` riski | `[[ -z "$HOME" ]]` guard ekle; `SKILL_DIR` pattern validate et | S |
| C3 | **SKILL.md üçüncü taraf repo'yu doğrudan çekiyor (Leon's Taste Skill — GitHub).** Setup fazında `https://github.com/Leonxlnx/taste-skill` fetch ediliyor; repo içeriği denetlenmiyor, integrity kontrolü (SHA, commit pin) yok. | **High** — Supply chain: kötü amaçlı commit Claude agent'a enjekte edilebilir | Commit hash'i sabitle (`@<sha>`), README'ye güvenlik notu ekle | M |
| C4 | **`npx netlify-cli deploy --prod` doğrudan prod'a deploy.** Kullanıcı onayı alınmadan çalıştırılıyor; kötü amaçlı bir proje ile tetiklenirse izinsiz deploy olur. | **High** — Unintended production deployment | `--prod` flag'i varsayılan kaldır; kullanıcıya prompt sor | S |

---

### İyileştirme Önerileri (planlı)

| # | Öneri | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| I1 | **ffmpeg komutu kullanıcı inputu kabul edebilir hale gelirse injection riski.** Şu an sabit argümanlar, ancak dinamik dosya adı gelirse `ffmpeg -i $USER_INPUT` tehlikeli olur. | **Med** — Shell injection potansiyeli | SKILL.md'ye `"Dosya adlarını her zaman quote içinde geçir"` notu ekle | S |
| I2 | **Harici AI araçları (playgroundai, ideogram, higgsfield) HTTP üzerinden erişim riski.** Bu siteler HTTPS kullanıyor ancak domain takibi/phishing olasılığı var; kullanıcı veri gönderebilir. | **Med** — Data exfiltration / phishing exposure | SKILL.md'de "Bu siteler üçüncü taraftır — hassas proje verisi yükleme" uyarısı ekle | S |
| I3 | **`21st.dev` prompt dosyaları (`components/*.txt`) işlenmeden Claude'a geçiyor.** Prompt injection riski: biri kötü amaçlı bir `.txt` dosyası yerleştirirse Claude bu talimatları uygular. | **Med** — Prompt injection via component files | SKILL.md'ye "Sadece güvendiğin kaynaklardan component prompt kullan" uyarısı ekle | S |
| I4 | **`plugin.json` versiyon lock mekanizması yok.** `version: 1.0.0` statik; güncelleme sırasında downgrade saldırısına açık. | **Low** — Version confusion | Installer'a version check + minimum version guard ekle | M |
| I5 | **`assets/research.json` diske yazılıyor, içerik denetlenmiyor.** Fill fazında LLM çıktısı doğrudan JSON olarak yazılıyor; path traversal ile kötü key ismi içerebilir. | **Low** — Minimal, ancak dikkat edilmeli | JSON schema validate et | M |

---

### Kesin Olmalı (industry standard)

- `set -euo pipefail` — mevcut, iyi
- `$HOME` boş kontrolü: `[[ -z "$HOME" ]] && { echo "HOME not set"; exit 1; }`
- Symlink kontrolü hedef path'lerde
- Supply chain: harici repo'lar commit hash ile pin'lenmeli
- Üçüncü taraf araçlar (netlify-cli) prod flag'i kullanıcı onayına bağlı olmalı

### Kesin Değişmeli (mevcut sorunlar)

1. **`uninstall.sh`:** `$HOME` guard + SKILL_DIR pattern kontrolü ekle
2. **`install.sh`:** Symlink kontrolü — hedef varsa ve symlink ise uyar ve çık
3. **SKILL.md — Setup fazı:** `Leonxlnx/taste-skill` referansını commit SHA ile sabitle
4. **SKILL.md — Polish fazı:** `npx netlify-cli deploy --prod` → kullanıcı onayı iste

### Nice-to-Have (diferansiasyon)

- **Checksum doğrulama:** `SKILL.md` kopyalanırken sha256 check — plugin güncellemelerinde integrity garantisi
- **Sandbox uyarısı:** SKILL.md'ye "Bu skill harici servislere erişir; izole bir ortamda çalıştırmayı düşünebilirsin" notu
- **Audit log:** `~/.claude/skills/frontend-craft/.install-log` dosyası — kim, ne zaman, hangi sürüm kurdu
- **`--dry-run` modu:** `install.sh --dry-run` ile ne yapacağını göster, yapmadan

---

### Referanslar

- [Bash Strict Mode](https://reisinge.net/notes/bash/strict-mode) — `set -euo pipefail` önemi
- [CWE-59: Symlink Following](https://cwe.mitre.org/data/definitions/59.html)
- [CWE-78: OS Command Injection](https://cwe.mitre.org/data/definitions/78.html)
- [Supply Chain Security — SLSA Framework](https://slsa.dev/)
- [Prompt Injection Attacks on LLM Agents](https://arxiv.org/abs/2302.12173)
