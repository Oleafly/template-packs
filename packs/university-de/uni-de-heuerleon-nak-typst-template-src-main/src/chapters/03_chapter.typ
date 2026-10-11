#import "../components/formatting.typ": clickable_link, needsCite, todo

= Using some common document features

+ You can start a simple enumeration by using `+` in Typst
+ This will be one more line
+ #lorem(20)

Here is some more dummy text to fill the page Here is some more dummy text to fill the page Here is some more dummy text to fill the page as you can see in @code-snippet. This is a reference to the appendix code listing.

Oh no, the following statement doesn't have any reliable source yet #needsCite.

Normal list.
- Text
- Math
- Layout
- ...

Here is a text explaining some important stuff but there is something that needs a footnote, for example the word abcd#footnote([abcd stands for "absolutely brilliant cool design", see #clickable_link("https://nordakademie.de")]). If we want to add a link inside the text, we #clickable_link("https://nordakademie.de",display: "can do so").

#todo("This is a cool way to add todos to your paper that you won't overlook")