#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": chart
#import "settings.typ": low-color, medium-color, high-color, critical-color

#let barColors = cetz.palette.new(colors: (
  low-color,
  medium-color,
  high-color,
  critical-color,
))

#let formatData(data) = {
  let vulnBySystem = (:)

  for vuln in data.vulnerabilities {
    if vuln.system in vulnBySystem {
      let vulnBySeverity = vulnBySystem.at(vuln.system, default: (:))
      if vuln.severity in vulnBySeverity {
        vulnBySystem.at(vuln.system).at(vuln.severity) += 1
        continue
      }
      vulnBySystem.at(vuln.system).insert(vuln.severity, 1)
      continue
    }
    vulnBySystem.insert(vuln.system, (vuln.severity: 1))
  }

  let graphData = ()

  for (system, vulnCount) in vulnBySystem {
    let lowVulns = vulnCount.at("Low", default: 0)
    let mediumVulns = vulnCount.at("Medium", default: 0)
    let highVulns = vulnCount.at("High", default: 0)
    let critVulns = vulnCount.at("Critical", default: 0)

    let cluster = (system, lowVulns, mediumVulns, highVulns, critVulns)
    graphData.push(cluster)
  }

  return graphData
}

#let makeVulnGraph(data) = {
  let formattedData = formatData(data)

  return figure()[
    PRINCIPAIS RISCOS
    #cetz.canvas(
      length: 4cm,
      {
        chart.columnchart(
          size: (4, 1.5),
          mode: "stacked",
          value-key: (1, 2, 3, 4),
          y-tick-step: 1,
          bar-style: barColors,
          legend: "south",
          legend-style: (
            orientation: ltr,
            spacing: 0.15,
            item: (
              spacing: 0.2,
              preview: (
                width: 0.1,
                height: 0.1,
                margin: 0.03,
              ),
            ),
          ),
          labels: ([Baixo], [Médio], [Alto], [Crítico]),
          formattedData,
        )
      },
    )
  ]
}
