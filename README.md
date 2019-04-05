# La_tracker and other personnel-related software

Flips a matrix of hours worked from the form in which the data are encountered to 
the form that we are required to return. Examples of input and output are shown
in:

![Input format](/Docs/Payperiods-test-seq.JPG)
Format: ![Inupt form](La_tracker/Docs/Payperiods-test-seq.JPG)

![Output format](/Docs/Hourshout.JPG)
Format: ![Inupt form](La_tracker/Docs/Hourshout.JPG)


## Programs (in ./Software/)

### La_tracker_demo_proto.R (in ./Software/)

Instead of hours, uses numerals 1 to 130 to demonstrate how the cells from 
the input matrix are re-arranged. Individual steps are separated and 
annotated.

### La_tracker_demo.R (in ./Software/)






Reads in data from a 26 rows (pay periods) of 14 columns (days in pay periods)


### In ./Docs
"La_hr_namelf_y17_pp10.xlsx" is a self-created spreadsheet designed to: 1) be
organized somewhat similarly to the institutional "WebTA"; 2) facilitate 
real-time tracking of hours worked to prevent exceeding 1039; and 3) provide
input into "La_tracker.R"

"La Appt Tracker.xlsx" is a document that admin required to be filed and submitted
in order to renew a letter of authority (L/A) appointment.

## In Data and Results

"./Data/Hoursin.csv" is obtained from the second tab in the "La_hr_namelf_y17_pp10.xlsx"
spreadsheet using "save as csv"

"./Results/Hoursout.csv" is opened in Excel for copy-and-paste into "La Appt Tracker.xlsx"

## Ratings.R

Explores scenarios and outcomes for ratings of individual elements in the
annual performance review
