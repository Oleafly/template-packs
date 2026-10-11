// Imports
#import "@preview/brilliant-cv:2.0.5": cvSection, cvEntry
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)
#let cvEntry = cvEntry.with(metadata: metadata)


#cvSection("Expérience Professionnelle")

#cvEntry(
  title: [Stagiaire],
  society: [Alternatives Energies],
  date: [27 Mai 2024 -- 02 Août 2024],
  logo: "",
  location: [La Rochelle, France],
  description: list(
    [Réalisation d'un système automatisé de récupération, de traitement et d'analyse de données avec Python],
    [Création d'une interface web avec Django pour intéragir avec une base de données PostgreSQL],
    [Configuration et personnalisation de plusieurs tableaux de bord sur Grafana],
    [Mise en place d'un environement de production avec Debian sur un serveur et deploiement du projet avec Docker]
  ),
  tags: ("Python", "Django", "PostgreSQL", "Grafana", "Docker", "Debian"),
)

#cvEntry(
  title: [Stagiaire en recherche],
  society: [Laboratoire Hubert Curien],
  date: [17 Avril 2023 - 21 Juillet 2023],
  location: [Saint-Etienne, France],
  logo: "",
  description: list(
    [Implantation matérielle, en VHDL et sur cible FPGA, de fonctions mathématiques élémentaires utilisées en cryptographie post-quantique],
    [Création d'un programme en Python pour intéragir avec le FPGA intégré à la carte ChipWhisperer],
    [Comparaison et vérification de différentes stratégies d'implémentation],
    [Réalisation d'attaques par observation des canaux auxiliaires sur les implantations réalisées]
  ),
  tags: ("VHDL", "Verilog", "FPGA", "Vivado", "ChipWhisperer", "Cyrptographie", "Python", "Post-quantique"),
)

#cvEntry(
  title: [Président de l'association de Robotique],
  society: [Projet&Tech],
  date: [2024 - 2025],
  location: [Saint-Etienne, France],
  logo: "",
  description: list(
    [Organisation des tâches et gestion des équipes],
    [Conception et création du robot avec les membres de l'associations],
    [Formation des premier années à la robotique et aux outils et technologies associées],
    [Gestion administrative et recherche de partenariats]
    ),
  tags: ("C / C++", "Arduino", "STM32", "Robotique", "PCB", "Altium Designer", "Gestion de projet"),
)
