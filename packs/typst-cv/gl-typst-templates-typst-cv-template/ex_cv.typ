#import "main.typ" :*

#show : resume.with(
  col: rgb("D991BA"),
  font: "Arial",
  // footer:"",
  author : (
    firstname:"first name",
    lastname: "last name",
    birthdate: "xx-xx-xxx",
    nationality: "xxxx",
    address: [Bureau X,\ Y University],
    mail:"mail@mail.mail",
    tel:"Phone Number",
    twitter: "username"
  ),
  // profile-picture: "image(path_to_image.png)",
   about-me: [
    #lorem(40)
  ],
  education: (
    (
      degree:"Degree",
      comments:"comment",
      startdate:"Start date",
      enddate:"End date",
      place:"Location"
    ),
  ),
  experiences: (
    (
      name: "Experience",
      comments: "comment",
      startdate: "Start Date",
      enddate: "End date",
      place:"Location"
    ),
  ),
  languages: (
    (
      lang: "Language",
      level: "Level"
    ),
  ),
  programming-languages: (
    (
      lang:"CSS/HTML"
    ),
    (
      lang:"Python"
    ),
  ),
  prices-grant: (
    (
      name:"Grant",
      date:"Date",
      comments:"Small comments"
    ),
  ),
  hobbies: [I have a lot of hobbies.],
  papers:(
    (name:"Article name",
    authors:[authors names],
    date:"Date",
    journal:"Journal"
    ),
  )
)