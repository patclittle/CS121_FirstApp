//
//  ViewController.swift
//  BullsEyeTest
//
//  Created by Patrick Little on 25/01/2016.
//  Copyright © 2016 Patrick Little. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentVal: Int = 0
    var target = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newRound(){
        round++
        target = 1 + Int(arc4random_uniform(100))
        slider.value = 50
        currentVal = lroundf(slider.value)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(target)
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    
    @IBAction func showAlert(){
        let valMessage = "You guessed \(currentVal)"
        
        let targetMessage = "The target value is \(target)"
        
        let diff = abs(currentVal - target)
        let pts = 100-diff
        
        let alert = UIAlertController(title: "You scored \(pts) points!",
            message: valMessage+"\n"+targetMessage,
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Again!", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
        score += pts
        
        newRound()
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        currentVal = lroundf(slider.value)
    }


}

