//
//  BuildingTableViewController.swift
//  MAD9036 Final
//
//  Created by Ryan Bowes on 2017-12-10.
//  Copyright © 2017 Algonquin College. All rights reserved.
//

import UIKit

class BuildingTableViewController: UITableViewController, sendBuildings {
    func sendBuildings(buildings: [Building]) {
        self.Buildings = buildings
        self.tableView.reloadData()
    }
    
    var API: DoorsOpen?
    var Buildings: [Building]? = []
    var delegate: sendBuildings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API = DoorsOpen()
        API?.delegate = self
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum: Int = 0
        
        if let buildingCount = Buildings?.count {
            rowNum = buildingCount
        }
        
        return rowNum
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingCell", for: indexPath)

        // For the current tableCell row get the corresponding event's dictionary of info
        let currentBuilding = Buildings![indexPath.row]
        
        // Get the name and overview for the current event
        let title = currentBuilding.name?.EN
        let date = currentBuilding.name?.FR
        
        // Add the name and overview to the cell's textLabel
        cell.textLabel?.text = title! + ": " + date!
        
        return cell
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
