//
//  MainViewController.swift
//  MyPlaces
//
//  Created by MacBook on 10/09/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let restauants = ["Ollis", "Zenit", "Dodo Pizza"]

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restauants.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

       cell.textLabel?.text = restauants[indexPath.row]
      cell.imageView?.image = UIImage(named: restauants[indexPath.row])

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

}
