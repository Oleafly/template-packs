// ── Application Target ────────────────────────────────────────────────────────
// Not rendered — for your reference only

#let target-company = "Company Name"
#let target-role    = "Job Title"
#let target-job-id  = "JOB-ID"


// ── Summary ───────────────────────────────────────────────────────────────────

#let summary = "Cloud engineer with 5+ years of experience designing, deploying, and operating large-scale infrastructure on AWS and GCP. Proven track record building resilient distributed systems, automating infrastructure with Terraform and Kubernetes, and driving cost efficiency across multi-region environments. Strong collaborator across platform, security, and product teams."


// ── Skills ────────────────────────────────────────────────────────────────────

#let skills = (
  (label: "Languages",      items: "Python, Go, Bash, TypeScript, SQL, YAML"),
  (label: "Cloud & Infra",  items: "AWS (EC2, S3, RDS, Lambda, EKS, VPC, IAM, CloudWatch), GCP (GKE, Cloud Run, BigQuery, Cloud Storage), Azure (AKS, Blob Storage)"),
  (label: "DevOps & Tools", items: "Terraform, Kubernetes, Helm, Docker, Ansible, GitHub Actions, Jenkins, ArgoCD, Prometheus, Grafana, Datadog"),
)


// ── Experience ────────────────────────────────────────────────────────────────

#let work-experience = (
  (
    title:    "Senior Cloud Engineer",
    company:  "Stratosphere Technologies",
    location: "Seattle, WA",
    start:    "Mar 2022",
    end:      "Present",
    bullets: (
      "Architected and maintained multi-region AWS infrastructure serving 8M+ daily active users with 99.99% uptime SLA",
      "Led Kubernetes migration from EC2-based deployments to EKS, reducing deployment time by 60% and improving resource utilization by 35%",
      "Built self-service infrastructure provisioning platform with Terraform modules and GitHub Actions, cutting new environment setup from 3 days to under 2 hours",
      "Reduced AWS spend by 40% through reserved instance planning, auto-scaling policies, and S3 lifecycle optimization across 15 accounts",
      "Mentored 4 mid-level engineers on IaC best practices, security hardening, and cloud cost governance",
    ),
  ),
  (
    title:    "Cloud Infrastructure Engineer",
    company:  "Orion Data Systems",
    location: "Austin, TX",
    start:    "Jun 2020",
    end:      "Feb 2022",
    bullets: (
      "Designed and operated hybrid cloud networking across AWS and on-prem using Transit Gateway, Direct Connect, and VPN tunnels",
      "Implemented centralized logging and observability stack using CloudWatch, Prometheus, and Grafana, reducing mean time to detect incidents by 50%",
      "Automated OS patching and compliance enforcement across 300+ EC2 instances using AWS Systems Manager and Ansible",
      "Collaborated with security team to achieve SOC 2 Type II compliance by enforcing IAM least-privilege policies and enabling AWS Config rules",
    ),
  ),
  (
    title:    "DevOps Engineer",
    company:  "BrightPath Software",
    location: "Denver, CO",
    start:    "Jul 2018",
    end:      "May 2020",
    bullets: (
      "Built and maintained CI/CD pipelines with Jenkins and GitHub Actions for a team of 30 engineers, reducing release cycle from weekly to daily",
      "Containerized 12 legacy applications using Docker and deployed to GKE, improving portability and reducing environment drift",
      "Provisioned and managed GCP infrastructure with Terraform for a B2B SaaS product serving 50K+ users",
    ),
  ),
)


// ── Projects ──────────────────────────────────────────────────────────────────

#let projects = (
  (
    name:  "TerraStack",
    role:  "Python, Terraform, AWS, GitHub Actions",
    start: "Feb 2023",
    end:   "Present",
    url:   "terrastack.dev",
    bullets: (
      "Open-source CLI tool for generating production-ready Terraform modules from YAML config files, with 900+ GitHub stars",
      "Supports AWS, GCP, and Azure providers with built-in security baselines and cost tagging conventions",
      "Used in CI pipelines via a GitHub Actions integration for automated plan, validate, and drift detection workflows",
    ),
  ),
  (
    name:  "CloudWatch Slack Alerter",
    role:  "Python, AWS Lambda, Terraform",
    start: "Nov 2022",
    end:   "Jan 2023",
    url:   "",
    bullets: (
      "Serverless alert routing system that forwards CloudWatch alarms to Slack channels with context-enriched messages and runbook links",
      "Deployed via Terraform with SNS, Lambda, and Secrets Manager; adopted by 6 internal teams within the first month",
    ),
  ),
)


// ── Education ─────────────────────────────────────────────────────────────────

#let education = (
  (
    institution: "University of Washington",
    location:    "Seattle, WA",
    start:       "Sep 2014",
    end:         "Jun 2018",
    degree:      "Bachelor of Science, Computer Engineering - *GPA*: 4.0",
    bullets:     (),
  ),
)


// ── Certifications ────────────────────────────────────────────────────────────

#let certifications = (
  (name: "AWS Certified Solutions Architect – Professional"),
  (name: "AWS Certified DevOps Engineer – Professional"),
  (name: "Certified Kubernetes Administrator (CKA)"),
  (name: "HashiCorp Certified: Terraform Associate"),
  (name: "Google Professional Cloud Architect"),
)
