// slides_example.typ - Short example showcasing slide template features
#import "lib.typ": *

#show: slides.with(
  ratio: "16-9",
  main-font: "Calibri", // Default value is can be tweaked in core.typ
  code-font: "Consolas", // Default value is can be tweaked in core.typ
  font-size-headers: 20pt, // Default value is can be tweaked in core.typ
  font-size-content: 16pt, // Default value is can be tweaked in core.typ
  footer_text: "Slides Demo", // Default value is emty string if not set
  equation_numbering_globally: true, // Default set to "false" if not set.
  // The defult colors are: blue, red, green, cyan, magenta, yellow, gray, white, and can be used directly, and they can be customized in utils.typ
)

// ============ SLIDE 0: Custom Header Text Color ============
#slide(headercolor: white, title: "White Header with Black Text", textcolor: black)[
  This slide uses a white header with black text.
]

// SLIDE 1: Focus Boxes and Equations
#slide(headercolor: blue, title: "Focus Boxes and Equations")[
  #focusbox(bg: green, width: 60%, center_x: true, center_y: true)[
    This is a x- and y-centerd *green focusbox* with 60% width and an unnumbered equation:
    #[
      #set math.equation(numbering: none)
      $ f(x) = x^2 + 2x + 1 $
    ]
  ]
  We can add some vertical space between elements using the `#v()` command:

  #v(1em)

  #focusbox(bg: red, text-size: 1.3em)[
    This is a *red focusbox* with a numbered equation and larger text.

    $ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $
  ]
]


#slide(headercolor: cyan, title: "Focusbox configuration")[

  #focusbox(
    bg: magenta,
    width: 80%,
    text-size: 0.6em,
    center_y: false,
  )[
    The focusbox has several options:

    - bg: - Background color (blue, red, green, cyan, magenta, yellow, gray, white)
    - text-size: Font size (e.g., 0.8em, 1.2em)
    - center_x: Horizontal centering (true/false)
    - center_y: Vertical centering (true/false)
    - width: Box width (e.g., 80%, 100%, auto)
  ]
 #align(top)[
 We can also use the `#pause` marker to create animated subslides within a slide.
 ]
 #pause

  #focusbox(
    bg: cyan,
    width: 80%,
    text-size: 0.7em,
    center_y: false,
  )[
    The `#slide` function has these options:

    - `headercolor`: Background color (blue, red, green, cyan, magenta, yellow, gray, white) - default: blue
    - `title`: Slide title text - default: none
    - `center_x`: Horizontal centering (true/false) - default: false
    - `center_y`: Vertical centering (true/false) - default: true
    - `slide-main-font`: Override main font for this slide only - default: none
    - `slide-main-font-size`: Override main font size for this slide - default: none
    - `slide-code-font`: Override code font for this slide - default: none
    - `slide-code-font-size`: Override code font size for this slide - default: none
    - `slide-equation-numbering`: Turn equation numbering on/off for this slide (auto/true/false) - default: auto
    - `repeat`: Number of animation subslides (auto = auto-detect from `#pause` markers) - default: auto
  ]
]

// SLIDE 2: Two Columns - Table and Image
#slide(headercolor: green, title: "Data and Visualization")[
  #cols(columns: (1fr, 2fr))[
    // Column 1: Data table
    #table(
      columns: 4,
      stroke: 0.5pt,
      align: (right, right, right, right),
      fill: (_, y) => if y == 0 { cyan.lighten(80%) },
      inset: (x, y) => if y == 0 { (x: 50pt, y: 5pt) } else { (x: 10pt, y: 10pt) },
      table.header(
        [#align(center)[#v(5pt) #rotate(60deg, reflow: true)[*Day*]]],
        [#align(center)[#v(5pt) #rotate(60deg, reflow: true)[*Susceptible S*]]],
        [#align(center)[#v(5pt) #rotate(60deg, reflow: true)[*Infectious I*]]],
        [#align(center)[#v(5pt) #rotate(60deg, reflow: true)[*Recovered R*]]],
      ),
      [0], [990], [10], [0],
      [2], [950], [35], [15],
      [4], [880], [75], [45],
      [6], [780], [120], [100],
      [8], [650], [155], [195],
      [10], [520], [175], [305],
      [12], [400], [180], [420],
      [14], [300], [165], [535],
    )
  ][
    // Column 2: Plot image
    #align(center)[
      #image("plot.png", width: 100%)
    ]
  ]
]

// SLIDE 3: Python Code
#slide(headercolor: red, title: "Python Code", center_y: false)[
We can embedd Python code for the simulation of an SIRS epidemiological model, using typst built-in code blocks:
  #focusbox(bg: yellow, width: 100%, text-size: 0.9em)[
    
    ```python
    import numpy as np

    def sirs(N, beta, gamma, xi, I0, R0, days, dt):
        t = np.linspace(0, days, int(days/dt) + 1)
        S = np.zeros_like(t); I = np.zeros_like(t); R = np.zeros_like(t)
        S[0] = N - I0 - R0; I[0] = I0; R[0] = R0

        for k in range(len(t) - 1):
            dS = -beta*S[k]*I[k]/N + xi*R[k]
            dI =  beta*S[k]*I[k]/N - gamma*I[k]
            dR =  gamma*I[k] - xi*R[k]
            S[k+1] = S[k] + dt*dS
            I[k+1] = I[k] + dt*dI
            R[k+1] = R[k] + dt*dR

        return t, S, I, R
    ```
  ]
]



// SLIDE 4: Harmonic Oscillator (Gray Theme)
#slide(headercolor: gray, center_y: false, title: "Harmonic Oscillator")[
  #cols(columns: (1fr, 1.2fr))[
    We can model the motion of a simple harmonic oscillator using the following equation:

    #focusbox(bg: gray, width: 100%, center_x: true)[
      $ x(t) = A sin(omega t - phi) $
    ]

    Where:
    - $A$ is the amplitude
    - $omega$ is the angular frequency
    - $phi$ is the phase offset
  ][
    #pause
    *Total Energy:*
    The total mechanical energy $E$ is the sum of kinetic and potential energy:
    $ E = K + U = 1/2 m v^2 + 1/2 k x^2 $

    #pause
    
    Substituting $v(t) = dot(x)(t)$ and using $k = m omega^2$:
    $ E &= 1/2 m (A omega cos(omega t))^2 + 1/2 (m omega^2) (A sin(omega t))^2 \
        &= 1/2 m omega^2 A^2 (cos^2(omega t) + sin^2(omega t)) \
        &= 1/2 k A^2 $
  ]
]
