# ViperDemo

A demo for VIPER Architecture, can be extended to an epic project

<img src="https://github.com/HongliYu/ViperDemo/blob/master/VIPER-Intro.jpg?raw=true" alt="alt text"  height="400">

# Components

### View: 
Includes view, cell, table view, all UI components, and view controllers. Pass User events like click, tap, long press from controller to presenter, also get data update call back from presenter to update view appearances
 
### Interactor: 
Contains data requests via network, database, file system triggered by presenter, and call back data to presenter

###  Presenter: 
Handle logic between view and interactor, and trigger router in a proper way

###  Entity: 
Raw model from network, database. View model for view rendering

###  Router: 
Contains navigation logic

Base on V-I-P-E-R, I add another component called Builder
###  Builder: 
Create view controllers; Clarify the reference relationship of each component V-I-P-E-R

<img src="https://github.com/HongliYu/ViperDemo/blob/master/VIPER-Builder.png?raw=true" alt="alt text"  height="400">

