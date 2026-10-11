#import "utils.typ": conf, header, section
#import "main.typ": margin_x, margin_y, name_font_size, info_font_size, heading_font_size, name_font, info_font, heading_font, body_font, name, loc, phone, email, website, linkedin, github, info_font, info_font_size, header_style, name_color, heading_color, show_icons

#let body_font_size = 12pt

#show: doc => conf(
  margin_x, margin_y,
  name_font_size, info_font_size, heading_font_size, body_font_size,
  name_font, info_font, heading_font, body_font,
  name_color, heading_color, show_icons,
  doc
)

#header(
  name, loc, phone, email, website, linkedin, github,
  info_font, info_font_size, header_style, show_icons
)

#section("")
\
*August 10, 20XX*

Hiring Manager \
Some Really Cool Company \
Place, Somewhere, Really Cool 12345

*Subject: My Very Cool Job Application*

Dear Hiring Manager,

\

Sincerely,

First Last


