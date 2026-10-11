// ======================================================
// TRILINGUAL ABSTRACT (Template Demo)
// ------------------------------------------------------
// Replace the text below with your own abstract.
// ------------------------------------------------------

#let abstract-rule = line(length: 100%, stroke: 0.5pt)

#let keywords-line(en-label, words) = [
  #v(0.8em)
  #text(weight: "bold")[#en-label] #words
]

#set par(justify: true)

// ── Arabic ───────────────────────────────────────────────
#align(right)[
  #text(size: 13pt, weight: "bold", lang: "ar")[ملخص]
]

#set text(lang: "ar", dir: rtl)
#align(right)[
  هذا المشروع يهدف إلى تطوير حل متكامل باستخدام تقنيات حديثة. يركز العمل على تصميم وتنفيذ منصة
  رقمية تلبي احتياجات المستخدمين وتوفر خدمات عالية الجودة. تم استخدام أحدث الأدوات والتقنيات
  لضمان أداء موثوق وقابل للتوسع. النتائج تظهر فعالية الحل المقترح في تحقيق الأهداف المرجوة.

  #text(weight: "bold")[الكلمات المفتاحية :]
  منصة رقمية، تطوير، تقنيات حديثة، أداء، حلول مبتكرة.
]

#abstract-rule
#set text(lang: "en", dir: ltr)

// ── English ──────────────────────────────────────────────
#text(size: 13pt, weight: "bold")[Abstract]

This project targets the design, development, and deployment of a modern digital platform
using cutting-edge technologies. The work focuses on building a scalable, secure, and
maintainable system that addresses real-world challenges. The architecture adopts a modular
structure with standardized services, secure authentication, and role-based access control.
The platform supports core workflows, real-time communication, and integrates with cloud
infrastructure for high availability.

#keywords-line[Keywords:][
  Digital Platform, Backend Development, REST API, Cloud Computing, DevOps
]
#abstract-rule

// ── French ───────────────────────────────────────────────
#text(size: 13pt, weight: "bold")[Résumé]

Ce projet vise la conception, le développement et le déploiement d'une plateforme numérique
moderne utilisant des technologies de pointe. Le travail se concentre sur la construction d'un
système évolutif, sécurisé et maintenable répondant à des défis concrets. L'architecture adopte
une structure modulaire avec des services standardisés, une authentification sécurisée et un
contrôle d'accès basé sur les rôles.

#keywords-line[Mots-clés :][
  Plateforme numérique, développement backend, API REST, cloud computing, DevOps
]




