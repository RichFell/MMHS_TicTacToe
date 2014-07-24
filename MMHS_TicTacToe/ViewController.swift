//
//  ViewController.swift
//  MMHS_TicTacToe
//
//  Created by Richard Fellure on 7/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
                            
   
    @IBOutlet var labelBackgroundView: UIView!
    @IBOutlet weak var imageViewOne: CustomImageView!
    @IBOutlet weak var imageViewTwo: CustomImageView!
    @IBOutlet weak var imageViewThree: CustomImageView!
    @IBOutlet weak var imageViewFour: CustomImageView!
    @IBOutlet weak var imageViewFive: CustomImageView!
    @IBOutlet weak var imageViewSix: CustomImageView!
    @IBOutlet weak var imageViewSeven: CustomImageView!
    @IBOutlet weak var imageViewEight: CustomImageView!
    @IBOutlet weak var imageViewNine: CustomImageView!
    @IBOutlet weak var indicatorImageView: CustomImageView!

    var imageViewArray : [CustomImageView] = []
    var turnDecider = true//true will mean it is X's turn false = O's turn
    var turnCount = 0
    var indicatorImageViewCenter = CGPoint()



    override func viewDidLoad()
    {
        super.viewDidLoad()

        imageViewArray = [imageViewOne, imageViewTwo, imageViewThree, imageViewFour, imageViewFive, imageViewSix, imageViewSeven, imageViewEight, imageViewNine]
        indicatorImageViewCenter = indicatorImageView.center
    }

    //Function utilizing the UITapGestureRecognizer when a tap is recognized, to find the point of the tap
    @IBAction func onLabelTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        var imageView = findImageView(tapGestureRecognizer.locationInView(labelBackgroundView))

        decideImage(imageView)
    }
    //Function utilizing the UIPanGestureRecognizer. Shows where the point is in the code and moves the label accordingly, also changes the labels in the grid if the indicatorLabel is moved within their frame
    @IBAction func onLabelDrag(panGestureRecognizer: UIPanGestureRecognizer)
    {
        var point = panGestureRecognizer.locationInView(view)
        indicatorImageView.center = CGPointMake(point.x, point.y)

        if panGestureRecognizer.state == UIGestureRecognizerState.Ended
        {
            var imageView = findImageView(panGestureRecognizer.locationInView(labelBackgroundView))
            indicatorImageView.center = indicatorImageViewCenter

            if imageView != nil
            {
                if CGRectContainsPoint(imageView.frame, panGestureRecognizer.locationInView(labelBackgroundView))
                {
                    decideImage(imageView)
                }
            }
        }
    }

    //Function to find the Label in the grid that is either being tapped or the PanGesture recognizer is over
    func findImageView(point: CGPoint) -> CustomImageView!
    {
        for imageView in imageViewArray
        {
            if CGRectContainsPoint(imageView.frame, point)
            {
                return imageView
            }
        }
        return nil
    }
    //This function is used to decide what the text of the indicatorLabel will be
    func switchIndicatorImage()
    {
        if turnDecider == true
        {
            indicatorImageView.image = UIImage(named: "image_1")
            indicatorImageView.selection = 1
        }
        else
        {
            indicatorImageView.image = UIImage(named: "image_2")
            indicatorImageView.selection = 2
        }
    }

    //Function that evaluates to see if there is a winner, and if their is to show our end of game alert
    func decideWinner()
    {
        if imageViewOne.selection == imageViewTwo.selection && imageViewTwo.selection == imageViewThree.selection && imageViewThree.canTap == false && imageViewThree.selection != 0
        {
            winningAlertShow(imageViewThree.selection)
        }
        if imageViewFour.selection == imageViewFive.selection && imageViewFive.selection == imageViewSix.selection && imageViewSix.canTap == false && imageViewSix.selection != 0
        {
            winningAlertShow(imageViewSix.selection)
        }
        if imageViewSeven.selection == imageViewEight.selection && imageViewEight.selection == imageViewNine.selection && imageViewNine.canTap == false && imageViewNine.selection != 0
        {
            winningAlertShow(imageViewNine.selection)
        }
        if imageViewOne.selection == imageViewFour.selection && imageViewFour.selection == imageViewSeven.selection && imageViewSeven.canTap == false && imageViewSeven.selection != 0
        {
            winningAlertShow(imageViewSeven.selection)
        }
        if imageViewTwo.selection == imageViewFive.selection && imageViewFive.selection == imageViewEight.selection && imageViewEight.canTap == false && imageViewEight.selection != 0
        {
            winningAlertShow(imageViewEight.selection)
        }
        if imageViewThree.selection == imageViewSix.selection && imageViewSix.selection == imageViewNine.selection && imageViewNine.canTap == false && imageViewNine.selection != 0
        {
            winningAlertShow(imageViewNine.selection)
        }
        if imageViewOne.selection == imageViewFive.selection && imageViewFive.selection == imageViewNine.selection && imageViewNine.canTap == false && imageViewNine.selection != 0
        {
            winningAlertShow(imageViewNine.selection)
        }
        if imageViewThree.selection == imageViewFive.selection && imageViewFive.selection ==  imageViewSeven.selection && imageViewSeven.canTap == false && imageViewSeven.selection != 0
        {
            winningAlertShow(imageViewSeven.selection)
        }
    }

    //Function to figure out what the text of our CustomLabel will be once we have found the one we are tapping or that moved our indicatorLabel over
    func decideImage(imageView: CustomImageView)
    {
        if imageView.canTap == true
        {
            imageView.canTap = false

            if turnDecider == true
            {
                imageView.image = UIImage(named: "image_1")
                imageView.selection = 1
                turnDecider = false

                basicAI()

                switchIndicatorImage()

                turnCount++
                decideWinner()
                noWinner()
            }
        }
    }

    //Function to show our AlertController and then use the AlertAction to reset the game
    func winningAlertShow(intSelection: Int)
    {
        let alert = UIAlertController(title: "\(intSelection) is the Winner", message: nil, preferredStyle: .Alert)

        let restartAction = UIAlertAction(title: "Restart", style: .Default, handler: ({ action in

            for imageView in self.imageViewArray
            {
                imageView.image = UIImage(named: "default_image")
                imageView.selection = 0
                imageView.canTap = true
                self.turnDecider = true
                self.turnCount = 0
                self.switchIndicatorImage()

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
            winningAlertShow(0)
            switchIndicatorImage()
        }
    }

    func basicAI()
    {
        for imageView in imageViewArray
        {
            if imageView.canTap == true
            {
                imageView.image = UIImage(named: "image_2")
                imageView.canTap = false
                self.turnDecider = true
                self.turnCount++
                imageView.alpha = 0.0;
                imageView.selection = 2
                UIView.animateWithDuration(1.0, animations: {
                    imageView.alpha = 1.0;
                    })
                break
            }
        }

    }


   }



