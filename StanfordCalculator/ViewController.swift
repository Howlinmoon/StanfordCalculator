//
//  ViewController.swift
//  StanfordCalculator
//
//  Created by Jim Veneskey on 4/26/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        println("digit = \(digit)")
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
            
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }

    var operandStack = Array<Double>()
    

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

