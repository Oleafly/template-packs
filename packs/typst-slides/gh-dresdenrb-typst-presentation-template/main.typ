#import "@preview/touying:0.6.1": *
#import "theme/dresdenrb.typ": *
#import "theme/code.typ": init-code

#set figure(numbering: none)

#show: init-code.with()
#show: dresdenrb-theme.with(
  show-notes-on-second-screen: bottom,
  config-info(
    title: [
      Your title
    ],
    short-title: [Your short title],
    author: [You],
    date: datetime(year: 2026, month: 2, day: 26),
    institution: [Dresden.rb Ruby User Group],
    email: [Your email address],
  ),
)

#title-slide()

== First Slide

Regular Text

- List Level 1
  - List Level 2
    - List Level 3

== Code Slide

```ruby
class Meetup
  def initialize(participants)
    @participants = participants
  end
end
```
