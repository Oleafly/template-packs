# MedTech Thesis Template

A LaTeX thesis template for students of the **Medical Technologies (MedTech) Programme**, run by **MedTech Centre, IIT Jodhpur and AIIMS Jodhpur**.

This template provides a convenient and consistent starting point for preparing **Master's and Doctoral theses** under the MedTech Programme.

> **Note:** This is an unofficial, student-maintained template. Please verify the final formatting and submission requirements with the latest guidelines issued by IIT Jodhpur, AIIMS Jodhpur, and the MedTech Programme before submitting your thesis.

## Features

The template includes:

* Thesis title and front pages
* Declaration and certificate pages
* Abstract
* Acknowledgements
* Table of contents
* List of figures
* List of tables
* Abbreviations
* Main thesis chapters
* References and bibliography
* Appendices
* Customizable formatting and page layout
* Separate front-page formats for thesis and synopsis/presynopsis submissions

## Front Pages

The template includes different front-page formats depending on the type of submission.

In the main `.tex` file, select the appropriate option:

```latex
% Choose the appropriate front page based on the type of submission.

% Thesis:
\include{preliminaryPages/coverPage_Thesis}

% Synopsis / Presynopsis / Other submissions:
% \include{preliminaryPages/coverPage_presyn}
```

Uncomment only the front page required for your submission.

## Using with Overleaf

The template can be used with [Overleaf](https://www.overleaf.com/).

1. Download the repository as a ZIP file.
2. Open [Overleaf](https://www.overleaf.com/).
3. Select **New Project → Upload Project**.
4. Upload the ZIP file.
5. Open the project.
6. Go to **Menu → Settings**.
7. Under **Compiler**, select **LuaLaTeX**.
8. Recompile the project.

> **Important:** This template is designed to be compiled using **LuaLaTeX**. Make sure **LuaLaTeX** is selected as the compiler in Overleaf.

## Using Locally

Clone the repository:

```bash
git clone https://github.com/gajendrakashyap/MedTech-Thesis-Template.git
```

Open the project in your preferred LaTeX editor and compile it using **LuaLaTeX**.

## Project Structure

```text
MedTech-Thesis-Template/
│
├── Thesis.tex
│
├── preliminaryPages/
│   ├── coverPage_Thesis.tex
│   ├── coverPage_presyn.tex
│   ├── declaration.tex
│   ├── certificate.tex
│   ├── acknowledgement.tex
│   ├── abstract.tex
│   ├── abbreviation.tex
│   └── ...
│
├── chapters/
│   ├── chapter1.tex
│   ├── chapter2.tex
│   └── ...
│
├── appendices/
│   ├── AppendixA.tex
│   ├── AppendixB.tex
│   └── ...
│
├── figures/
│   └── ...
│
└── README.md
```

The exact structure may change as the template is updated.

## Customization

The template can be modified according to the requirements of your thesis.

Before final submission, verify the following against the latest official guidelines:

* Page margins
* Fonts
* Line spacing
* Chapter and section formatting
* Title page
* Certificates and declarations
* Figure and table formatting
* Bibliography style
* Page numbering
* Institutional logos
* Required signatures
* Other programme-specific requirements

## Compilation Issues

If you encounter compilation issues, first make sure that **LuaLaTeX** is selected as the compiler.

If the problem persists, try cleaning the auxiliary files and recompiling the project from scratch. Files such as `.aux`, `.bbl`, `.blg`, `.log`, and `.toc` may contain information from a previous compilation.

On Overleaf:

**Menu → Recompile → Recompile from scratch**

## Author & Maintainer

### Gajendra Singh
PhD Scholar  
MedTech Centre  
IIT Jodhpur & AIIMS Jodhpur  
**Website:**
[https://gajendrasingh.netlify.app/](https://gajendrasingh.netlify.app/)

For suggestions, corrections, or improvements, please open an **Issue** or submit a **Pull Request**.

## Contributing

Contributions and improvements are welcome.

If you find an error or have a useful improvement:

1. Open an **Issue** describing the problem.
2. Submit a **Pull Request** with the proposed change.
3. Keep changes general and useful for students using the template.

## Disclaimer

This is an **unofficial, community-maintained LaTeX template**.

The authors and contributors are not responsible for formatting issues, compilation errors, submission problems, or any other consequences resulting from the use of this template.

Students are responsible for ensuring that their final thesis complies with the **latest official requirements** of their programme and institute.

## Acknowledgement

This template has been adapted and modified from existing IIT Jodhpur thesis templates and publicly available LaTeX resources.

The original sources and contributors are acknowledged within the template files.

