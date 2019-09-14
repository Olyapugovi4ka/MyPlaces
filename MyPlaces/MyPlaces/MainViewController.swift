//
//  MainViewController.swift
//  MyPlaces
//
//  Created by MacBook on 10/09/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var places: Results<Place>!
    private var filteredPlaces: Results<Place>!
    private var ascendingSorting = true
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var reverseButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
        
        //Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPlaces.count
        }
        return places.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = isFiltering ? filteredPlaces[indexPath.row] : places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        cell.cosmosView.rating = place.rating
        
        
        
        
        
        
        return cell
    }
    
    //MARK: - table view delegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let place = places[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = isFiltering ? filteredPlaces[indexPath.row] : places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currentPlace = place
        }
    }
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    //MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func reversedSorting(_ sender: Any) {
        ascendingSorting.toggle()
        if ascendingSorting {
            reverseButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reverseButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
    }
    @IBAction func unwindSegua(_ segua: UIStoryboardSegue){
        
        guard let newPlaceVC = segua.source as? NewPlaceViewController else { return }
        newPlaceVC.savePlace()
        tableView.reloadData()
        
    }
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
}
extension MainViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        fileContentForSearchText(searchController.searchBar.text!)
    }
    
    private func fileContentForSearchText( _ searchText: String){
        filteredPlaces = places.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText,searchText)
        tableView.reloadData()
    }
}
