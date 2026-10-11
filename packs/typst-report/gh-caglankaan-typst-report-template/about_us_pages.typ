
#import "coverpage.typ": cover-page
#let about-us-pages(CLIENT_NAME, DATE, ASSESMENT_NAME, CLIENT_DESCRIPTION) = [
#set page(
  margin: 2.5cm,
  numbering: "1",
  number-align: center,
  fill: rgb("#ebebeb"),
    footer: context[
            #line(length: 100%, stroke: rgb("#cfcfcf"))
            #text(style: "italic")[#ASSESMENT_NAME]
            #h(1fr)
            #counter(page).display("1/1", both: true)
        ]
        )
        


    #cover-page(CLIENT_NAME, DATE)

    #set page(
    margin: 2.5cm,
    numbering: "1",
    number-align: center,
    fill: rgb("#ebebeb"),
    header: [
        #image("images/caglansec_logo_5.png", height: 0.6cm, fit: "contain")
        #line(length: 100%, stroke: rgb("#cfcfcf"))
        ],
    footer: context[
        #line(length: 100%, stroke: rgb("#cfcfcf"))
            #text(style: "italic")[#ASSESMENT_NAME]
            #h(1fr)
            #counter(page).display("1/1", both: true)
        ]
        )
    
    #show raw.where(block: true): set text(
    font: "DejaVu Sans Mono",
    size: 0.8em,
    )

    #let show-draft = true

    #pagebreak()

    #set text(font: "Nimbus Sans", size: 12pt)
    #outline()
    #pagebreak()

    #text(25pt, font: "DejaVu Sans Mono")[= About Us]

    caglansec is an independent Web3 security engineering company 
    specializing in *smart contract security reviews* and *formal audit processes*. 
    Our core expertise is focused on Solidity and EVM ecosystems, while we also 
    provide professional assessments for **CosmWasm** and **Move** smart contracts.

    We combine manual code review, differential fuzzing, exploit path detection, 
    and threat modeling to ensure a comprehensive evaluation of protocol logic 
    and security-critical assumptions.

    Our mission is to protect decentralized systems from vulnerabilities that 
    could lead to financial loss, protocol instability, or centralization risks.

    #line(length: 100%, stroke: rgb("#cfcfcf"))

    #text(25pt, font: "DejaVu Sans Mono")[= About #CLIENT_NAME]
    #CLIENT_DESCRIPTION
    #line(length: 100%, stroke: rgb("#cfcfcf"))

    #text(25pt, font: "DejaVu Sans Mono")[= Disclaimer]

    This report represents a security review performed by caglansec based on 
    the source code and information provided by the client at the time of analysis.

    While best-effort techniques are applied to identify vulnerabilities, **we do not 
    guarantee the complete absence of security risks**, and new issues may emerge if 
    the protocol is modified after the review. 

    This assessment **does not replace continuous monitoring, code updates, runtime 
    security measures, or formal verification**. caglansec is not liable for 
    direct, indirect, or incidental damages resulting from the use of the reviewed 
    software.

    Clients are encouraged to perform additional reviews following major refactors, 
    infrastructure integrations, dependency upgrades, or deployment configuration changes.

    #pagebreak()


    #text(25pt, font: "DejaVu Sans Mono")[= Risk Classification]
    Below is the severity matrix based on the *likelihood* of exploitation and *impact* on the protocol or users.



    #v(0.5cm)

    #table(
    columns: 4,
    [*Severity Level*], [*Impact: High*], [*Impact: Medium*], [*Impact: Low*],

    [*Likelihood: High*], [Critical], [High], [Medium],
    [*Likelihood: Medium*], [High], [Medium], [Low],
    [*Likelihood: Low*], [Medium], [Low], [Low],
    )



    #v(1cm)

    == Impact
    - **High** — Loss of significant portion (>10%) of protocol assets or major harm to users.
    - **Medium** — Losses `<10%` or affecting a subset of users, unacceptable but localized.
    - **Low** — Annoying but bearable issues such as griefing or gas inefficiencies.

    #v(0.5cm)

    == Likelihood
    - **High** — Almost guaranteed to occur or easy to exploit.
    - **Medium** — Possible or incentivized, though requiring some effort.
    - **Low** — Requires rare conditions or minimal/no incentive to exploit.

    #v(0.5cm)

    == Action Required by Severity
    - **Critical** — Fix immediately (especially if deployed).
    - **High** — Fix before deployment (or ASAP if deployed).
    - **Medium** — Should fix during development cycles.
    - **Low** — Could fix if aligned with roadmap priorities.


    #pagebreak()




]