//
//  MainViewController.swift
//  MyPlaces
//
//  Created by MacBook on 10/09/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    
    
    var places = Place.getPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        
        if place.image == nil {
            cell.imageOfPlace.image = UIImage(named: place.restaurantImage!)
        } else {
            cell.imageOfPlace.image = place.image
        }
        
        
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - Table view delegate
    @IBAction func unwindSegua(_ segua: UIStoryboardSegue){
        
        guard let newPlaceVC = segua.source as? NewPlaceViewController else { return }
        newPlaceVC.saveNewPlace()
        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
        
    }
}
