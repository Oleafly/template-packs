#import "/constants.typ": *
#import template: titlepage, outline, last_page, normal_numbering, vuln_numbering, format_link, new_section, initialise_document
#import structure: structure

// Setup our document's show rules
#show: doc => initialise_document(doc)

// Format headers in a custom way as the template guides
#set heading(numbering: normal_numbering)

// Titlepage
#titlepage(title, if longcompany != none { longcompany } else { company }, if longclient != none { longclient } else { client }, version_history)

// Table of contents
#outline(title: "Table of Contents", depth: 2, indent: auto)

// Format links after the table of contents, if the template wants us to
#show link: it => format_link(it)

#new_section

// Executive Summary
= Executive Summary

#include "executivesummary.typ"

// Little bit of spacing
#v(1cm)

// These are the tables below the executive summary
#(structure.vulnerability_tables)(vuln_section_order: section_order)

#new_section

// Overview
= Overview

#include "overview.typ"

#new_section

// Attack Walkthrough
= Attack Walkthrough

#include "attackwalkthrough.typ"

#new_section

// Format vulnerability headers in a custom way as the template guides
#set heading(numbering: vuln_numbering)

// Detailed Vulnerabilities
#(structure.vulnerability_sections)(vuln_section_order: section_order)

#(structure.appendices)()

#last_page