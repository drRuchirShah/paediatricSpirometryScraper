# paediatricSpirometryScraper

Uses r to scrape spirometry data from pdf's automatically in order to aide research

Work presented at NHS-R conference 2022: https://www.youtube.com/watch?v=GS8CThaMZXM&t=14597s

Feel free to provide feedback/advice/suggestions for learning!

## The Problem
Children have asthma – we don’t understand how their lung function varies over time. Lung function can be assessed by a special test called spirometry. Spirometry data stored as PDF’s of variable formats in various different subfolders. 

## Solution
Used /R package: Tesseract
https://cran.r-project.org/web/packages/tesseract/vignettes/intro.html

It is package that runs optical character recognition (OCR) on files.

Script logic as follows:


![image](https://user-images.githubusercontent.com/119973108/207146435-e7eed67a-263d-4aa6-a498-f97e1cbd7c86.png) <br>


1. Setup Tesseract engine to recognise English language.
2. List all PDF files in the directory.
3. Create data frame for data to be stored in.

4. Loop over each PDF file and run OCR on each file - output vector of text.
5. Identify patterns within the vectors, for example the value for date of birth is often the element after the element "Date of Birth". Therefore my index value is "date of birth". I add 1 to my index to find the position of the element within the vector, containing the value for date of birth.
6. This value is extracted and inputted into data frame.

## Results
In progress

<pre>


</pre>
README file in progress and will be updated with description of work

Released under GNU GENERAL PUBLIC LICENSE:
https://www.gnu.org/licenses/gpl-3.0.txt
