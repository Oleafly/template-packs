#import "/constants.typ": *
#import "/libs/risks.typ": highestrisk
#import structure: structure

#let introduce_client = {
    if longclient != none [#longclient (#client)] else [#client]
}

#let introduce_company = {
    if longcompany != none [#longcompany (#company)] else [#company]
}

#let contrib = contributors.first()

#introduce_client engaged #introduce_company to perform penetration testing on the x web application, with penetration testing being performed as part of the #client's due diligence.

Testing was performed from the 1st of February to the 31st of February, 2023.

== Scope

The scope of the penetration testing included:

=== Internal

The scope of the penetration testing included the following domains:

 - `corp.acme.com`

=== Wireless

The wireless SSIDs in scope were:

 - `ACME-Portal`
 - `ACME-Corp`
 - `ACME-Guest`

// Now we do some code to pull in the relevant sections
#(structure.overview_section)(
    folder: "root_cause_analysis"
)

#(structure.overview_section)(
    folder: "effective_security_practices"
)

#(structure.overview_section)(
    folder: "additional_recommendations"
)

== Conclusion

#company performed a penetration test on #client and discovered vulnerabilities that pose a *#highestrisk* risk to the organisation. We recommend remediating the vulnerabilities found in the report and addressing their root causes to protect the organisation from attacks.

We're here to help! If you find yourself needing assistance with fixing a vulnerability in this report or are unsure what the next step in your security strategy should be, reach out. #company's consultants are experts in the information security field who love to talk shop.

Thank you for letting us hack your web applications/external infrastructure/internal infrastructure and thank you for reading.

#contrib.contributor

- Email: #contrib.email
- Phone: #contrib.ph
