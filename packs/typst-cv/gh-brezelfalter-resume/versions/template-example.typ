#import "../lib/util.typ": *

// Personal information (top block)
#let personal_details = (
  first_name: "Max",
  last_name: "Mustermann",
  date_of_birth: "01.01.1999",
  postal_code: "01234",
  city: "Musterstadt",
  street: "Musterstraße",
  number: "1",
  email: "max.muster@mustermail.muster",
  phone: "+49 987 12345678",
  picture_file: "media/profile.png"
)

// Resume contents by heading
#let education = (
  heading([= Education]),
  entry([1999 - 2010], 
    [
      *Highschool* \ 
      Example subtext
    ]
  ),
  entry([2012], 
    [*Other School*]
  )
)

#let work_experience = (
  heading([= Work experience]),
  entry([2015 - 2019], 
    [
      *Example experience* \ 
      Example subtext
    ]
  ),
  entry([2020], 
    [*Other experience*]
  )
)

#let qualifications = (
  heading([= Qualifications]),
  entry([Certificate example], 
    [
      *Example certificate* \ 
      Example certificate information text
    ]
  ),
  entry([Higher Certificate], 
    [
      *Other certifcate* \
      Example for other certifcate text
    ]
  )
)

#let hobbys = (
  heading([= Hobbys]),
  entry([Example hobby], 
    [
      *Details on hobby* \ 
      Example hobby details
    ]
  ),
  entry([Other hobby], 
    [
      *Details on other hobby* \
      Example for other hobby details
    ]
  )
)

// List of entries grouped by heading
#let entries = (
  ..education,
  ..work_experience,
  ..qualifications,
  ..hobbys
)