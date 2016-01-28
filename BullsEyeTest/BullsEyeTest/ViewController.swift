//
//  ViewController.swift
//  BullsEyeTest
//
//  Created by Patrick Little on 25/01/2016.
//  Copyright © 2016 Patrick Little. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentVal: Int = 0
    var target = 0
    var score = 0
    var round = 0

    //Called on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup main slider images
        
        let sliderThumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(sliderThumbImageNormal, forState: .Normal)
        
        let sliderThumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(sliderThumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let sliderTrackLeftImage = UIImage(named: "SliderTrackLeft") {
            let sliderTrackLeftResizable = sliderTrackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(sliderTrackLeftResizable, forState: .Normal)
        }
        
        if let sliderTrackRightImage = UIImage(named: "SliderTrackRight") {
            let sliderTrackRightResizable = sliderTrackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(sliderTrackRightResizable, forState: .Normal)
        }
        
        //Start new round
        newRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Start a new round, called when score modal is dismissed
    func newRound(){
        round++
        target = 1 + Int(arc4random_uniform(100))
        slider.value = 50
        currentVal = lroundf(slider.value)
        updateLabels()
    }
    
    //Update the labels for the game, called at each new round
    func updateLabels(){
        targetLabel.text = String(target)
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    
    //Show the score alert, called when "hit me!" button is pressed
    @IBAction func showAlert(){
        
        //Calculate score
        let diff = abs(currentVal - target)
        
        var pts = 100-diff
        
        //Calculate alert message based on score
        var message = ""
        
        if diff==0{
            message = "Perfect! (100 bonus points!)"
            pts+=100
        }else if diff <= 10{
            message = "You almost had it!"
        }else if diff <= 50{
            message = "Agh! Try again!"
        }else if diff < 90{
            message = "Not even close!"
        }else{
            message = "Whoops! Are you even trying?"
        }
        
        score += pts
        
        //Create alert, add dismissal action
        let alert = UIAlertController(title: message,
            message: "You were off by \(diff) and scored \(pts) points!",
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Again!", style: .Default, handler: { action in
                                                                                self.newRound()
                                                                              })
        
        alert.addAction(action)
        
        
        //Show alert
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //For the startOver button
    @IBAction func startOver(){
        score = 0
        round = 0
        newRound()
        
        //Add transition to new game
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    
    //Calculates the slider value, called when slider moves
    @IBAction func sliderMoved(slider: UISlider){
        currentVal = lroundf(slider.value)
    }


}

