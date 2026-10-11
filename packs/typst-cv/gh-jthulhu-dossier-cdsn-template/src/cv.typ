#import "@preview/modern-cv:0.9.0": *

#show: resume.with(
    author: (
        firstname: "Prénom",    // TODO
        lastname: "Nom",        // TODO
        email: "email@per.so",  // TODO
        phone: "le numéro de Père Noël", // TODO (optionnel)
        github: "microsoft",             // TODO (optionnel)
        positions: ("Student in Computer Science at ÉNS",), // TODO si vous ne voulez rien mettre, remplacez par `()`
    ),
    use-smallcaps: false,
    profile-picture: none,      // TODO (optionnel) vous pouvez mettre une image
    date: datetime.today().display(), // TODO vous pouvez fixer la date
)

= About me
#lorem(40)

= Education

#resume-entry(
    title: [Parisian Master of Research in Comupter Science (MPRI)],
    location: [Paris],
    date: [2024/2025],
    description: [
        #lorem(20)
    ],
)

#resume-entry(
    title: [Second year ÉNS Computer Science Curriculum],
    location: [Paris],
    date: [2023/2024],
    description: [
        #lorem(20)
    ],
)

= Research internships
#resume-entry(
    title: [Faire des cadeaux],
    date: [décembre 2025],
    location: [Pôle nord],
    description: [
        Stage centré sur le don, supervisé par le Père Noël.
    ],
)

= Additional experience
#resume-entry(
    title: [École de Printemps sur la Piraterie théorique et appliquée],
    date: [XVII#super[ème] siècle],
    location: [Caraïbes],
    description: [
        J'ai surtout appris à attirer des chiens avec des os.
    ],
)

// Local Variables:
// typst-preview--master-file: "./cv.typ"
// End:
