#let meta = (
  title: "Titel",
  short-title: none,
  subtitle: "Untertitel",
  date: datetime.today().display("[day].[month].[year]"),
  git-hash: sys.inputs.at("git-hash", default: none),
  authors: ("Autor1", "Autor2"),
  advisor: "Referent",
  co-advisor: "Koreferent",
  gegenleser: "Gegenleser",
  top-right-logo: image(
    "resources/OST-Logo.png",
    width: auto,
    height: 15mm,
    fit: "cover",
  ),
  background: image(
    "resources/Background.png",
    width: 245mm,
    height: auto,
    fit: "cover",
  ),
  overlay: image(
    "resources/Overlay.png",
    width: 210mm,
    height: 300mm,
    fit: "cover",
  ),
)
