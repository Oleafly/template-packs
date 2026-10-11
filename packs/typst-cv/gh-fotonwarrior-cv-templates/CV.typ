#import "@preview/modern-resume:1.0.0": modern-resume, experience, project, pill
#let ROL = "data_engineer"
#let data = json("parameters.json").at(ROL)
#let custom-theme = (
  primary: rgb("#313C4E"),
  secondary: rgb("#222A33"),
  accentColor: rgb("#449399"),
  textPrimary: rgb("#000000"),
  textSecondary: rgb("#7C7C7C"),
  textMuted: rgb("#ffffff"),
)

// Nederlandse afbreekregels en aanhalingstekens
#set text(lang: "nl")

#show: modern-resume.with(
  author: "Remco Bomhof",
  job-title: data.title,
  bio: data.intro_text,

  avatar: image("professionele profielfoto.jpg"),
  contact-options: (
    email: link("mailto:remcobomhof1@gmail.com")[remcobomhof1\@gmail.com],
    mobile: "06 37193256",
    location: "Heerlen",
    linkedin: link("www.linkedin.com/in/remco-bomhof-881306139")[Remco Bomhof],
    github: link("https://github.com/Fotonwarrior")[Fotonwarrior]
  ),
  theme: custom-theme,
)



== Werkervaring

#experience(
  title: "Business Intelligence Specialist",
  subtitle: "Moonen Group of Companies, Stamproy",
  facility-description: "End-to-end platformverantwoordelijkheid bij een MKB-bedrijf in de uitzendsector.",
  task-description: [
    - Gefragmenteerde Power BI Pro-omgeving (losse semantische modellen op een T-SQL-database) omgebouwd tot één centraal datawarehouse op Microsoft Fabric met medallion-architectuur, inclusief migratie vanaf SQL Server
    - Metadatagedreven ELT-framework in PySpark gebouwd.
    - Bronsystemen, waaronder het ERP, ontsloten via OData-API's en Fabric Data Pipelines
    - Platform ingericht in drie lagen (data engineering, analytics, reporting), elk met eigen dev- en prod-omgeving via Azure DevOps en Fabric deployment pipelines
    - Transformatielaag in migratie van stored procedures naar dbt, voor versiebeheer, testbaarheid en lineage
    - Datagovernance in semantische modellen, zodat citizendevelopers het platform kunnen gebruiken, zonder het risico te lopen dat gevoelige data lekt
    - Dimensionele modellen als basis voor Power BI; informatieproducten van een operational excellence-dashboard voor het MT tot een datakwaliteitsdashboard voor operationele afdelingen
  ],
  date-from: "04/2025",
  date-to: "heden",
  label: "Resultaten",
  theme: custom-theme,
)

#experience(
  title: "Business Intelligence Specialist",
  subtitle: "Meandergroep Zuid-Limburg, Landgraaf",
  facility-description: "Zorgorganisatie; grootschalig BI-traject gericht op datagedreven sturing en inzicht in de klantreis",
  task-description: [
    - Samen met externe consultants gewerkt aan een geintegreerd dashboard voor managers, waarin meerdere businessdomeinen samenkomen
    - Pipeline gebouwd om OpenEHR-data bruikbaar te maken voor rapportage
    - Bijgedragen aan het strategische klantreis-dashboard
    - Schakel tussen business, externe consultants en technische implementatie
  ],
  date-from: "02/2024",
  date-to: "03/2025",
  label: "Resultaten",
  theme: custom-theme,
)

#experience(
  title: "Medior Finance Consultant",
  subtitle: [Pragmatics (Gedetacheerd bij scholenstichting Swalm en Roer)],
  facility-description: "Interim financieel stafmedewerker bij een onderwijsstichting tijdens onderbezetting",
  task-description: [
    - Raad van Bestuur geadviseerd over begroting en resultaten
    - Geschakeld met subsidieverstrekkers
    - Excel-processen geautomatiseerd met Power Query en SQL
    - Directeuren begeleid in de decentrale begrotingsronde
  ],
  date-from: "08/2023",
  date-to: "01/2024",
  label: "Resultaten",
  theme: custom-theme,
)

#experience(
  title: "Analyst Audit Analytics",
  subtitle: "Deloitte, Utrecht",
  facility-description: "Data-analyse binnen de auditpraktijk",
  task-description: [
    - Gestandaardiseerde analysetools ontwikkeld voor de vastgoed- en automotivesector, met datatransformatie in SQL en Python
    - Implementaties gecoördineerd met offshore teams
    - Trainingen gegeven in Power BI, SQL, Python en Power Query aan grote groepen accountants
  ],
  date-from: "01/2021",
  date-to: "07/2023",
  label: "Resultaten",
  theme: custom-theme,
)

#experience(
  title: "Junior Staff Audit",
  subtitle: "Deloitte, Maastricht-Airport",
  task-description: [
    - Controlewerkzaamheden bij organisaties in o.a. zorg en corporate, zoals UMC en VolkerWessels
  ],
  date-from: "09/2019",
  date-to: "12/2020",
  label: "Resultaten",
  theme: custom-theme,
)

== Opleiding

#experience(
  title: "MSc Accounting & Control",
  subtitle: "Maastricht University",
  date-from: "2020",
  date-to: "2022",
  label: "",
  theme: custom-theme,
)

#experience(
  title: "BSc Accountancy",
  subtitle: "Zuyd Hogeschool, Sittard",
  date-from: "2015",
  date-to: "2019",
  label: "",
  theme: custom-theme,
)

// ─────────────────────────── Rechterkolom ───────────────────────────
#colbreak()

== Vaardigheden

#pill("Microsoft Fabric", fill: true, theme: custom-theme)
#pill("PySpark", fill: true, theme: custom-theme)
#pill("SQL (T-SQL, Synapse)", fill: true, theme: custom-theme)
#pill("dbt", fill: true, theme: custom-theme)
#pill("Python", fill: true, theme: custom-theme)
#pill("Dimensioneel modelleren", fill: true, theme: custom-theme)
#pill("Power BI / DAX", fill: true, theme: custom-theme)
#pill("Azure DevOps / Git", fill: true, theme: custom-theme)
#pill("Delta Lake", fill: true, theme: custom-theme)
#pill("PostgreSQL", theme: custom-theme)
#pill("Docker / Linux", theme: custom-theme)
#pill("Requirements-analyse", theme: custom-theme)

== Projecten

#project(
  title: "Homelab",
  subtitle: "Proxmox thuisserver, met diverse diensten",
  description: [
    - Dataplatform met Postgressql voor storage en Docker voor het draaien en beheersen ban Python diensten
    - Frigate als NVR voor beveiliging
    - Diverse netwerkdiensten, waaronder tailscale en Pihole
  ],
  date-from: "2025 - Heden",
  theme: custom-theme,
)

#project(
  title: "Home automation",
  subtitle: "Middels home assistant",
  description: [
    - Een centrale server voor de aansturing van IOT devices
    - Telemetrie wordt gesinkt in een timescaledb opgeslagen op de Proxmox server
  ],
  theme: custom-theme,
)
== Talen

#pill("Nederlands (moedertaal)", theme: custom-theme)
#pill("Engels (vloeiend)", theme: custom-theme)

== Interesses

#pill("Krachtsport", theme: custom-theme)
#pill("D&D (spelleider)", theme: custom-theme)
#pill("Beleggen", theme: custom-theme)
#pill("Technologie", theme: custom-theme)
#pill("Politiek", theme: custom-theme)
#pill("Technologie en AI", theme: custom-theme)
