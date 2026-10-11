#import "../globals.typ": *

// Set presentation title and subtitle
#let title = [Presentation Title]
#let subtitle = []

// Define theme
#let slide-theme = metropolis-theme.with(
    global-config-info,
    config-info(
        title: title,
        subtitle: subtitle
    ),    
    global-config-colors,
    global-config-common,
    aspect-ratio: global-aspect-ratio,
    header-right: global-header-right,
    footer: global-footer,
    // footer-right: none
    footer-right: global-footer-right
    // footer-progress: global-footer-progress,
    // footer-columns: global-footer-columns
)

#show: slide-theme

#title-slide()

#include "content.typ"