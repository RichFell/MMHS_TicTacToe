//
//  ViewController.swift
//  MMHS_TicTacToe
//
//  Created by Richard Fellure on 7/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var indicatorLabel: UILabel
    @IBOutlet var labelOne: CustomLabel
    @IBOutlet var labelTwo: CustomLabel
    @IBOutlet var labelThree: CustomLabel
    @IBOutlet var labelFour: CustomLabel
    @IBOutlet var labelFive: CustomLabel
    @IBOutlet var labelSix: CustomLabel
    @IBOutlet var labelSeven: CustomLabel
    @IBOutlet var labelEight: CustomLabel
    @IBOutlet var labelNine: CustomLabel

    @IBOutlet var labelBackgroundView: UIView
    var labelArray = [CustomLabel]()
    var turnDecider = true
    var turnCount = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        labelArray = [labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix, labelSeven, labelEight, labelNine]
        switchIndicatorLabel()
    }

    @IBAction func onLabelTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        var point = CGPoint()
        point = tapGestureRecognizer.locationInView(labelBackgroundView)

        var label = findLabel(point)

        if label != nil

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
    }

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

    func noWinner()
    {
        if turnCount == 9
        {
            winningAlertShow("No one")
            switchIndicatorLabel()
        }
    }

   }



