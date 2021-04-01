# SmartTraveller


![](https://smarttraveller.lk/images/logos/logo-app.png)

SmartTraveller is a concept developed by Plymouth University Undergraduates (NSBM partnership)  to solve the current issues that passengers face while using the public transport system of Sri Lanka.

The project is a  developed for both android and iOS devices and currently available in **PlayStore** for android users. 

For more information visit [smarttraveller.lk](https://smarttraveller.lk/)

# Mobile Application

There are 2 mobile applications available which were developed using **Flutter**

## Passenger Application

The passenger mobile application is available for the passengers using the public transportation.  

The passenger application has the following features

 - [ ] Ability to locate the nearest bus stop
 - [ ] Ability to view the bus schedule of routes
 - [ ] Ability to live locate the bus
 - [ ] Ability to know the current number of passengers in the bus
 - [ ] Ability to check the balance of the travel pass (Only in NFC enabled devices)
 
[
![enter image description here](https://freeiconshop.com/wp-content/uploads/edd/google-play-badge-128x128.png)
](playstoe)

## Agent Application

The agent application is designed for bus drivers, bus owners and recharge agents.

The agent application has the following features

 - [ ] Ability to live view the crediting of bus fare to personal creditor account
 - [ ] Ability to top-up travel passes  (Only in NFC enabled devices)

[
![enter image description here](https://freeiconshop.com/wp-content/uploads/edd/google-play-badge-128x128.png)
](playstoe)



# System Components

SmartTraveller project is integrated with a hardware component as well. The device is fixed to the bus and it will be acting as the bus fare charging machine and bus locating device.


## Travel Pass

The travel pass is an NFC enabled card which will act as the passenger identification method as well as the bus fare payment method. Each travel pass is issued for a NIC number so that if the passenger looses the card all the credits are transferable for a new card. 

## Fixed Device

The fixed device is made with Raspberry Pi, Arduino and Node MCU components. It is used to send the current location of the bus to the cloud database and to perform the charging of passengers' bus fare.



# Database

Google firestore has been used as the the database for this project. Firestore is known as a good realtime database and as this project requires realtime data update firestore suits the most.

![](https://res.cloudinary.com/practicaldev/image/fetch/s--votq-78N--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/i/eg898z0che879nbvhlsv.png)
