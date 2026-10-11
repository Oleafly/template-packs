#import "/templates/common-functions/includes.typ": default_outline as outline, code

#let priorities = (
    "Low",
    "Medium",
    "High"
)

#let impacts = (
    "Low",
    "Moderate",
    "Severe",
    "Critical",
)

#let risks = (
    "Low",
    "Medium",
    "High",
    "Critical",
)

#let likelihoods = (
    "Rare",
    "Unlikely",
    "Possible",
    "Likely",
)

#let risk_matrix = (
   "Rare": (
       "Critical": "Medium",
       "Severe":   "Low",
       "Moderate": "Low",
       "Low":      "Low",
   ),
   "Unlikely": (
       "Critical": "High",
       "Severe":   "Medium",
       "Moderate": "Medium",
       "Low":      "Low",
   ),
   "Possible": (
       "Critical": "Critical",
       "Severe":   "High",
       "Moderate": "Medium",
       "Low":      "Low",
   ),
   "Likely": (
       "Critical": "Critical",
       "Severe":   "High",
       "Moderate": "High",
       "Low":      "Medium",
   )
)

#let vulnerability_titles = (
  singular: "Vulnerability",
  plural: "Vulnerabilities"
)
