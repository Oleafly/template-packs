#import "@preview/nth:1.0.1": nth

#let CURRENT_DAY = datetime.today()

#let OLDNAME = [Old Name]
#let NEWNAME = [New Name]
#let CITY = [City]
#let COUNTY = [County]
#let POSTCODE = [Postcode]
#let ADDRESS = [Street Address]

#let WITNESS1 = [Witness One]
#let WITNESS1_ADDRESS = [Address]
#let WITNESS1_POSTCODE = [Postcode]

#let WITNESS2 = [Witness Two]
#let WITNESS2_ADDRESS = [Address]
#let WITNESS2_POSTCODE = [Postcode]

#align(center, text(20pt)[
  *Deed of Change of Name*
])

#v(30pt)

#smallcaps[By this Deed of Change of Name] made by myself the undersigned #NEWNAME of #ADDRESS, #CITY,
#POSTCODE, in the county of #COUNTY, formerly known as #OLDNAME, a British Citizen under section 1(1) of the British
Nationality Act 1981.

#v(10pt)

*I hereby declare as follows:*

#v(10pt)

*I. #h(5pt) #smallcaps[I absolutely]* and entirely renounce, relinquish, and abandon the use of my said former name #OLDNAME and
assume, adopt, and determine to take and use from the date hereof the name of #NEWNAME in substitution for my former
name of #OLDNAME.

#v(20pt)

*II. #h(5pt) #smallcaps[I shall at all times]* hereafter in all records, deeds, documents, and other writings and in all
actions and proceedings, as well as in all dealings and transactions, and on all occasions whatsoever use and subscribe
the said name of #NEWNAME as my name, in substitution for my former name of #OLDNAME so relinquished as aforesaid to the
intent that I may hereafter be called, known, or distinguished not by the former name of #OLDNAME but by the name
#NEWNAME.

#v(20pt)

*III. #h(5pt) #smallcaps[I authorise and require]* all persons at all times to designate, describe, and address me by
the adopted name of #NEWNAME.

#v(20pt)

*#smallcaps[In witness]* whereof I have hereunto subscribed my adopted and substituted name of #NEWNAME and also my said
former name of #OLDNAME.

Notwithstanding the decision of Mr Justice Vaisey in re Parrott, Cox v Parrott [1946] Ch 183, the applicant wishes the
enrolment to proceed.

*#smallcaps[Signed as a Deed this #nth(CURRENT_DAY.day()) day of #CURRENT_DAY.display("[month repr:long]") in the year #CURRENT_DAY.year()]*

#let SIGNATURE_LINE = {
  box[
    #underline(stroke: (dash: "dotted", thickness: 1pt))[
      #for value in range(700) {
        sym.space.hair
      }
      #h(0.000001pt)
    ]
  ]
}

#v(100pt)

#stack(dir: ltr, block(width: 50%)[
  #align(center, [
    #SIGNATURE_LINE \
    By the above name\ #NEWNAME

    #v(60pt)

    #SIGNATURE_LINE \
    #WITNESS1 \
    #WITNESS1_ADDRESS, #WITNESS1_POSTCODE \
  ])
], block(width: 50%)[
  #align(center, [
    #SIGNATURE_LINE \
    By the above name\ #OLDNAME

    #v(60pt)

    #SIGNATURE_LINE \
    #WITNESS2 \
    #WITNESS2_ADDRESS, #WITNESS2_POSTCODE \

  ])
])