//
//  FirstViewController.swift
//  ToDo List
//
//  Created by Andrew on 8/6/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit

var todoList: [[String: String]] = []

class FirstViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList = NSUserDefaults.standardUserDefaults().arrayForKey("ToDoList") as? [[String: String]] ?? []
    
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default , reuseIdentifier: "todoItem")
        cell.textLabel?.text = todoList[indexPath.row]["title"]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Description", message: todoList[indexPath.row]["description"], preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.alertClose(_:)))
            alert.view.superview?.addGestureRecognizer(tapGestureRecognizer)

        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertClose(gesture: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

