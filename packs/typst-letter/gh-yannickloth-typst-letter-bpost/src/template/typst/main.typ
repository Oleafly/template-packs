//#import "@local/bpostletter:0.0.1": letter-simple
#import "../../main/typst/bpostletter.typ": letter-simple
#set text(lang: "fr")

#show: letter-simple.with(
  recipient: (
    addresseeIndividualIdentification: ( // Mandatory if addressed mail
      formOfAddress: "Me", // Greeting
      givenName: "Norman", // First Name
      surname: "Laimer", // Last Name
      supplDispatchInfo: none // Customer Number; Only if bpack 24/7
    ),
    maileeIndividualIdentification: ( // If applicable
      roleDescriptor: none,
      formOfAddress: "Miss",
      givenName: "Alpine", // First Name
      surname: "Bayer", // Last Name
      extra: none, // TODO: DO WE NEED THIS?
    ),
    maileeOrganizationIdentification: ( // If applicable
      function: "Super Manager", // Title
      organizationalUnit: "People Team", // Department
      organizationName: "Co Company", // Company Name
      legalStatus: "LLC",
    ),
    mailRecipientDispatchingInformation: (
      building: ( // Optional, but preferable for Registered mail and Parcels
        wingType:none,
        wingIndicator: none,
        stairwellType: none,
        stairwellIndicator: none,
        floorType: none,
        floorIndicator: none,
        doorType: none,
        doorIndicator: none
      ),
      buildingLevel1: none // Complex of buildings ‐‐ used to reference industrial zones
    ),
    otherDeliveryInformation: ( // PO Box Number or “bpack 24/7” name
      deliveryServiceType: none, // Possible values: ‘Postbus’ or ‘Boite Postale’ or ‘PB’ or ‘BP’ or  ‘bpack
      deliveryServiceIndicator:none // PO Box number or bpack station name
    ),
    deliveryPointLocation: (
      thoroughfareName: "rue du Bois", // Street Name
      streetNumberOrPlot: 82, // House Number
      extensionDesignation: none, // Box Number
    ),
    postCodeTown: (
      postCode: 9785, // Mandatory
      city: (
        town: "Oûtesîploût", // Mandatory
        deliveryServiceQualifier: none, // When PO Box
      ),
    ),
    country: "BELGIUM", // Only for cross‐border mail
  ),
  sender: (
    addresseeIndividualIdentification: ( // Mandatory if addressed mail
      formOfAddress: "Pr", // Greeting
      givenName: "Sandon", // First Name
      surname: "Branderson", // Last Name
      supplDispatchInfo: none // Customer Number; Only if bpack 24/7
    ),
    maileeIndividualIdentification: ( // If applicable
      roleDescriptor: none,
      formOfAddress: "Mr",
      givenName: "Kennet", // First Name
      surname: "Foll" // Last Name
    ),
    maileeOrganizationIdentification: ( // If applicable
      function: "Chief editor", // Title
      organizationalUnit: "Writers", // Department
      organizationName: "The Book Co.", // Company Name
      legalStatus: "LLC",
    ),
    mailRecipientDispatchingInformation: (
      building: ( // Optional, but preferable for Registered mail and Parcels
        wingType:"Bâtiment",
        wingIndicator: "Maison Rouge",
        stairwellType: none,
        stairwellIndicator: none,
        floorType: none,
        floorIndicator: none,
        doorType: none,
        doorIndicator: none
      ),
      buildingLevel1: none // Complex of buildings ‐‐ used to reference industrial zones
    ),
    otherDeliveryInformation: ( // PO Box Number or “bpack 24/7” name
      deliveryServiceType: none, // Possible values: ‘Postbus’ or ‘Boite Postale’ or ‘PB’ or ‘BP’ or  ‘bpack
      deliveryServiceIndicator:none // PO Box number or bpack station name
    ),
    deliveryPointLocation: (
      thoroughfareName: "avenue des Chenilles", // Street Name
      streetNumberOrPlot: 55, // House Number
      extensionDesignation: none, // Box Number
    ),
    postCodeTown: (
      postCode: 4682, // Mandatory
      city: (
        town: "Citypolis", // Mandatory
        deliveryServiceQualifier: none, // When PO Box
      ),
    ),
    country: "BELGIUM", // Only for cross‐border mail
    email: "someone@example.com",
    mobile: "+32 444 28 58 88"
  ),
  cross-border: false,
  annotations: [annotations Einschreiben - Rückschein],
  information-box: "information-box",
  reference-signs: (([Vos références], [333/24692/5775]),),

  subject: lorem(10),
  title: lorem(6),
  salutations: [Madame, Monsieur,],
  considerations: [Bien cordialement,],
  post: [*Anlagen:*

    - Rechnung],
)

#lorem(100)

#lorem(30)

#lorem(15)




