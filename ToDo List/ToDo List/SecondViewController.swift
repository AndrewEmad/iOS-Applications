//
//  SecondViewController.swift
//  ToDo List
//
//  Created by Andrew on 8/6/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var Description: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Description.layer.borderWidth = 0.4
        Description.layer.cornerRadius = 5
        Description.layer.borderColor = UIColor.grayColor().CGColor
        todoTitle.layer.borderWidth = 0.4
        todoTitle.layer.cornerRadius = 5
        todoTitle.layer.borderColor = UIColor.grayColor().CGColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addNewTodoItem(sender: UIButton) {
        let title = todoTitle.text!
        let desc = Description.text!
        if title == "" {
            let alert = UIAlertController(title: "Error", message: "Title Cannot Be Empty !", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.alertClose(_:)))
                alert.view.superview?.addGestureRecognizer(tapGestureRecognizer)
                
            })

            return
        }
        todoList.append(["title": title , "description": desc])
        NSUserDefaults.standardUserDefaults().setObject(todoList, forKey: "ToDoList")
        todoTitle.text = ""
        Description.text = ""
    }
    
    func alertClose(gesture: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

