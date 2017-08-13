//
//  TableViewController.swift
//  My Places
//
//  Created by Andrew on 8/13/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit
var myPlaces = [Place]()
var activePlace = 0
var addPressed = false
class TableViewController: UITableViewController {
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let archivedPlaces = NSUserDefaults.standardUserDefaults().objectForKey("myPlaces") as? NSData
        if archivedPlaces != nil {
            let places = NSKeyedUnarchiver.unarchiveObjectWithData(archivedPlaces!)
            if places != nil {
                myPlaces = places as! [Place]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlaces.count
    }
    
    @IBAction func addButtonAction(sender: AnyObject) {
        addPressed = true
        self.performSegueWithIdentifier("showPlace", sender: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        table.reloadData()
        addPressed = false
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("placeCell", forIndexPath: indexPath)
        cell.textLabel?.text = myPlaces[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activePlace = indexPath.row
        self.performSegueWithIdentifier("showPlace", sender: nil)
    }
    
}
