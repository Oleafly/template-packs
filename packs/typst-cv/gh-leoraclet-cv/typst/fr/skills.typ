// Imports
#import "@preview/brilliant-cv:2.0.5": cvSection, cvSkill, hBar
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)


#cvSection("Compétences")

#cvSkill(
  type: [Langues],
  info: [Français - Anglais (TOEIC: 925) - Chinois],
)

#cvSkill(
  type: [Technologies],
  info: [Python - C / C++ - SQL - VHDL - HTML - CSS - JS - Bash],
)

#cvSkill(
  type: [Outils],
  info: [Grafana - Quartus - Altium - Github - Git - Docker - Django - PostgreSQL],
)

#cvSkill(
  type: [Systèmes],
  info: [STM32 - Arduino - Linux - Windows - Raspberry Pi - NixOS],
)
