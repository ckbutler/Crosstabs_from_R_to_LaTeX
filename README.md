# Crosstabs_from_R_to_LaTeX

These files were used to demonstrate well-formatted R scripting with a specific example of generating a crosstab table and a mosaic plot for use in LaTex.

untitled.R
----------
This file will work once on the original user's computer but is poorly formatted (in many ways). It get the job done but is not reusable.

untitled_automaticallyReformattedCode.R
---------------------------------------
This file is an automatically reformatted version of untitled.R using Code -> Reformat Code. This demonstrates that adding spaces and line-breaks for better formatting makes the code easier to read and is easy to do.

CrosstabsInLaTeX.R
------------------
This file represents one example of a well-formatted script. (Recognizing that such things are subject to opinion.) It adds comments for titling and authorship, describing the purpose of the script, for section headings (in a reasonable order), and for explaining some steps in the script.

CrosstabsInLaTeX.tex
--------------------
This file is the corresponding TeX file that takes the outputs of CrosstabsInLaTeX.R and includes them for publication in a PDF.

# Additional comments

We alse discussed the value of "sourcing" your entire script repeatedly (rather than running portions of a script and/or also using the console. As such, we noted that there is a checkbox option in RStudio for script files to "Source on Save" which will run the whole script every time you save it.
