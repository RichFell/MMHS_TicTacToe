//
//  ViewController.swift
//  MMHS_TicTacToe
//
//  Created by Richard Fellure on 7/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var indicatorLabel: UILabel!
    @IBOutlet var labelOne: CustomLabel!
    @IBOutlet var labelTwo: CustomLabel!
    @IBOutlet var labelThree: CustomLabel!
    @IBOutlet var labelFour: CustomLabel!
    @IBOutlet var labelFive: CustomLabel!
    @IBOutlet var labelSix: CustomLabel!
    @IBOutlet var labelSeven: CustomLabel!
    @IBOutlet var labelEight: CustomLabel!
    @IBOutlet var labelNine: CustomLabel!

    @IBOutlet var labelBackgroundView: UIView!
    var labelArray = [CustomLabel]()
    var turnDecider = true
    var turnCount = 0
    var indicatorLabelCenter = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()

        labelArray = [labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix, labelSeven, labelEight, labelNine]
        switchIndicatorLabel()

        indicatorLabelCenter = indicatorLabel.center
    }

    //Function utilizing the UITapGestureRecognizer when a tap is recognized, to find the point of the tap
    @IBAction func onLabelTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        var label = findLabel(tapGestureRecognizer.locationInView(labelBackgroundView))

        decideLabelText(label)
    }
    //Function utilizing the UIPanGestureRecognizer. Shows where the point is in the code and moves the label accordingly, also changes the labels in the grid if the indicatorLabel is moved within their frame
    @IBAction func onLabelDrag(panGestureRecognizer: UIPanGestureRecognizer)
    {
        var point = panGestureRecognizer.locationInView(view)
        indicatorLabel.center = CGPointMake(point.x, point.y)

        if panGestureRecognizer.state == UIGestureRecognizerState.Ended
        {
            var label = findLabel(panGestureRecognizer.locationInView(labelBackgroundView))
            indicatorLabel.center = indicatorLabelCenter

            if label != nil
            {
                if CGRectContainsPoint(label.frame, panGestureRecognizer.locationInView(labelBackgroundView))
                {
                    decideLabelText(label)
                }
            }
        }
    }

    //Function to find the Label in the grid that is either being tapped or the PanGesture recognizer is over
    func findLabel(point: CGPoint) -> CustomLabel!
    {
        for label in labelArray
        {
            if CGRectContainsPoint(label.frame, point)
            {
                return label
            }
        }
        return nil
    }
    //This function is used to decide what the text of the indicatorLabel will be
    func switchIndicatorLabel()
    {
        if turnDecider == true
        {
            indicatorLabel.text = "X"
            indicatorLabel.textColor = UIColor.blueColor()
        }
        else
        {
            indicatorLabel.textColor = UIColor.redColor()
            indicatorLabel.text = "O"
        }
    }

    //Function that evaluates to see if there is a winner, and if their is to show our end of game alert
    func decideWinner()
    {
        if labelOne.text == labelTwo.text && labelTwo.text == labelThree.text && labelOne.canTap == false
        {
            winningAlertShow(labelOne.text)
        }
        if labelFour.text == labelFive.text && labelFive.text == labelSix.text && labelSix.canTap == false
        {
            winningAlertShow(labelSix.text)
        }
        if labelSeven.text == labelEight.text && labelEight.text == labelNine.text && labelNine.canTap == false
        {
            winningAlertShow(labelNine.text)
        }
        if labelOne.text == labelFour.text && labelFour.text == labelSeven.text && labelSeven.canTap == false
        {
            winningAlertShow(labelSeven.text)
        }
        if labelTwo.text == labelFive.text && labelFive.text == labelEight.text && labelEight.canTap == false
        {
            winningAlertShow(labelEight.text)
        }
        if labelThree.text == labelSix.text && labelSix.text == labelNine.text && labelNine.canTap == false
        {
            winningAlertShow(labelNine.text)
        }
        if labelOne.text == labelFive.text && labelFive.text == labelNine.text && labelNine.canTap == false
        {
            winningAlertShow(labelNine.text)
        }
        if labelThree.text == labelFive.text && labelFive.text ==  labelSeven.text && labelSeven.canTap == false
        {
            winningAlertShow(labelSeven.text)
        }
    }

    //Function to figure out what the text of our CustomLabel will be once we have found the one we are tapping or that moved our indicatorLabel over
    func decideLabelText(label: CustomLabel)
    {

        if label.canTap == true
        {
            label.canTap = false

            if turnDecider == true
            {
                label.text = "X"
                label.textColor = UIColor.blueColor()
                turnDecider = false
            }
            else
            {
                label.text = "O"
                label.textColor = UIColor.redColor()
                turnDecider = true
            }
            switchIndicatorLabel()

            turnCount++
            noWinner()

            decideWinner()
        }
    }

    //Function to show our AlertController and then use the AlertAction to reset the game
    func winningAlertShow(labelString: String)
    {
        let alert = UIAlertController(title: "\(labelString) is the Winner", message: nil, preferredStyle: .Alert)

        let restartAction = UIAlertAction(title: "Restart", style: .Default, handler: ({ action in

            for label in self.labelArray
            {
                label.text = ""
                label.canTap = true
                self.turnDecider = true
                self.turnCount = 0
                self.switchIndicatorLabel()
            }
            }))
        alert.addAction(restartAction)

        self.presentViewController(alert, animated: true, completion: nil)

    }

    //Function to decide if their is no winner to show our alert and reset the game.
    func noWinner()
    {
        if turnCount == 9
        {
            winningAlertShow("No one")
            switchIndicatorLabel()
        }
    }

   }



