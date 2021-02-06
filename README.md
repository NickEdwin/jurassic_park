# Jurassic Park
![Welcome](https://media1.giphy.com/media/JfaeAz2zpL1lK/200.gif)

## Table of Contents

- [Brief Description](#brief-description)
- [Visual Schema](#visual-schema)
- [Sample JSON Response](#sample-json-response)
- [How to setup](#how-to-setup)
- [Background Information](#background-information)
- [Next Steps](#next-steps)

<!-- Brief Description -->

## Brief Description
This API allows users to simulate a small part of what it's like to set up Jurassic Park!  
With this API you can:
- Create cages to hold dinosaurs  
- Add Dinosaurs to cages once created  

As we all know there's going to have to be some contraints associated with putting Dinos in cages!
Some of those contraints are as follows:  
- Dinosaurs listed as "Herbivores" can only be in cages with other Herbivores (species does not matter.)  
- Dinosaurs listed as "Carnivores" can only be in cages with Carnvores of the same Species.  
- Cages have a power status of "ACTIVE" or "DOWN" which can be edited - BUT cages that contain Dinos can NOT be powered down (we all saw how that worked out in the movie!)  
![T-Rex](http://25.media.tumblr.com/tumblr_luzjyqpHZG1qc7geho9_250.gif)  
- Also cages that are powered down can not have a dinosaur placed into them.  
 
When querying cages or dinos the follow commands can be used: 
- To obtain a list of all cages based on power status:  
> GET "/api/v1/cages?power_status=ACTIVE"  
or  
> GET "/api/v1/cages?power_status=DOWN"  

- Show a particular cage and the dinos it contains:  
> GET "/api/v1/cages/:id"  

- Show a list of dinos based on species:
> GET /apli/v1/dinosaurs?species=[INSERT SPECIES NAME HERE]

  
## Visual Schema
Simple database with a one to many relationship for cages and dinosaurs.
![Schema](https://i.imgur.com/nayDysn.png)  

## Sample JSON response
A sample JSON response for cage 1 and all its dinos  
![JSON](https://i.imgur.com/KSH2pxd.png)

## How To Setup  
Clone down this repo, fire up a rails server and play around in PostMan.  

## Background Information  
This is a backend API build with Ruby 2.5.3 and Rails 6.0.3.4.  
SimpleCov used to check test coverage.  
Fast JSON API used for JSON responses.   

## Next Steps  
Current test coverage is at 93.33% - Need to make that 100!   
Add seeds to db (oops!)  
Add GET for return of a single Dinosaur.  
Double check species placements of dinosaurs in cage method - looks like herbivores cant be mixed.  
