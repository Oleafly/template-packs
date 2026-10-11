// CV Content File — Data-Driven Version
//
// This file reads your CV data from data.json and renders it using the template.
// To customise your CV, edit data.json — you shouldn't need to modify this file.

#import "template.typ": *

// Load CV data from JSON file
// Replace "data.json" with your own data file if you prefer to keep it separate
#let data = json("data.json")

// ============================================================================
// PERSONAL INFORMATION
// ============================================================================

#show: cv-from-data.with(data)

// ============================================================================
// PROFESSIONAL SUMMARY
// ============================================================================

#section-from-data(section-type: "summary", data.summary)

// ============================================================================
// EXPERIENCE
// ============================================================================

#section-from-data(section-type: "experience", data.experience)

// ============================================================================
// EDUCATION
// ============================================================================

#section-from-data(section-type: "education", data.education)

// ============================================================================
// SKILLS
// ============================================================================

#section-from-data(section-type: "skills", data.skills)

// ============================================================================
// PROJECTS
// ============================================================================

#section-from-data(section-type: "projects", data.projects)

// ============================================================================
// CERTIFICATIONS & AWARDS
// ============================================================================

#section-from-data(section-type: "certifications", data.certifications)