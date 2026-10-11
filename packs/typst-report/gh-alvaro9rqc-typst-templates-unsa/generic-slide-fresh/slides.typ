// --- SLIDES COMPILATION ENTRY POINT ---
// This file serves as the main entry point to compile the complete presentation.

#import "presentation/style.typ": template
#show: template

// --- MODULAR SLIDES CONTENT ---
// Included modularly from separate files to maintain clean, organized source code.

#include "presentation/content/1_cover.typ"
#include "presentation/content/2_introduction.typ"
#include "presentation/content/3_problem.typ"
#include "presentation/content/4_solution.typ"
#include "presentation/content/5_target.typ"
#include "presentation/content/6_plan.typ"
#include "presentation/content/7_strategy.typ"
#include "presentation/content/8_proposal.typ"
#include "presentation/content/9_expectations.typ"
#include "presentation/content/10_contact.typ"
