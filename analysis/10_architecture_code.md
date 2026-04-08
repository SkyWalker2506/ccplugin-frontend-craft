# #10 Architecture & Code Quality — Analiz Raporu
> Lead: A10 CodeLead | Worker: B1 Backend Architect + B8 Refactor Agent + B10 Dependency Manager | Model: claude-sonnet-4-6 🔶

---

## Mevcut Durum

### Ne yapılmış (güçlü yanlar)
- `install.sh` / `uninstall.sh` sade ve işlevsel: `set -euo pipefail` ile hata koruması var
- Tek kaynak dosyası (`SKILL.md`) — minimal ayak izi, kolay bakım
- `plugin.json` metadata doğru alanları içeriyor (id, version, author, category)
- ANF pipeline fazları net ayrışmış, her fazın sorumluluğu belirli
- Skill'in frontmatter (`name`, `description`, `argument-hint`, `user-invocable`) doğru formatlanmış

### Puan: **4.5/10**

Temel kurulum çalışıyor; ancak production-grade bir plugin için beklenen hata yönetimi, versiyon kontrolü, idempotency, test altyapısı ve modülerlik büyük ölçüde eksik.

---

## Kritik Eksikler (hemen yapılmalı)

| # | Sorun | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | `install.sh` mevcut kurulumun üzerine kör yazıyor — yedek yok, diff yok | High | Kurulumdan önce `$SKILL_DIR` varsa backup al veya kullanıcıya sor | S |
| 2 | Versiyon yönetimi yok: `plugin.json`'daki `1.0.0` `SKILL.md`'ye yansımıyor, güncelleme mekanizması tanımsız | High | `install.sh` içine versiyon dosyası yaz (`$SKILL_DIR/version`), güncelleme kontrolü ekle | S |
| 3 | `uninstall.sh` `rm -rf` ile tüm dizini siliyor — kullanıcının özelleştirdiği dosyalar kaybolabilir | High | Silmeden önce dizin içeriğini listele, onay iste veya backup al | S |
| 4 | Tek monolitik `SKILL.md` — 108 satır artık yönetilmesi zor, fazlar arası sınır belirsizleşiyor | Med | Her fazı ayrı dosyaya böl (`phases/setup.md`, `phases/assemble.md` vb.), ana SKILL.md sadece routing yapsın | M |
| 5 | `plugin.json` schema validation yok — zorunlu alanlar eksikse kurulum sessizce geçiyor | Med | `install.sh`'a `jq` ile schema kontrolü ekle | S |

---

## İyileştirme Önerileri (planlı)

| # | Öneri | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | `CHANGELOG.md` veya `VERSIONS.md` yok — hangi versiyonun ne getirdiği bilinmiyor | Med | Semantic versioning + changelog tutmak için basit convention belirle | S |
| 2 | `install.sh` kurulum sonrası doğrulama yapmıyor | Med | Kurulum sonunda `$SKILL_DIR/SKILL.md` varlığını doğrula, checksum kontrolü ekle | S |
| 3 | `plugin.json`'da `dependencies` alanı yok — ffmpeg, netlify-cli, jq gibi dış bağımlılıklar belirtilmemiş | Med | `dependencies` / `prerequisites` alanı ekle, install.sh bunları kontrol etsin | M |
| 4 | Skill'in hangi Claude Code versiyonlarıyla uyumlu olduğu belirtilmiyor | Low | `plugin.json`'a `minClaudeVersion` / `compatibleWith` alanı ekle | S |
| 5 | Test / smoke-test mekanizması yok — kurulumun doğru çalıştığını doğrulayan senaryo yok | Med | Basit bir `test.sh` ile `/frontend-craft setup` çıktısını kontrol et | M |
| 6 | `install.sh` `cp` yerine `rsync` veya symlink kullanabilir — skill güncelleme daha kolay olurdu | Low | Symlink: `ln -sf "$PLUGIN_DIR/skills/SKILL.md" "$SKILL_DIR/SKILL.md"` (tek dosya için uygun) | S |

---

## Kesin Olmalı (industry standard)

- `set -euo pipefail` shell scriptlerde zorunlu — **var, iyi**
- Semantic versioning (MAJOR.MINOR.PATCH) — var ama izlenmiyor
- İdempotent kurulum — kurulum iki kez çalışınca sorun çıkmamalı — **eksik**, `mkdir -p` var ama dosya üzerine yazma kontrol edilmiyor
- Dependency check — prerequisite tool'ların (ffmpeg, netlify-cli) varlığını kontrol et — **eksik**
- Uninstall güvenliği — veri kaybına yol açmamalı — **eksik** (rm -rf direkt)

## Kesin Değişmeli (mevcut sorunlar)

- `install.sh`'da backup mekanizması eklenmeli
- `uninstall.sh`'da onay adımı veya dry-run modu olmalı
- `plugin.json` bağımlılık listesi genişletilmeli
- Versiyon takip dosyası (`$SKILL_DIR/version`) kurulumda yazılmalı

## Nice-to-Have (diferansiasyon)

- `--dry-run` flag'i ile kurulumu simüle et
- `--force` flag'i ile mevcut kurulumu sıfırla
- Multi-skill support: gelecekte yeni fazlar için `skills/` klasörü genişleyebilir tasarım
- Homebrew / npm package formatına taşınabilirlik değerlendirmesi

---

## Referanslar

- `install.sh`, `uninstall.sh`, `plugin.json`, `skills/SKILL.md`
- Bash best practices: https://google.github.io/styleguide/shellguide.html
- Plugin manifest pattern: VS Code extension `package.json` yaklaşımı
