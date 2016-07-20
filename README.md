# HE LAB TOOLs
## Lab Facility Appointment System

### Introduction

[HE Lab, Life Sciences Institute of Zhejiang University](http://lsi.zju.edu.cn/redir.php?catalog_id=13701) is an lab investigating epigenetic inheritance using fission yeast genetics. This R-Shiny web application is built for arrange use of lab facilities such as PRC machines, dissection microscopes.

You can deploy this application on your server, if you have installed R and Shiy-Server. This applicaiton can be easily set up with little modification.

### Logic of Functionalities

- **Navigate Though Timetables:** Choose the machine/equipment and alter the date to change the timetable you are viewing. Slide the sliderbar to change the interval selected.
- **Make an Appointment:** Provide the required and optional information. Choose the time interval with the sliderbar. A verification code is asked, which is used for verifying authority when editing/canceling the appointment.
- **Edit/Cancel an Appointment:** If you have the correct verificaiton code, you can edit/cancel an appointment.