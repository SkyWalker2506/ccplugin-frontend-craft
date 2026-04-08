# ccplugin-frontend-craft — Sprint Plan
> Generated: 2026-04-08 | Source: MASTER_ANALYSIS.md | Jira: FECRFT

## Özet

| Metrik | Değer |
|--------|-------|
| Genel puan | 4.2/10 |
| Hedef puan (Sprint 3 sonrası) | 7.5/10 |
| Toplam task | 22 |
| Sprint sayısı | 3 |
| Jira projesi | FECRFT |

---

## Sprint 1 — Security & Critical Fixes
> Süre: 2 hafta | Kapasite: ~15 SP | Odak: P0 güvenlik + keşfedilebilirlik

| Jira | Summary | Priority | Efor | Label |
|------|---------|----------|------|-------|
| FECRFT-1 | [Sprint 1] Security & Critical Fixes (umbrella) | — | — | — |
| FECRFT-2 | Add $HOME guard and path validation to uninstall.sh | Highest | S | security |
| FECRFT-3 | Add symlink check to install.sh before file copy | Highest | S | security |
| FECRFT-4 | Pin taste-skill to specific commit SHA | Highest | M | security |
| FECRFT-5 | Add user confirmation before netlify prod deploy | High | S | security |
| FECRFT-6 | Add GitHub repository topics for discoverability | High | S | growth |

**Sprint hedefi:** Plugin güvenli hale gelir, GitHub'da aranabilir olur.

---

## Sprint 2 — Performance & Architecture
> Süre: 2 hafta | Kapasite: ~25 SP | Odak: CWV direktifleri + install sağlamlığı

| Jira | Summary | Priority | Efor | Label |
|------|---------|----------|------|-------|
| FECRFT-12 | [Sprint 2] Performance & Architecture (umbrella) | — | — | — |
| FECRFT-14 | Add font-display:swap and preconnect directives to Setup phase | High | S | perf |
| FECRFT-15 | Add fetchpriority and preload directives for hero images | High | S | perf |
| FECRFT-18 | Enforce width/height attributes on all img and video elements (CLS fix) | High | S | perf |
| FECRFT-19 | Add typography scale tokens to design system | High | M | ui |
| FECRFT-20 | Add concrete values to spacing scale tokens | High | S | ui |
| FECRFT-21 | Add backup mechanism to install.sh (idempotent install) | High | S | arch |
| FECRFT-23 | Add WebM + faststart flag to ffmpeg command in Polish phase | Medium | S | perf |

**Sprint hedefi:** Lighthouse 90+ hedefi gerçekçi hale gelir, token sistemi somut değerler kazanır.

---

## Sprint 3 — UX, Accessibility & Content
> Süre: 2 hafta | Kapasite: ~25 SP | Odak: WCAG AA + README yenileme + demo

| Jira | Summary | Priority | Efor | Label |
|------|---------|----------|------|-------|
| FECRFT-7 | [Sprint 3] UX, Accessibility & Content (umbrella) | — | — | — |
| FECRFT-8 | Add prefers-reduced-motion rule to Polish phase animations | Highest | S | a11y |
| FECRFT-9 | Add WCAG AA contrast requirement to color token system | Highest | S | a11y |
| FECRFT-10 | Add alt text rules for AI-generated images in Fill phase | Highest | S | a11y |
| FECRFT-11 | Add ARIA landmark requirements to Assemble phase | High | S | a11y |
| FECRFT-13 | Add demo GIF or screenshot to README | High | M | content |
| FECRFT-16 | Add 'Why ANF?' section and target audience to README | High | S | content |
| FECRFT-17 | Add dark mode semantic token layer to design system | Medium | M | ui |

**Sprint hedefi:** Accessibility 2/10 → 6/10, README adoption funnel'ı açar.

---

## Hedef Puanlar (Sprint 3 sonrası)

| Kategori | Mevcut | Hedef |
|----------|--------|-------|
| UI/UX | 6.0 | 8.0 |
| Performance | 4.0 | 7.5 |
| Growth | 3.0 | 6.5 |
| Security | 6.5 | 8.5 |
| Content | 5.0 | 8.0 |
| Architecture | 4.5 | 7.5 |
| Accessibility | 2.0 | 6.5 |
| **Ortalama** | **4.2** | **7.5** |

---

## Jira
[musabkara1990.atlassian.net/jira/software/projects/FECRFT](https://musabkara1990.atlassian.net/jira/software/projects/FECRFT)
