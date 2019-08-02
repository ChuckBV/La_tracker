# La_tracker and other personnel-related software

Flips a matrix of hours worked from the form in which the data are encountered to 
the form that we are required to return. Examples of input and output are shown
in:

![Input format](/Docs/Payperiods-test-seq.JPG)
URL: https://www.github.com/ChuckBV/La_tracker/Docs/Payperiods-test-seq.JPG

![Output format](/Docs/Hourshout.JPG)
Format: ![Output form](La_tracker/Docs/Hourshout.JPG)


## Programs (in ./Software/)

### La_tracker_demo_proto.R

Instead of hours, uses numerals 1 to 130 to demonstrate how the cells from 
the input matrix are re-arranged. Individual steps are separated and 
annotated.

### La_tracker_demo.R

Like previous script, but annotation removed and several key steps placed
in brackets to create a quasi-executable script.

### La_tracker.R

Like L/A tracker_demo.R, but works with actual hours.


## Instructions

### 1. Record hours by Pay Period and day in an Excel form

At the start of the L/A appointment, modifind "La_hr_namelf_y17_pp10.xlsx" 
with information appropriate for the individual. This is used to keep track
of the L/A appointmenmt, and has the advantage of being more reasily compared
with webTA

### 2. Save as a comma-delimited file (*.csv) near end of appointment

Copy the payperiod and days porth of the "Dataform" tab of the Excel file, 
and paste into the equivalant part of the "Grid" tab.

### 3. Save the "Grid" tab as Hoursin.csv

### 4. Convert with LA-Tracker

Open La_tracker.R in RStudio, open La_tracker.R. Load dplyr. Got through
script and save "Hoursout.csv"

### 5. Copy "Hoursout.csv" and save to grayed area...

...of "LA Appt Tracker.xlsx:Sheet2". 

### 6. Finish LA Appt Tracker

Change name, add information for individual, save elsewhre, Save Sheet1
as a PDF (Sheet1 dispays numerals referenced from Sheet2), save
Sheet1 as a PDF, and provide to PSA for upload into ARIS
