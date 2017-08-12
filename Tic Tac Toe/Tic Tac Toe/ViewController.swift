//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Andrew on 8/10/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    
    var boardState = [[0,0,0],[0,0,0],[0,0,0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button1Click(sender: AnyObject) {
    }
    @IBAction func button2Click(sender: AnyObject) {
    }
    @IBAction func button3Click(sender: AnyObject) {
    }
    @IBAction func button4Click(sender: AnyObject) {
    }
    @IBAction func button5Click(sender: AnyObject) {
    }
    @IBAction func button6Click(sender: AnyObject) {
    }
    @IBAction func button7Click(sender: AnyObject) {
    }
    @IBAction func button8Click(sender: AnyObject) {
    }
    @IBAction func button9Click(sender: AnyObject) {
    }
    
    func utilityFunction(state: [[Int]])-> Int{
        for i in 0...2
        {
            if state[i][0]==state[i][1] && state[i][1] == state[i][2]
            {
                if state[i][0] == 1
                {
                    return 1
                }
                else if state[i][0] == 2
                {
                    return -1
                }
            }
            if state[0][i]==state[1][i] && state[2][i] == state[1][i]
            {
                if state[0][i] == 1
                {
                    return 1
                }
                else if state[0][i] == 2
                {
                    return -1
                }
            }
            
        }
        
        if state[0][0]==state[1][1] && state[1][1] == state[2][2]
        {
            if state[0][0] == 1
            {
                return 1
            }
            else if state[0][0] == 2
            {
                return -1
            }
        }
        
        if state[0][2]==state[1][1] && state[1][1] == state[2][0]
        {
            if state[0][0] == 1
            {
                return 1
            }
            else if state[0][0] == 2
            {
                return -1
            }
        }
        
        return 0;
    }
    
    
    func solveForMin(state: [[Int]] , level: Int)-> Int {
        if level == 0 {
            return utilityFunction(state)
        }
        var min = 10
        var mutableState = state
        for i in 0...2
        {
            for j in 0...2
            {
                if state[i][j] == 0 {
                    mutableState[i][j] = 2
                    let utility = solveForMax(mutableState,level: level-1)

                    if min > utility
                    {
                        min = utility
                    }
                    mutableState[i][j] = 0
                }
            }
        }
        return min
    }
    
    
    func solveForMax(state:[[Int]],level: Int) -> Int {
        if level == 0 {
            return utilityFunction(state)
        }
        var max = -10
        var mutableState = state
        for i in 0...2
        {
            for j in 0...2
            {
                if state[i][j] == 0 {
                    mutableState[i][j] = 1
                    let utility = solveForMin(mutableState,level: level-1)
                    
                    if max < utility
                    {
                        max = utility
                    }
                    mutableState[i][j] = 0
                }
            }
        }
        
        return max
    }
    
    
    func solve(state: [[Int]], level: Int) -> Int
    {
        var idx = -1
        var min = 10
        var mutableState = state
        for i in 0...2
        {
            for j in 0...2
            {
                if state[i][j] == 0 {
                    mutableState[i][j] = 2
                    let utility = solveForMax(mutableState,level: level - 1)
                    if min > utility
                    {
                        idx = i*3+j
                        min = utility
                    }
                    mutableState[i][j] = 0
                }
            }
        }
        
        return idx
    }
    
}














