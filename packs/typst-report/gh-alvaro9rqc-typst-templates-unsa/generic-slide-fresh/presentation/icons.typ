// --- VECTOR SVG ICONS ---

/// Renders a phone icon.
///
/// - color (color): The stroke color of the phone icon.
/// - size (length): The width and height of the icon. Default is `24pt`.
/// -> content
#let icon-phone(color, size: 24pt) = image(
  bytes("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='" + color.to-hex() + "' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z'></path></svg>"),
  format: "svg",
  width: size
)

/// Renders an email icon.
///
/// - color (color): The stroke color of the email icon.
/// - size (length): The width and height of the icon. Default is `24pt`.
/// -> content
#let icon-email(color, size: 24pt) = image(
  bytes("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='" + color.to-hex() + "' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z'></path><polyline points='22,6 12,13 2,6'></polyline></svg>"),
  format: "svg",
  width: size
)

/// Renders a globe icon.
///
/// - color (color): The stroke color of the globe icon.
/// - size (length): The width and height of the icon. Default is `24pt`.
/// -> content
#let icon-globe(color, size: 24pt) = image(
  bytes("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='" + color.to-hex() + "' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><circle cx='12' cy='12' r='10'></circle><line x1='2' y1='12' x2='22' y2='12'></line><path d='M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z'></path></svg>"),
  format: "svg",
  width: size
)

/// Renders a checkmark icon.
///
/// - color (color): The stroke color of the checkmark.
/// - size (length): The width and height of the icon. Default is `13pt`.
/// -> content
#let icon-check(color, size: 13pt) = image(
  bytes("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='" + color.to-hex() + "' stroke-width='3' stroke-linecap='round' stroke-linejoin='round'><polyline points='20 6 9 17 4 12'></polyline></svg>"),
  format: "svg",
  width: size
)
