#import "../lib.typ" as brief
#import "../extensions/attractor.typ" as attractor
#import "component-catalog.typ": component-catalog

#let config = brief.theme-config(
  canvas: brief.canvas(..brief.standard-canvas),
  palette: brief.palette(accents: brief.palettes.semantic),
  typography: brief.typography(),
  brand: brief.brand(),
  background: attractor.provider(mode: "cached"),
)
#let info = brief.metadata(
  title: [Technical Brief Component Reference],
  subtitle: [Standard 16:9 · complete component catalog],
  author: [DeepLink Community],
  institution: [Open technical communication · examples/standard.typ],
  date: datetime(year: 2026, month: 8, day: 9),
)

#show: brief.theme.with(config: config, metadata: info)

#component-catalog(
  profile-name: [Standard 16:9],
  canvas-label: [19.2 cm × 10.8 cm],
  sample-images: (
    "/assets/attractor/standard/dark-1.svg",
    "/assets/attractor/standard/dark-2.svg",
    "/assets/attractor/standard/dark-3.svg",
    "/assets/attractor/standard/dark-4.svg",
    "/assets/attractor/standard/dark-5.svg",
  ),
)
