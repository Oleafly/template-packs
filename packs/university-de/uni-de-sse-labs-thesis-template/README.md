# Thesis Template for the SSE Group at TU Dortmund

In this repository you find the template for thesis projects in our group.
You can use this template for your own thesis by clicking the "Use this template" button above.

## Customization

The main document is the `thesis.tex` file which you need to customize for your thesis project.
Line 6 contains the link to our document class and needs to be adapted to your particular project.

- `german` for a thesis in German
- `english` for a thesis in English
- `ba` for a Bachelor thesis
- `ma` for a Master thesis

In the section of line 8 and following you can add any LaTeX package you additionally require for your thesis.
The list of packages already included through the template is:
`blindtext`,
`graphicx`,
`url`,
`geometry`,
`xifthen`,
`wrapfig`,
`textpos`,
`babel`,
`multicol`,
`natbib`,
`xcolor`.
Feel free to add packages as needed, but do not change the fonts or font sizes or page geometry. Also the packages must be compatible with XeTeX.

You can set the title of your thesis in line 12 and your name in line 15. Set the correct supervisors in line 18 and 19.

Now you are ready to add you content, such as the abstract in English (in case you write your thesis in English) and German (in any case needed).
We suggest to structure your chapters into individual files and include them, but feel free to structure differently.

## Compilation

We provide a configuration file for LaTeXMk so you only need to execute
```
latexmk
```
Your compiled files are located in `target/`. 

In case you want to do it manually the sequence is:
```
xelatex thesis.tex
bibtex thesis
xelatex thesis.tex
xelatex thesis.tex
```

### Usage with Overleaf

Works out of the box... Just set the main file to thesis.tex and the compiler to XeLaTeX in the settings.

## Things you don't need to take care of

We use XeTeX and a modern package setup.
Older LaTeX references sometimes advise you to use German Umlaut characters such as `ä` in the form of `a"`.
This is not necessary anymore. XeTeX and the fonts are Unicode aware.
