#import "/Templates/template-resume.typ": *

// who when where how why + final result
// quantitatif et qualitatif

#show: resume.with(
  gparams: (
    firstname: "El Haddadi",
    lastname: "Bilèle",
    lang: "fr",
    position: (
      "Ingénieur informatique",
      "Étudiant ENSEEIHT",
    ),
    picture: image("Assets/picture.jpg", width: 100%),
    show_picture: true,
    contact: (
      (image("Assets/mail.svg"), "bilele.elhaddadi@gmail.com"),
      (image("Assets/github.svg"), "TooLoss"),
      (image("Assets/linkedin.svg"), "bilele-elhaddadi")
    )
  )
)

/* education */

#new_section("Education")

#new_infos("École Nationale Supérieure des Télécommunications",
           ("Master Cybersécurité", "Réseaux, Cryptographie, Sécurité des Systèmes"),
           "75013 - Paris", (1, "2010"), (2, "2012"),
           ("Certification : Expert en Sécurité des Réseaux",))

#new_infos("Université Paris-Saclay",
           ("Licence Informatique", "Développement Logiciel, Intelligence Artificielle"),
           "91190 - Gif-sur-Yvette", (1, "2005"), (3, "2008"),
           ("Projet de fin d'études : Système de recommandation",))


#new_infos("Lycée Alfred Kastler",
              ("Baccalauréat Général", "Maths Physique"), 
              "95600 - Cergy", (1, "2000"), (2, "2001"),
              ("Réseaux",))

/* exprience */

#new_section("Expérience")

#new_infos("Innovatech",
           ("Chef de Projet IT", "Gestion d'équipes agiles, solutions logicielles sur mesure"),
           "13001 - Marseille", (1, "2023"), (0, "Présent"),
           ("Projets récents : Déploiement d'une plateforme SaaS pour 500+ utilisateurs, certification Scrum Master",))

#new_infos("DataInsights SAS",
           ("Analyste Données", "Collecte et analyse de données clients"),
           "92000 - Nanterre", (3, "2015"), (5, "2018"),
           ("Réalisations : Réduction des coûts marketing de 15% grâce à l'analyse prédictive",))
           
#new_infos("TechSolutions Inc.",
           ("Développeur Full-Stack", "Développement d'applications web"),
           "75009 - Paris", (6, "2018"), (12, "2022"),
           ("Projets clés : Migration vers une architecture microservices, optimisation des performances (+30% de rapidité)",))
              
/* projects */

#new_section("Projects")

#new_project("E-Commerce Platform Redesign",
              ("Developed a scalable e-commerce backend using Node.js and React for a retail client in Paris, France. Implemented payment gateways, user authentication, and real-time inventory updates. Reduced page load time by 40% and increased conversion rates by 20%.", "Tech Stack: Node.js, React, MongoDB, AWS"))

#new_project("AI-Powered Chatbot for Customer Support",
              ("Led a team of 4 to design and deploy an AI chatbot for a telecom company in Lyon, France. Trained the model on historical customer queries, integrated it with their CRM, and reduced response time by 60%. Published findings at a national tech conference.", "Tools: Python, TensorFlow, NLP, Dialogflow"))



/* skills */

#new_section("Skills")

#new_skill("Languages :", ("C++", "Java", "Python"))
#new_skill("Soft Skills :", ("Anglais", "Français", "Travail d'équipe"))

#new_skill("Certifications :", ("Certification AWS Cloud Practitioner", "Certification Scrum Master (PSM I)", "Google IT Support Professional"))
#new_skill("Hobbies :", ("Photographie argentique", "Randonnée en montagne", "Développement de jeux vidéo indie", "Cuisine végétarienne"))
