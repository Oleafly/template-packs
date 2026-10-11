#import "utils.typ": fill_instance_with_default

#let ME = (
  name: none,
  email: none,
  phone: none,
  website: none,
  linkedin: none,
  github: none,
  stackoverflow:none,
  google_scholar: none
)

#let JOHNDOE = (
  name: "John Doe",
  location: none,
  phone: "123-456-7896",
  email: "john.doe@example.com",
  website: "https://www.example.com",
  linkedin: "https://www.linkedin.com/in/johndoe",
  github: "https://github.com/johndoe",
  stackoverflow: "https://stackoverflow.com/users/1234567/johndoe?tab=profile",
  google_scholar: none
)

#let read_me(filename) = {
  let result = yaml(filename)
  let filled_me = fill_instance_with_default(result, default: ME)
  filled_me
}

#let make_me_bold(name, me: "Doe, J") = {
  if name == me {
    text(weight: "bold", name)
  } else {
    name
  }
}
