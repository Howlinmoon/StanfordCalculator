//
//  ViewController.swift
//  StanfordCalculator
//
//  Created by Jim Veneskey on 4/26/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit

// Original code as per Stanford tutorial
// class ViewController: UIViewController
// Removed the sub-classing of UIViewController as per
// http://stackoverflow.com/questions/29457720/compiler-error-method-with-objective-c-selector-conflicts-with-previous-declara/29457777#29457777
// Seemed to fix the issue, but the best fix is reverting to XCode 6.1.1
class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var UserInTheMiddleOfTypingANumber = false
    
    var brain = StanfordCalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        println("digit = \(digit)")
        
        if UserInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            UserInTheMiddleOfTypingANumber = true
        }
        
    }

    @IBAction func operate(sender: UIButton) {
        if UserInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
            
        }
    }

    

    @IBAction func enter() {
        UserInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }

    }
    
    
    

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            UserInTheMiddleOfTypingANumber = false
        }
    }

    
}

