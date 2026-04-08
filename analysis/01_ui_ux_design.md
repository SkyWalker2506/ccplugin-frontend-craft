# #1 UI/UX & Design Analiz Raporu
> Lead: A9 ArtLead | Worker: B3 Frontend Coder + D1 UI/UX Researcher | Model: Sonnet 🔶

---

## Mevcut Durum

### Güçlü Yanlar

- **Token sistemi tanımlanmış:** Setup fazında 8px grid, spacing scale (`--space-xs` → `--space-2xl`), 4-rol renk sistemi (`primary / surface / muted / accent`), `--radius-*` ve `--ease-*` / `--duration-*` motion token'ları mevcut.
- **Anti-pattern listesi var:** Purple-default, Inter everywhere, card grid abuse, symmetric layouts, gradient-blob hero — bunların hepsi açıkça yasaklanmış.
- **Design ilkeleri tanımlı:** Asimetrik layout, editorial spacing, tipografik hiyerarşi, whitespace, unique section ritmi — bunlar SKILL.md'de prensip olarak yer alıyor.
- **Normalize fazı kapsamlı:** Hard-coded değerleri CSS custom property'ye çevirme adımları somut ve işlevli.
- **Copy kuralları var:** Başlık ≤8 kelime, alt başlık ≤20 kelime, CTA ≤4 kelime; yasaklı kelimeler listesi mevcut.
- **21st.dev entegrasyonu:** Designer-quality bileşen akışı sistematik tanımlanmış.
- **Leon's Taste Skill:** Dış referans olarak ekleniyor — design yargı katmanı var.

**Puan: 6/10**

Temel kemik iskelet güçlü; ancak token sistemi eksik, spacing scale yetersiz tanımlanmış, component düzeyinde UX kararları belirsiz.

---

## Kritik Eksikler (hemen yapılmalı)

| # | Sorun | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | Spacing scale'de sadece isimler var (`xs`→`2xl`), px değerleri tanımlı değil | High | SKILL.md'e `--space-xs: 4px` gibi somut değer tablosu ekle | S |
| 2 | Typography scale tamamen eksik — `font-size`, `line-height`, `letter-spacing` token'ları yok | High | `--text-sm / md / lg / xl / 2xl / display` scale'i tanımla | M |
| 3 | Renk token'ları sadece 4 rol ismi var, dark mode / light mode ayrımı yok | High | Semantic token katmanı ekle: `--color-bg`, `--color-text`, `--color-border` | M |
| 4 | Normalize fazı sadece var-olanı düzeltir; yeni komponent üretilirken design system ihlali engellenmez | High | Assemble fazına "token-first" zorunluluğu ekle: "Hiçbir renk/boyut hard-coded yazma" kuralı güçlendir | S |
| 5 | Shadows 3 seviye tanımlı ama somut değerler yok (`soft / medium / strong` sadece isim) | Med | `box-shadow` değerlerini SKILL.md'e yaz | S |

---

## İyileştirme Önerileri (planlı)

| # | Öneri | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | Design token'ları için starter `tokens.css` template üret — Setup fazında projeye kopyalansın | High | SKILL.md'e inline CSS bloğu ekle; Setup adımında `src/tokens.css` oluştur | M |
| 2 | Breakpoint sistemi tanımlanmamış — mobil/tablet/desktop token yokluğu responsive kaliteyi düşürür | High | `--bp-sm: 640px`, `--bp-md: 768px`, `--bp-lg: 1024px` ekle | S |
| 3 | Section kompozisyon fikirleri soyut ("asimetrik, editorial") — somut section şablonları yok | Med | 3-5 named section template (Hero A, Feature Grid B, Testimonial C vb.) tanımla | L |
| 4 | 21st.dev'den gelen bileşenler Normalize'dan önce doğrulanmıyor — token ihlali taşıyor olabilir | Med | Assemble çıktısını Normalize'a sokmadan önce "token audit" adımı ekle | M |
| 5 | Fill fazında kullanıcı araştırması var ama persona/user journey tanımı yok | Med | Basit bir "Target User" bloğu research.json şemasına ekle | S |
| 6 | Polish fazında animasyon kurallari (duration, easing, azaltılmış hareket) yeterince kapsanmamış | Med | `prefers-reduced-motion` media query zorunluluğu ekle | S |

---

## Kesin Olmalı (industry standard)

- CSS custom properties ile tam token sistemi — değerler dahil
- Typography scale (font-size, line-height, weight)
- Breakpoint tanımları
- `prefers-reduced-motion` desteği (Polish fazında)
- Semantic heading hiyerarşisi (`h1` → `h6`) rehberi

## Kesin Değişmeli (mevcut sorunlar)

- Spacing scale sadece isim — değerler eklenecek
- Shadow isimleri somut değerler olmadan çalışmaz
- Renk token'ları dark mode'u dışarıda bırakıyor
- Typography sistemi tamamen eksik; eklenmesi şart

## Nice-to-Have (diferansiasyon)

- Fluid typography (`clamp()`) — viewport-responsive type scale
- Design system linting: Stylelint kuralları (hard-coded renk/boyut yasağı)
- Component-level storybook/preview öneri (opsiyonel)
- Brand voice token'ları (tone, writing style per-section)

---

## Referanslar

- [Leon's Taste Skill](https://github.com/Leonxlnx/taste-skill)
- [21st.dev](https://21st.dev)
- Utopia — Fluid type & space: https://utopia.fyi
- Open Props (CSS token referans): https://open-props.style
- Josh Comeau CSS Reset (baseline): https://www.joshwcomeau.com/css/custom-css-reset/
