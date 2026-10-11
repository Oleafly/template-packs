The Penn State Thesis class file and template for use with LaTeX. This is version 2.4.0 of the psuthesis.cls and version 1.3.0 of the template. The file psuthesis.cls was last modified on 10/21/2013. The template files were last modified 10/21/2013. The 10/21/2013 changes should bring the generated document in line with Graduate School requirements. Please notify the author if you find any problems.

This is a template file to help get you started using the psuthesis.cls for theses and dissertations at Penn State University. You will, of course, need to put the psuthesis.cls file someplace that LaTeX will find it.

We have set up a directory structure that we find to be clean and convenient. You can readjust it to suit your tastes. In fact, the structure used by our students is even a little more involved and commands are defined to point to the various directories.

This document has been set up to be typeset using pdflatex. About the only thing you will need to change if typesetting using latex is the \DeclareGraphicsExtensions command.

The psuthesis document class uses the same options as the book class. In addition, it requires that you have the ifthen, calc, setspace, and tocloft packages.

The first additional option specifies the degree type. You can choose from: 
 Ph.D. using class option <phd>, M.S. using class option <ms>,
 M.Eng. using class option <meng>,
 M.A. using class option <ma>,
 B.S. using class option <bs>,
 B.A. using class option <ba>,
 Honors Baccalaureate using the option <honors>

If you specify either ba or bs in addition to honors, it will just use the honors option and ignore the ba or bs option.

The second additional option <inlinechaptertoc> determines the formatting of the Chapter entries in the Table of Contents. The default sets them as two-line entries (try it). If you want them as one-line entries, issue the inlinechaptertoc option.

The class option ``honors'' should be used for theses submitted to the Schreyer Honors College. This option changes the formatting on the Title page so that the signatures appear on the Title page.

The class option ``honorsdepthead'' adds the signature of the department head on the Title page for those baccalaureate theses that require this.

The class option ``secondthesissupervisor'' should be used for baccalaureate honors degrees if you have a second Thesis Supervisor.

The vita is only included with the phd option and it is placed at the end of the thesis. The permissions page is only included with the ms, meng, and ma options.

===================================================

Original sources: https://sites.esm.psu.edu/~gray/psu-latex-thesis-class.html
Author:           Gary L. Gray, gray@psu.edu

Status:           added by Papeeria Team, maintenance on demand
Last update:      09 Apr 2017 
