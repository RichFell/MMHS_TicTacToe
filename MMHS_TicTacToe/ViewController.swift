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

    var labelArray = [CustomLabel]()
    var turnDecider = true


    override func viewDidLoad() {
        super.viewDidLoad()

        labelArray = [labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix, labelSeven, labelEight, labelNine]
    }

    @IBAction func onLabelTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        var point = CGPoint()
        point = tapGestureRecognizer.locationInView(view)

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
            }
            }))
        alert.addAction(restartAction)

        self.presentViewController(alert, animated: true, completion: nil)

    }

    func implementAI(someLabel: CustomLabel) -> CustomLabel!
    {
        for label in labelArray
        {
            if label.canTap == true
            {
                return label 
            }
        }
//        if someLabel == labelOne
//        {
//            if labelFive.canTap == true
//            {
//                return labelFive
//            }
//            else if labelThree.canTap == true
//            {
//                return labelThree
//            }
//            else if labelSeven.canTap == true
//            {
//                return labelSeven
//            }
//            else if labelTwo.canTap == true
//            {
//                return labelTwo
//            }
//            else if labelFour.canTap == true
//            {
//                return labelFour
//            }
//            else if labelNine.canTap == true
//            {
//                return labelNine
//            }
//            else if labelEight.canTap == true
//            {
//                return labelEight
//            }
//            else
//            {
//                return labelSix
//            }
//
//        }
//        if someLabel == labelTwo
//        {
//            if labelFive.canTap == true
//            {
//                return labelFive
//            }
//            else if labelThree.canTap == true
//            {
//                return labelThree
//            }
//            else if labelOne.canTap == true
//            {
//                return labelOne
//            }
//            else if labelSeven.canTap == true
//            {
//                return labelSeven
//            }
//            else if labelFour.canTap == true
//            {
//                return labelFour
//            }
//            else if labelNine.canTap == true
//            {
//                return labelNine
//            }
//            else if labelEight.canTap == true
//            {
//                return labelEight
//            }
//            else
//            {
//                return labelSix
//            }
//        }
//        if someLabel == labelThree
//        {
//            if labelFive.canTap == true
//            {
//                return labelFive
//            }
//            else if labelTwo.canTap == true
//            {
//                return labelTwo
//            }
//            else if labelOne.canTap == true
//            {
//                return labelOne
//            }
//            else if labelSeven.canTap == true
//            {
//                return labelSeven
//            }
//            else if labelFour.canTap == true
//            {
//                return labelFour
//            }
//            else if labelNine.canTap == true
//            {
//                return labelNine
//            }
//            else if labelEight.canTap == true
//            {
//                return labelEight
//            }
//            else
//            {
//                return labelSix
//            }
//        }
//        if someLabel == labelFour
//        {
//            if labelFive.canTap == true
//            {
//                return labelFive
//            }
//            else if labelOne.canTap == true
//            {
//                return labelOne
//            }
//            else if labelSeven.canTap == true
//            {
//                return labelSeven
//            }
//            else if labelTwo.canTap == true
//            {
//                return labelTwo
//            }
//            else if labelThree.canTap == true
//            {
//                return labelThree
//            }
//            else if labelNine.canTap == true
//            {
//                return labelNine
//            }
//            else if labelEight.canTap == true
//            {
//                return labelEight
//            }
//            else
//            {
//                return labelSix
//            }
//        }
//        if someLabel == labelFive
//        {
//            if labelFive.canTap == true
//            {
//                return labelFive
//            }
//            else if labelOne.canTap == true
//            {
//                return labelOne
//            }
//            else if labelSeven.canTap == true
//            {
//                return labelSeven
//            }
//            else if labelTwo.canTap == true
//            {
//                return labelTwo
//            }
//            else if labelThree.canTap == true
//            {
//                return labelThree
//            }
//            else if labelNine.canTap == true
//            {
//                return labelNine
//            }
//            else if labelEight.canTap == true
//            {
//                return labelEight
//            }
//            else
//            {
//                return labelSix
//            }
//        }
        return nil
    }
}



