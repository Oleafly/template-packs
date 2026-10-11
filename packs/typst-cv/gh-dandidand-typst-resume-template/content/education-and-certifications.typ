#import "../utils.typ": translate

#let title = (
  es: [Educación y certificaciones],
  en: [Education and certifications],
)

#let institution1 = (
  name: translate((
    es: [Universidad],
    en: [University],
  )),
  location: [City, Country],
  roles: (
    (
      title: translate((
        es: [Ingeniero de software],
        en: [Software Engineer],
      )),
      period: [01/2025],
    ),
  ),
)

#let aws = (
  name: [Amazon Web Services (AWS)],
  location: "",
  roles: (
    (
      title: [AWS Certified Cloud Practitioner],
      period: [01/2025],
    ),
  ),
)

#let educationAndCertificationsList = (institution1, aws)

#let educationAndCertificationsDict = (
  title: translate(title),
  content: educationAndCertificationsList,
)
