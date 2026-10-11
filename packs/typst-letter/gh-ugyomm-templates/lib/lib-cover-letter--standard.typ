/**
 * 
 * Copyright 2025 uGyomm
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the “Software”), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies
 * or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
 * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


/**
 * templates
 * lib-cover-letter--standard.typ
 * 
 * Purpose
 * -------
 * 
 * This typesetting file (.typ) provides a standard cover letter template.
 * 
 */


// CONSTANTS 
// ---------
#let NBSP=sym.space.nobreak //non-breaking space

/**
 * Generates a standard cover letter.
 * 
 * Parameters
 * ----------
 * first_name         : Applicant's first name
 * last_name          : Applicant's last name
 * town               : Applicant's town of residency
 * country            : Applicant's country of residency
 * telephone_number   : Applicant's telephone number
 * mail_address       : Applicant's mail address
 *  
 * to_company         : Company applied to
 * to_entity          : Entity to which/whom the application is addressed
 * to_address         : Company's address
 * to_postal_code     : Company's postal code
 *  
 * from_town          : Town from which the cover letter has been addressed
 * at_date            : Date at which the cover letter has been addressed
 * 
 * application_id     : Application's identifier
 * application_title  : Application's title
 * 
 * greeting           : Greeting expression
 * to_recipient       : Recipient to whom the greeting is addressed
 * salutation         : Salutation expression
 * signature          : Relative path which points to the image to use as a signature
 * signature_width    : Signature's width
 * body               : Sinking argument to provide cover letter content as paragraphs
 * 
 * Notes
 * -----
 * All named arguments are optional. If an named argument is not specified, its default * value will be used.
 * 
 * Body font should be overridden according to the fonts' available to the applicant.
 * 
 * Signature width should be overridden according to the applicant's signature. 
 * 
 */
#let cover-letter(
  first_name:"John",
  last_name:"Doe",
  town:"town",
  country:"country",
  telephone_number:"+xxx-xx-xx-xx-xx",
  mail_address:"@mail.com",
  
  to_company:"Addressed to company:",
  to_entity:"Addressed to the Human Resources Department",
  to_address:"Addressed to residency and residency number",
  to_postal_code:"Residency located in:",
  from_town:"Addressed from following location",
  at_date:"Day(XX) Month Year(YYYY)",

  application_id:"JOBID123456789",
  application_title:"Job Title",

  greeting:"Dear",
  to_recipient:"Mr - Mrs ",
  salutation:"Sincerely",
  signature:"../resources/signature.png",
  signature_width:150pt,

  body_font:"Helvetica",
  body
)={
  
  set text(font:"Calibri",size: 11pt)
    grid(
    columns: (1fr,1fr),
    rows:(2em,1em,1em,3em,1em,1em,1em,1.5em,2em),
    align: (left,right),

    grid.cell(
      x:0,
      y:0,
    )[#text(first_name,size:18pt,weight:450)#NBSP#text(last_name,size:18pt,weight:450)],

    grid.cell(
      x:0,
      y:1,
    )[#text(town),#NBSP#text(country)],

    grid.cell(
      x:0,
      y:2,
    )[#text(telephone_number)]
    
    ,grid.cell(
      x:0,
      y:3,
    )[#text(mail_address)]

    ,grid.cell(
      x:1,
      y:4,
    )[#text(to_company)]

    ,grid.cell(
      x:1,
      y:5,
    )[#text(to_entity)]

    ,grid.cell(
      x:1,
      y:6,
    )[#text(to_address)]

    ,grid.cell(
      x:1,
      y:7,
    )[#text(to_postal_code)]

  ,grid.cell(
      x:1,
      y:8,
    )[#text(fill: color.gray)[#from_town, #at_date]]

  ,grid.cell(
      x:0,
      y:9,
    )[#text(fill: color.gray)[Reference : #application_id#NBSP ·#NBSP #application_title]]
  )

  set text(font:body_font,size:11pt)
  text()[#greeting#NBSP#to_recipient,]
  parbreak()
  set par(
    first-line-indent:1.5em,
    spacing:2em,
    justify:true,
    linebreaks:"optimized"
  )
  body

    v(1.5em)
  grid(
    columns: (1fr,1fr),
    rows:(2em,1em,1fr),
    align: (left,right),

    grid.cell(
      x:0,
      y:0,
    )[#text()[#salutation,]]

    ,grid.cell(
      x:1,
      y:1,
    )[#first_name#NBSP#last_name]

    ,grid.cell(
        x:1,
        y:2,
      )[#block[#place(right,float:false,dx:30pt,dy:5pt,image(signature,width:signature_width))]]

  )

}