# GAMUTdownload
### iUTAH GAMUT Aquatic Station 
###    Grab Sample download
### Version 1.1
### Written by: Erin Fleming Jones, Contact at: erinfjones3@gmail.com
### Last updated: 3/3/2016

To Begin:
This R code is designed to expedite the process of extracting GAMUT Aquatic Sensor data at specific time points, for example to pair with grab sample data collected at a GAMUT site. In order to use this code, you will need RStudio, available for free download at https://www.rstudio.com/products/rstudio/download/ and R, available at https://cran.r-project.org/ .
You will need to install packages plyr, and WaterML. You can install packages using the tab at the top of the bottom right panel. 

Navigating:
You can collapse portions of code by clicking on the arrows on lines beginning #####. You can also use a drop down menu by clicking right at the very bottom of the script frame (if you haven't clicked anywhere in the text it will read [Top Level]). If you are interested in data from a single watershed, you can highlight the relevant collapsed sections, and click the "Run" button. Logan River begins on line 55, Red Butte on line 385, and Provo on line 719, or drop down menu items Franklin Basin, Knowlton Fork, and Soapstone, respectively. 

Date time set-up:
Example sample collection dates and times are entered in the top section of the code labeled ### Set Date and times ###. Each watershed has a date included in a commented section of code, that is used to help keep files separate when multiple sampling points are being downloaded. Use find and replace (ctrl+f) to replace the example date (e.g. 15Aug) with your own unique identifier. In the next line, if samples at multiple sites were collected on the same day, enter your date of interest for a watershed after "StartDate=" and the next calendar day as "EndDate". If the samples within a watershed span multiple days, use the day after the last sampling day. Then enter the date and time for each individual site sampled in the designated lines. Times need to be rounded to the nearest 15 minute interval (e.g. 07:45:00, 15:30:00 are okay, 10:32:00 or 16:15:37 are not). Three Provo sites need to be rounded to the nearest hour. Version 1.2 will include code to allow 15 minute intervals. Be sure to use the YYYY-MM-DD HH:MM:SS format as demonstrated.


Running just a portion:
If you are not using all of the sites or watersheds, you will need to delete or comment out (i.e. add a # in front of the line) unused dataframe names (ex. CGrove17AugGrabSample  ) contained in the "Spreadsheet" section after all the sites in a watershed. If there is an unused site the function to consolidate into a single dataframe will not run and will return an error. 
