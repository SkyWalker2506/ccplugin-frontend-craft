# ccplugin-frontend-craft — Yönlendirici

> **Bu dosya sadece yönlendiricidir.** Tüm kurallar `~/Projects/claude-config/CLAUDE.md` dosyasındadır.

---

## Her oturum başında

1. **`~/Projects/claude-config/CLAUDE.md` dosyasını oku** ve talimatlarını uygula
2. Yanıt başında model etiketi: `(Model Adı)`
3. Dil: kullanıcıya Türkçe; kod/commit İngilizce

## Bu plugin hakkında

ANF (Assemble → Normalize → Fill) + Polish pipeline — high-end frontend siteleri ve uygulamalar üretmek için.

Tek giriş noktası: `install.sh`

```bash
./install.sh    # ~/.claude/skills/frontend-craft/ altına skill kur
./uninstall.sh  # Kaldır
```

Kurulum sonrası `/frontend-craft` skill'i tüm Claude Code session'larında aktif olur.

## Kullanım

### ClaudeHQ sprint sistemi ile
```bash
hq frontend <project> [--stack next|astro|vanilla]
hq dispatch <project>
```

### Standalone
```
/frontend-craft setup
/frontend-craft assemble
/frontend-craft normalize
/frontend-craft fill
/frontend-craft polish
```

## Pipeline fazları

| Faz | Açıklama |
|-----|----------|
| setup | Scaffold, design tokens, taste skill |
| assemble | 21st.dev component prompt'ları → section'lar |
| normalize | CSS custom properties unification |
| fill | Ürün araştırması, gerçek copy, AI asset üretimi |
| polish | Animation, video, scroll effects, Netlify deploy |
