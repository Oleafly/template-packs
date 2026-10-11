#import "/constants.typ": client, company, longcompany, longclient, contributors
#let contrib = contributors.first()

#let introduce_client = {
    if longclient != none [#longclient  (#client)] else [#client]
}

#let introduce_company = {
    if longcompany != none [#longcompany (#company)] else [#company]
}

#introduce_client engaged #introduce_company to perform penetration testing against /*insert what you did here*/

/* Make sure to think about the last sentence in this if you have a 0 finding report */
#company embraced the ethos of real-world attackers, employing a hacker's mindset and tools to scrutinise in-scope systems and identify vulnerabilities that could present risk. By adopting this perspective, #company uncovered vulnerabilities that might have otherwise gone unnoticed.

/*
Alright, time to write an executive summary. Here's some good dot-points to remember:

- Put requests **before** justifications.
- Answers **before** explanations.
- Conclusions **before** discussions.
- Summaries **before** details.
- The general **before** the specific.

Good luck :)
*/

For more information about this report, the identified vulnerabilities, and additional services that could help you in your security journey, please contact your #company consultant:

#contrib.contributor

- Email: #contrib.email
- Phone: #contrib.ph
