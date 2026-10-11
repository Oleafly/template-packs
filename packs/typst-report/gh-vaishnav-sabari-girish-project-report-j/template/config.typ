// ============================================================
//  config.typ — Edit this file to customize your report
// ============================================================

// --- Institution ---
#let inst = (
  logos:            (
                        "assets/uni-logo.jpg",
                        "assets/company-logo.jpg",   // Optional for Internship reports only
                    ),
  faculty:          "",                              // Faculty/School Name
  department:       "Department Name",               // Department Name
  address-1:        "Campus Address Line 1",
  address-2:        "City, State, Country",
  university:       "University Name",
  degree:           "Degree",
  branch:           "Branch",
  batch:            "Batch",
  city:             "City",
  academic_year:    "Academic Year",
  coordinator_name: "Dr. Coordinator Name"
)

// --- Project ---
#let project = (
  title:        "Project Title",
  short-title:  "Short Title",   // Used in the page header
  subtitle:     "",              // Optional subtitle
)

// --- Authors  (add/remove entries as needed) ---
#let authors = (
  (name: "AUTHOR ONE",   usn: "22BTXXX001"),
  (name: "AUTHOR TWO",   usn: "22BTXXX002"),
)

// --- Guide ---
#let guide = (
  name:         "Dr. Guide Name",
  designation:  "Designation",
  department:   "Department",
  university:   "University Name",
)

// --- Other signatories on the certificate ---
#let hod = (
  name:         "Dr. HoD Name",
  designation:  "Head of Department",
  department:   "Department",
  university:   "University Name",
)

#let dean = (
  name:         "Dr. Dean Name",
  designation:  "Designation",
  department:   "Department",
  university:   "University Name",
)
