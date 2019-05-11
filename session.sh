#!/bin/bash
# --------------------------------------------------------------------------------
# document here the main bash commands you are using for the server access.  The file contains
# two parts: the first one for the commands you run on your laptop, and the second one for the
# commands on the remote server.
#
# The question lists give your some guidance what to do and report but you are free to do it
# in a different way.  If you use a graphical frontend instead of scp for copying files,
# just say which one in the appropriate place.
#
# Note: this file does not to be runnable
#
# -------------------- local commands --------------------
# 1. create a directory for this project.
git clone git@github.com:info201b-sp2019/a5-remote-server-violetcui.git
# 2. log onto the server
ssh cuiyq@info201.ischool.uw.edu
# 3. copy the small data subset from the server to your local machine
scp cuiyq@info201.ischool.uw.edu:/opt/data/temp-prec-encrypted.csv.bz2 ~/Desktop
# 4. copy your R-script to the server
scp maps.R cuiyq@info201.ischool.uw.edu:a5/
# 5. (after succesfully running the script remotely): copy the output files back to your computer
scp cuiyq@info201.ischool.uw.edu:a5/1960Temperature.png .
scp cuiyq@info201.ischool.uw.edu:a5/1987Temperature.png .
scp cuiyq@info201.ischool.uw.edu:a5/2014Temperature.png .
scp cuiyq@info201.ischool.uw.edu:a5/1960Precipitation.png .
scp cuiyq@info201.ischool.uw.edu:a5/1987Precipitation.png .
scp cuiyq@info201.ischool.uw.edu:a5/2014Precipitation.png .
# 6. inspect that the copy was successful
ls

# -------------------- remote commands --------------------
# 1. explore the data directory '/opt/data'.  How do you find out the size of the files?
cd /opt/data
ls -l *
# 2. explore the first few lines of the small sample data
pbzip2 -dc temp-prec-encrypted.csv.bz2 | head -5
# 3. create a directory for this project
mkdir a5
# 4. (after copying your code from the laptop): inspect the files in the project directory
cd a5
ls
# 5. run your script
Rscript maps.R
# 6. How do you install missing R packages?
R
install.packages("ggplot2")
install.packages("dplyr")
install.packages("data.table")
install.packages("mapproj")
install.packages("R.utils")
q()
# 7. (after running the script): inspect the folder for output files
ls
