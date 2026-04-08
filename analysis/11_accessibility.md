# #11 Accessibility Analiz Raporu
> Lead: A9 ArtLead | Worker: D8 Mockup Reviewer + B3 Frontend Coder | Model: Sonnet 🔶 (Haiku hedefi)

---

## Mevcut Durum

### Güçlü Yanlar

- **Semantic HTML başlangıcı var:** SKILL.md Assemble fazında `<section id="...">` zorunluluğu belirtiyor — bu semantic yapı için olumlu.
- **Lighthouse hedefi mevcut:** Polish fazı "90+ Lighthouse score" hedefliyor — bu accessibility'i de dolaylı kapsıyor.
- **SEO adımları var:** `<title>`, `<meta description>`, `<h1>` hiyerarşi kontrolü Fill fazında yer alıyor — heading sırası için temel kural çiziliyor.
- **Video için teknik doğru:** Hero video `autoplay loop muted playsinline` — `muted` autoplay için zorunlu, `playsinline` mobilde doğru.

**Puan: 2/10**

Accessibility neredeyse tamamen gözardı edilmiş. Tek dolaylı referans Lighthouse hedefi. WCAG, ARIA, kontrast, klavye navigasyonu, screen reader hiçbirinden söz edilmiyor.

---

## Kritik Eksikler (hemen yapılmalı)

| # | Sorun | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | WCAG 2.1 AA minimum kontrast oranı (4.5:1 metin, 3:1 büyük metin) — hiç tanımlanmamış | High | Normalize fazına renk token kontrast zorunluluğu ekle; SKILL.md'e WCAG AA referansı yaz | S |
| 2 | `alt` attribute zorunluluğu yok — Fill fazında AI ile üretilen tüm görseller alt-text gerektiriyor | High | Fill fazına "Her `<img>` için anlamlı alt text yaz" kuralı ekle; dekoratif görseller için `alt=""` notu | S |
| 3 | Klavye navigasyonu (`Tab`, `Enter`, `Esc`, `Arrow`) hiç kapsanmamış | High | Polish/Normalize'a `:focus-visible` zorunluluğu ve `outline` stiline dokunma yasağı ekle | M |
| 4 | `prefers-reduced-motion` — Polish fazındaki tüm animasyonlar bu media query'yi görmezden geliyor | High | SKILL.md'e `@media (prefers-reduced-motion: reduce)` bloğu zorunluluğu ekle | S |
| 5 | Heading hiyerarşisi kontrol ediliyor ama ARIA landmark'ları hiç yok (`<main>`, `<nav>`, `<header>`, `<footer>`) | High | Assemble fazına semantic landmark element zorunluluğu ekle | S |

---

## İyileştirme Önerileri (planlı)

| # | Öneri | Etki | Çözüm | Efor |
|---|-------|------|-------|------|
| 1 | Lighthouse score 90+ hedefi — accessibility alt-skoru ayrıca izlenmiyor; açıkça "90+ accessibility" denmeli | High | Polish fazı checklist'ine `lighthouse --only-categories=accessibility` komutu ekle | S |
| 2 | Form varsa (`<input>`, `<button>`) — label ilişkisi, error mesajı, required/invalid ARIA state tanımsız | High | Form bileşeni için ayrı accessibility kuralları ekle (21st.dev'den gelen form komponentleri için) | M |
| 3 | `<video>` için caption/transcript desteği yok — işitme engelliler için içerik erişilmez | Med | Polish fazına: "Konuşma içeren videolar için `<track kind="captions">` ekle" notu koy | S |
| 4 | Renk tek başına bilgi taşıyor mu kontrolü yok (e.g. kırmızı = hata sadece renkle) | Med | Fill/Normalize'a "Renk tek başına anlam taşımasın; ikon veya metin eşliği zorunlu" notu ekle | S |
| 5 | Touch target boyutu — mobil buton/link min 44x44px WCAG 2.5.5 — hiç belirtilmemiş | Med | Normalize fazına `min-height: 44px; min-width: 44px` for interactive elements kuralı ekle | S |
| 6 | Skip navigation link (`<a href="#main">Skip to content</a>`) — önerilmiyor | Med | Setup fazı HTML template'ine skip-nav ekle | S |

---

## Kesin Olmalı (industry standard)

- WCAG 2.1 AA kontrast oranları (Lighthouse bunu ölçüyor ama SKILL'de kayıt yok)
- Anlamlı `alt` text her görselde
- `:focus-visible` stillemesi (outline kaldırmak yasak)
- `prefers-reduced-motion` desteği
- Semantic HTML landmark'ları (`<main>`, `<nav>`, `<header>`, `<footer>`)
- Klavye navigasyonu çalışabilir olmalı (Tab sırası mantıklı)

## Kesin Değişmeli (mevcut sorunlar)

- Polish fazındaki animasyonlar `prefers-reduced-motion`'sız — tümü güncellenmeli
- Fill fazı AI görsel üretiminde alt text kuralı yok — eklenmeli
- Hero video semantik erişilebilirlik notu yok — `aria-label` veya açıklama eklenebilir

## Nice-to-Have (diferansiasyon)

- ARIA live regions (dinamik içerik güncellemesi için)
- Axe-core entegrasyonu CI/CD'ye (otomatik a11y testi)
- Color contrast checker referansı (whocanuse.com veya contrast.tools)
- Forced colors / high contrast mode testi

---

## Referanslar

- WCAG 2.1 AA: https://www.w3.org/TR/WCAG21/
- WebAIM Contrast Checker: https://webaim.org/resources/contrastchecker/
- Axe DevTools: https://www.deque.com/axe/
- MDN: `prefers-reduced-motion`: https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion
- A11y Project Checklist: https://www.a11yproject.com/checklist/
