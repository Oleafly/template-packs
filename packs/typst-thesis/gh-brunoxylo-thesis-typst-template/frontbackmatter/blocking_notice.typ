#let blockingNotice(title: "Sperrvermerk", layoutConfig: none) = {
  show: layoutConfig

  heading(numbering: none, outlined: false, bookmarked: true, title)

  v(1em)

  text()[
    Diese Abschlussarbeit darf nur von der Referentin/ dem Referenten, der Korreferentin \/ dem Korreferenten sowie den vom Prüfungsausschuss dazu beauftragten Hochschulangehörigen eingesehen werden. Sie darf ohne ausdrückliche Zustimmung des Autors weder vollständig noch auszugsweise vervielfältigt, veröffentlicht oder Dritten zugänglich gemacht werden. Die Durchführung des Kolloquiums bleibt von der Geheimhaltung unberührt. Die Geheimhaltungsverpflichtung erlischt fünf Jahre nach Einreichung automatisch. \
  ]
}
