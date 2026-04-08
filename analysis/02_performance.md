# #2 Performance & Core Web Vitals — Analiz Raporu
> Lead: A10 CodeLead | Worker: B12 Performance Optimizer | Model: claude-sonnet-4-6 🔶

---

## Mevcut Durum

### Ne yapılmış (güçlü yanlar)
- Lighthouse 90+ hedefi açıkça belirtilmiş (Polish fazı)
- Video için doğru HTML attribute'ları tanımlı: `autoplay loop muted playsinline`, `object-fit: cover`
- ffmpeg CRF 28 ile video sıkıştırma komutu mevcut
- 8px grid sistemi ve CSS custom properties tasarımı DOM derinliğini azaltır
- Playground AI / Ideogram free tier asset üretimi — external CDN yükü yok
- Netlify CDN ile deploy — otomatik CDN + SSL + HTTP/2

### Puan: **4/10**

Hedef net (90+ Lighthouse) ama hedefe ulaşmak için somut teknik direktifler yetersiz. CWV metrikleri (LCP, CLS, INP) tek tek ele alınmamış. Performans kuralları "deploy sonrası kontrol" olarak bırakılmış, önleyici tasarım direktifleri eksik.

---

## Kritik Eksikler (hemen yapılmalı)

| # | Sorun | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | LCP (Largest Contentful Paint) direktifi yok — hero image/video için `fetchpriority="high"`, `preload` kuralı tanımsız | High | Polish fazına: `<link rel="preload" as="image">` hero image için, `fetchpriority="high"` hero `<img>`'e ekle direktifi yaz | S |
| 2 | CLS (Cumulative Layout Shift) önlemi yok — image/video boyutları rezervasyonu zorunluluğu belirtilmemiş | High | Assemble fazına: tüm `<img>` ve `<video>` elemanları için `width`/`height` attribute zorunluluğu + `aspect-ratio` CSS kuralı ekle | S |
| 3 | INP (Interaction to Next Paint) için JavaScript direktifi yok | Med | Polish fazına: IntersectionObserver için `passive: true`, event handler'lara debounce, heavy JS'i `defer`/`async` yap kuralı ekle | S |
| 4 | ffmpeg komutları Web'e uygun format bilgisi eksik — WebM/AV1 alternatifi yok | Med | ffmpeg komutlarına WebM + H.264 çift format çıktısı ekle: `-c:v libvpx-vp9 -crf 30` + `<source type="video/webm">` direktifi | S |
| 5 | Font loading stratejisi tanımsız — font-display, preconnect, fallback yok | High | Setup fazına: `font-display: swap`, Google Fonts için `<link rel="preconnect">`, system font fallback stack zorunluluğu ekle | S |

---

## İyileştirme Önerileri (planlı)

| # | Öneri | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | Hero video sıkıştırma agresif değil — CRF 28 ortalama; web için CRF 32-35 + `faststart` flag'i önerilmeli | Med | ffmpeg komutunu: `-crf 32 -movflags +faststart -vf "scale=1920:-2"` şeklinde güncelle | S |
| 2 | GIF yerine `<video>` veya `.webp` animasyon kullanım direktifi yok — GIF performans katili | Med | Fill fazına: "Animated GIF kullanma — `<video autoplay loop muted playsinline>` veya `.webp` kullan" direktifi ekle | S |
| 3 | Image format direktifi eksik — WebP/AVIF zorunluluğu belirtilmemiş | Med | Assemble fazına: tüm hero/section image'leri için `<picture>` + `<source type="image/avif">` + `<source type="image/webp">` şablonu ekle | M |
| 4 | Scroll animation için `will-change` uyarısı yok — aşırı kullanım GPU belleği patlatır | Med | Polish fazına: `will-change: transform` sadece aktif animasyonda, bitince kaldır notu ekle | S |
| 5 | CSS custom properties yaklaşımı var ama critical CSS / above-the-fold inline CSS direktifi yok | Med | Polish fazına: hero section CSS'i inline `<style>` ile critical path'e al direktifi ekle | M |
| 6 | Netlify deploy sonrası Lighthouse audit otomasyonu yok — skor doğrulama manuel | Low | Polish fazına: `npx lighthouse <url> --output json --chrome-flags="--headless"` ile skor doğrulama adımı ekle | M |
| 7 | Resource hints (dns-prefetch, preconnect) direktifi yok — third-party script'ler için gerekli | Low | Setup fazına: 21st.dev, Playground AI, font API'leri için `<link rel="preconnect">` şablonu ekle | S |
| 8 | `netlify.toml` cache-control header direktifi yok — static asset caching tanımsız | Med | Polish fazına: `netlify.toml` için `Cache-Control: public, max-age=31536000, immutable` direktifi + örnek config ekle | S |

---

## Kesin Olmalı (industry standard)

- `font-display: swap` — FOIT önlemi, zorunlu — **eksik**
- `<img width height>` attribute — CLS önlemi, zorunlu — **eksik direktif olarak**
- `fetchpriority="high"` hero image — LCP, zorunlu — **eksik**
- WebP/AVIF format kullanımı — file size %30-50 azalır — **eksik**
- `movflags +faststart` video için — progressive download, zorunlu — **eksik**
- Netlify CDN cache headers — **eksik direktif**

## Kesin Değişmeli (mevcut sorunlar)

- GIF oluşturma komutu belgeden kaldırılmalı veya "sadece gerektiğinde, küçük" notu eklenmeli
- ffmpeg komutu `faststart` flag'i içermeli
- Hero video sadece H.264 değil, WebM + H.264 `<source>` çifti olmalı
- Lighthouse audit "verify" adımında değil, deploy öncesi zorunlu adım olmalı

## Nice-to-Have (diferansiasyon)

- `animation-timeline: scroll()` tarayıcı desteği uyarısı ve polyfill direktifi
- Core Web Vitals izleme: `web-vitals.js` snippet'i ile analytics entegrasyonu
- Partial hydration / islands architecture önerisi (Astro stack için)
- Bundle size budget: JS < 100KB compressed hedefi olarak eklenebilir
- Lighthouse CI GitHub Actions entegrasyonu (PR'larda otomatik skor kontrolü)

---

## Referanslar

- `skills/SKILL.md` — Polish fazı, ffmpeg komutları, Lighthouse hedefi
- Core Web Vitals: https://web.dev/vitals/
- ffmpeg web optimizasyon: https://developers.google.com/media/vp9
- Netlify cache headers: https://docs.netlify.com/routing/headers/
- `font-display`: https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display
