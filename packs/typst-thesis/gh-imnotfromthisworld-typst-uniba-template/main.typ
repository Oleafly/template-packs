#import "template.typ": thesis
#import "abstract.typ": abstract, abstrakt
#import "intro.typ": intro
#import "chapter1.typ": chapter1
#import "chapter2.typ": chapter2
#import "conclusion.typ": conclusion
#import "acknowledgement.typ": acknowledgement
#import "app1.typ": app1
#import "app2.typ": app2

/// Change to your heart's content
#show: thesis.with(
    // lang: "sk",
    title: [The Greatest Title of Them All],
    author: [Me, Myself and I],
    place: [Bratislava],
    university: [Comenius University in Bratislava],
    faculty: [Faculty of Mathematics, Physics and Informatics],
    study_programme: [Computer Science],
    field: [Computer Science],
    department: [Department of Computer Science],
    supervisor: [John Supervisor],
    date: [1984],
    abstract: (abstrakt, abstract),
    acknowledgement: acknowledgement,
    intro: intro,
    conclusion: conclusion,
    chapter: (chapter1, chapter2),
    appendix: (app1, app2),
)
