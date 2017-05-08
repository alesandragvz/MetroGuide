//
//  StationSelectTableViewController.swift
//  MetroGuide
//
//  Created by Alexandra on 5/8/17.
//  Copyright © 2017 Alexandra. All rights reserved.
//

import UIKit

class StationSelectTableViewController: UITableViewController {
    
    enum Mode {
        case startStation
        case endStation
    }
    
    var mode: Mode = .startStation
    
    let routeBuilder = RouteBuilder()
    
    var startStation: Station?
    var endStation: Station?
    
    var stations: [Station] {
        get {
            var arr = [Station]()
            for branch in routeBuilder.branches {
                for station in branch.stations {
                    arr.append(station)
                }
            }
            return arr
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = mode == .startStation ? "Від" : "До"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! StationTableViewCell
        
        cell.station = stations[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if mode == .startStation {
            startStation = stations[indexPath.row]
            performSegue(withIdentifier: "goToEndStationSelect", sender: nil)
        } else {
            endStation = stations[indexPath.row]
            performSegue(withIdentifier: "goToRoute", sender: nil)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEndStationSelect" {
            let vc = segue.destination as! StationSelectTableViewController
            vc.mode = .endStation
            vc.startStation = startStation
        } else if segue.identifier == "goToRoute" {
            let vc = segue.destination as! RouteTableViewController
            vc.route = routeBuilder.buildRoute(between: startStation!, and: endStation!)
        }
    }

}
