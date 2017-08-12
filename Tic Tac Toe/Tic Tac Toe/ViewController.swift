//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Andrew on 8/10/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var turn = 0
    @IBOutlet weak var gridView: UIView!
    
    var board: [[UIButton]] = [[UIButton(),UIButton(),UIButton()],[UIButton(),UIButton(),UIButton()],[UIButton(),UIButton(),UIButton()]]
    var boardState = [[0,0,0],[0,0,0],[0,0,0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(gridView)
        board[0][0].layer.borderColor = UIColor.blackColor().CGColor
        board[0][0].layer.borderWidth = 1
        board[0][0].tag=0
        board[0][0].translatesAutoresizingMaskIntoConstraints = false
        board[0][0].addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        var leftConstraint = NSLayoutConstraint(
            item: board[0][0],
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gridView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1,
            constant: 0
        )
        var topConstraint = NSLayoutConstraint(
            item: board[0][0],
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gridView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: 0
        )
        var widthConstraint = NSLayoutConstraint(
            item: board[0][0],
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gridView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.333,
            constant: 0
        )
        var heightConstraint = NSLayoutConstraint(
            item: board[0][0],
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gridView,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.333,
            constant: 0
        )
        self.view.addSubview(board[0][0])
        board[0][0].titleLabel?.font = UIFont.systemFontOfSize(50)

        self.view.addConstraint(leftConstraint)
        self.view.addConstraint(topConstraint)
        self.view.addConstraint(widthConstraint)
        self.view.addConstraint(heightConstraint)
        
        for i in 0..<3
        {
            if i != 0 {
                board[i][0].tag=i*3
                board[i][0].addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
                board[i][0].translatesAutoresizingMaskIntoConstraints = false
                board[i][0].titleLabel?.font = UIFont.systemFontOfSize(50)
                board[i][0].layer.borderColor = UIColor.blackColor().CGColor
                board[i][0].layer.borderWidth = 1
                leftConstraint = NSLayoutConstraint(
                    item: board[i][0],
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: gridView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1,
                    constant: 0
                )
                topConstraint = NSLayoutConstraint(
                    item: board[i][0],
                    attribute: NSLayoutAttribute.Top,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: board[i-1][0],
                    attribute: NSLayoutAttribute.Bottom,
                    multiplier: 1,
                    constant: 0
                )
                widthConstraint = NSLayoutConstraint(
                    item: board[i][0],
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: board[0][0],
                    attribute: NSLayoutAttribute.Width,
                    multiplier: 1,
                    constant: 0
                )
                heightConstraint = NSLayoutConstraint(
                    item: board[i][0],
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: board[0][0],
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 1,
                    constant: 0
                )
                self.view.addSubview(board[i][0])
                self.view.addConstraint(leftConstraint)
                self.view.addConstraint(topConstraint)
                self.view.addConstraint(widthConstraint)
                self.view.addConstraint(heightConstraint)

            }
            board[i][0].tag = i*3
            for j in 1..<3
            {
                board[i][j].tag=i*3+j
                board[i][j].translatesAutoresizingMaskIntoConstraints = false
                board[i][j].titleLabel?.font = UIFont.systemFontOfSize(50)
                board[i][j].addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
                board[i][j].layer.borderColor = UIColor.blackColor().CGColor
                board[i][j].layer.borderWidth = 1
                if i == 0
                {
                    topConstraint = NSLayoutConstraint(
                        item: board[i][j],
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: gridView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1,
                        constant: 0
                    )
                }
                else
                {
                    topConstraint = NSLayoutConstraint(
                        item: board[i][j],
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: board[i-1][j],
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1,
                        constant: 0
                    )
                }
                
                
                leftConstraint = NSLayoutConstraint(
                    item: board[i][j],
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: board[i][j-1],
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1,
                    constant: 0
                )
                widthConstraint = NSLayoutConstraint(
                    item: board[i][j],
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: board[0][0],
                    attribute: NSLayoutAttribute.Width,
                    multiplier: 1,
                    constant: 0
                )
                heightConstraint = NSLayoutConstraint(
                    item: board[i][j],
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: board[0][0],
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 1,
                    constant: 0
                )
                
                self.view.addSubview(board[i][j])
                self.view.addConstraint(leftConstraint)
                self.view.addConstraint(topConstraint)
                self.view.addConstraint(widthConstraint)
                self.view.addConstraint(heightConstraint)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClick(sender: UIButton) {
        if turn >= 9 {
            return
        }
        var row = sender.tag / 3
        var col = sender.tag % 3
        if boardState[row][col] != 0
        {
            return
        }
        board[row][col].setTitle("X" , forState: .Normal)
        board[row][col].setTitleColor(.blueColor() , forState:  .Normal)
        boardState[row][col] = 1
        turn += 1
        if checkState() {
            turn = 9
            return
        }
        let computerTurn = solve(boardState,level: 2)
        row = computerTurn / 3
        col = computerTurn % 3
        board[row][col].setTitle("O" , forState: .Normal)
        board[row][col].setTitleColor(.redColor() , forState:  .Normal)
        boardState[row][col] = 2
        turn += 1
        if checkState() {
            turn = 9
            return
        }
    }
    
    func checkState() -> Bool
    {
        let utility = utilityFunction(boardState)
        if utility == 1 {
            let alert = UIAlertController(title: "You Win !", message: "Congratulations, You Win !", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.alertClose(_:)))
                alert.view.superview?.addGestureRecognizer(tapGestureRecognizer)
                
            })

            return true
        }
        else if utility == -1 {
            let alert = UIAlertController(title: "You Lose !", message: "Unfortunately, You Lose !", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.alertClose(_:)))
                alert.view.superview?.addGestureRecognizer(tapGestureRecognizer)
                
            })

            return true
            
        }
        else if turn == 9 {
            let alert = UIAlertController(title: "Draw", message: "Draw !", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.alertClose(_:)))
                alert.view.superview?.addGestureRecognizer(tapGestureRecognizer)
                
            })

            return true
        }
        return false

    }
    func alertClose(gesture: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func resetGame(sender: AnyObject) {
        turn = 0
        
        for i in 0..<3
        {
            for j in 0..<3
            {
                boardState[i][j]=0
                board[i][j].setTitle("",forState: .Normal)
            }
        }

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
            if state[0][2] == 1
            {
                return 1
            }
            else if state[0][2] == 2
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














