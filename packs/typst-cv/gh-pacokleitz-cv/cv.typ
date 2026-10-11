#show heading: set text(font: "Linux Biolinum")

// Uncomment the following lines to adjust the size of text
// The recommend resume text size is from `10pt` to `12pt`
// #set text(
//   size: 12pt,
// )

// Feel free to change the margin below to best fit your own CV
#set page(
  margin: (x: 0.9cm, y: 1.3cm),
)

// For more customizable options, please refer to official reference: https://typst.app/docs/reference/

#set par(justify: true)

#let chiline() = {v(-3pt); line(length: 100%); v(-5pt)}

= Paco Kleitz

kpaco\@proton.me |
#link("https://github.com/pacokleitz")[github.com/pacokleitz] | 
#link("https://kpaco.dev")[kpaco.dev] |
#link("https://linkedin.com/in/pacokleitz")[linkedin.com/in/pacokleitz]

DevOps/SRE Engineer specializing in Kubernetes and multi-cloud infrastructure. 3+ years optimizing cloud costs, security, reliability, and deployment operations for fast-growing startups.

== Work Experience
#chiline()

*DevOps/SRE Engineer* #h(1fr) 09/2023 -- Present \
#link("https://kili-technology.com")[\@Kili Technology] #h(1fr) Remote / Paris, France \
Tech Stack → Kubernetes, GCP, Azure, Terraform, Ansible, GitLab CI/CD, Python, NodeJS, Datadog
- Cut GCP and Azure cloud costs by 50% through resource optimization and automated scaling strategies.
- Partnered with enterprise customers to design and deploy private on-premise installations of Kili's data labeling platform, adapting infrastructure for strict security requirements including air-gapped environments.
- Owned vulnerability management across all services, supporting successful ISO 27001 and SOC 2 compliance audits.

*DevOps/SRE Engineer* #h(1fr) 09/2023 -- 04/2025 \
#link("https://www.deepip.ai")[\@DeepIP] #h(1fr) Remote / Paris, France \
Tech Stack → Kubernetes, Azure, Terraform, Ansible, GitLab CI/CD, Python, Datadog
- Scaled cloud infrastructure and new services from proof of concept to Series A (\~\$15M funding).
- Managed Azure OpenAI model deployments and infrastructure automation using Terraform.

*DevOps/SRE Engineer* #h(1fr) 09/2022 -- 09/2023 \
#link("https://troops.fr")[\@Troops] #h(1fr) Remote / Lyon, France \
Tech Stack → Kubernetes, AWS, Terraform, Ansible, CircleCI, NodeJS, Datadog
- Led Kubernetes cluster components upgrades and maintained AWS cloud infrastructure through infrastructure-as-code.
- Expanded observability and monitoring coverage by deploying Datadog synthetic monitoring across critical services.
- Strengthened Kubernetes security with Kyverno policy enforcement and automated vulnerability scanning.

*Surgical Data Science R&D Software Engineer* #h(1fr) 09/2021 -- 09/2022 \
#link("https://ircad.fr")[\@IRCAD] #h(1fr) Strasbourg, France \
Tech Stack → On-Premise VMs, Python, SLURM, GitLab CI/CD, Ansible
- Led development of a web platform for evaluating ML model performance in medical computer vision applications.
- Trained, benchmarked, and compared computer vision models (YOLO, DETR, UNET) for surgical instrument detection.
- Designed and deployed a GPU-enabled Python inference service unifying multiple model formats (ONNX, TorchScript).

== Education
#chiline()

*University of Strasbourg* #h(1fr) \
Master of Software Science and Engineering #h(1fr) \

*University of Strasbourg* #h(1fr) \
Bachelor of Computer Science #h(1fr) \

== Skills
#chiline()

*DevOps:* Kubernetes, GCP, Terraform, Docker, AWS, Azure, Ansible, Datadog, CI/CD, ArgoCD, Nginx, Postgres, Git, Linux \
*Programming:* Go, Python, Rust, TypeScript, Bash, C, SQL \
*Areas:* Distributed Systems, Back-End Development, Machine Learning, AI, Blockchain

== Certifications
#chiline()

- #link("https://www.credly.com/badges/f63dc989-0b2d-4a0f-9d08-96ebdcd5a316")[Certified Kubernetes Administrator (CKA)]

== Languages
#chiline()

- French: Native proficiency
- English: Fluent (Professionally)
- German: Proficient (Bilingual school education)
