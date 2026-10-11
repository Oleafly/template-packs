#import "../config/constants.typ": figuresList, tablesList, acronymsList
#import "@preview/codelst:2.0.2": sourcecode
#set page(numbering: "i")

#heading(level: 1, numbering: none, outlined: true)[#tablesList]
#outline(
    title: none,
    target: figure.where(kind: table),
    indent: auto
)
//new page
#pagebreak()

#heading(level: 1, numbering: none, outlined: true)[#figuresList]
#outline(
  title: none,
  target: figure.where(kind: image)
)

#pagebreak()

#heading(level: 1, numbering: none, outlined: true)[List of Codes]
#outline(
  title: none,
  target: figure.where(kind: raw)
)



#pagebreak()
#let acronym(abbr, full) = {
  set par(spacing: 1.6em)
  [#grid(
    columns: (auto, auto, 10.5cm),
    text(weight: "bold")[#abbr],
    box(repeat[.]),
    full
  )]
}

#heading(level: 1, numbering: none, outlined: true)[#acronymsList]
#acronym("MQTT", "Message Queuing Telemetry Transport")
#acronym("CoAP", "Constrained Application Protocol")
#acronym("IoT", "Internet of Things")
#acronym("BLE", "Bluetooth Low Energy")
#acronym("LoRa", "Long Range")
#acronym("LoRaWAN", "Long Range Wide Area Network")
#acronym("NB-IoT", "Narrowband Internet of Things")
#acronym("AES-CCM", "Advanced Encryption Standard - Counter with CBC-MAC")
#acronym("MAC", "Message Authentication Code")
#acronym("TCP", "Transmission Control Protocol")
#acronym("mTLS", "Mutual Transport Layer Security")
#acronym("M2M", "Machine to Machine")
#acronym("IAM", "Identity Access Management")
#acronym("HA", "High Availability")
#acronym("IDS", "Intrusion Detection Systems")
#acronym("ReBAC", "Relationship-Based Access Control")
