//
//  ViewController.swift
//  Dicee
//
//  Created by David on 7/16/18.
//  Copyright © 2018 DigitalSuccess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView_Left: UIImageView!
    @IBOutlet weak var diceImageView_Right: UIImageView!
    
    @IBOutlet weak var rolledValue: UILabel!
    
    
    @IBOutlet weak var rolledValueLabel: UILabel!
    
    
    // Timer
    var diceTimer = Timer() // Animation Interval Timer
    var rollTime = Date()  // Length of Roll
    var startTime = Date()
    var diceRollSpeed : Double = 0.25
    var dotNumber = 1
    
    //Dice
    var randomDiceIndex_Left: Int = 0
    var randomDiceIndex_Right: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rolledValueLabel.isHidden = true
        
       rolledValue?.text = ""
        rolledValue?.isHidden = true
    }
    
   
    
    @IBAction func RollDiceButton_Pressed(_ sender: UIButton) {
    
        rollDice()
        
       // print("Left Dice: \(randomDiceIndex_Left)    |   Right Dice: \(randomDiceIndex_Right) ")
    }
    
    @IBAction func stopRoll_Pressed(_ sender: UIButton) {
        
        endDiceRoll()
    }
    /*
    @IBAction func diceToss_touched(_ gesterRecognizer: UILongPressGestureRecognizer) {
        
        if gesterRecognizer.state == .began {
            startTime = Date.init()
            rollTime = Date.init(timeIntervalSinceNow: rollDuration)
            rollDice(spinSpeed: 0.25)
            
            if gesterRecognizer.state == .changed {
                rollDuration += 0.5
                rollTime = rollTime + rollDuration
                
                rollDice(spinSpeed: rollDuration)
            }
            
            if gesterRecognizer.state == .cancelled {
                print("Roll Duration: \(rollDuration)")
                endDiceRoll()
            }
        }
    }
    */
    
    
    func rollDice() {
        
        clearRollResults()
        
        diceTimer = Timer.scheduledTimer(timeInterval: diceRollSpeed, target: self, selector: #selector(self.animateDiceRoll), userInfo: nil, repeats: true)
        
        print("timer duration: \(diceRollSpeed)")
        diceRollSpeed += 0.05
    }
    
    
    @objc func animateDiceRoll()
    {
        // Decrease animationSpeed each call
        
        self.randomDiceIndex_Left = diceRoll()
        self.randomDiceIndex_Right = diceRoll()
        diceImageView_Left.image = UIImage.init(named: "woodDice-" + "\(String(randomDiceIndex_Left))")
      //  var leftDiceImage = diceImageView_Left.image
        
        diceImageView_Right.image = UIImage.init(named: "woodDice-" + "\(String(randomDiceIndex_Right))")
      //  var rightDiceImage = diceImageView_Right.image
      
        /*
        animateDice(leftDiceImage: UIImage)
        animateDice(rightDiceImage: UIImage)
       */
        
      //  print("Left Dice: ")
        dotNumber += 1
        if dotNumber == 6 {
            dotNumber = 1
        }
        
        
    }
  
  
    
    func endDiceRoll()
    {
        diceTimer.invalidate()
        finalDiceValue()
    }
    
    func finalDiceValue()
    {
        self.randomDiceIndex_Left = diceRoll()
        self.randomDiceIndex_Right = diceRoll()
        
        // Final Dice Displayed
        diceImageView_Left.image = UIImage.init(named: "woodDice-" + "\(String(randomDiceIndex_Left))")
        diceImageView_Right.image = UIImage.init(named: "woodDice-" + "\(String(randomDiceIndex_Right))")
        
        getFinalDiceValue()
        
    }
    
    func getFinalDiceValue() {
    
        rolledValueLabel?.isHidden = false
        rolledValue?.isHidden = false
        
        rolledValue?.text = String( randomDiceIndex_Left + randomDiceIndex_Right)
        
        //test
        print("Rolled #: \(rolledValue)")
        
        
    }
    
    
    func animateDice(dice: UIImage)
    {
    
    
    }
    
    func diceRoll() -> Int {
       
        var diceResult: Int = 1
        
        repeat {
            diceResult = Int(arc4random_uniform(6) )
        }
        while (diceResult == 0)
        
       // print("Dice Result: \(diceResult)")
        
        return diceResult
        }
    
   func clearRollResults() {
    if (rolledValue?.text != nil) {
    rolledValue.text! = ""
        rolledValueLabel.isHidden = true}
    
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

