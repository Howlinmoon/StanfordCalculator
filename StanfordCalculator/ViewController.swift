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

    var operandStack = Array<Double>()
    

    @IBAction func enter() {
        UserInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
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
    
    @IBAction func operation(sender: UIButton) {
        let operation = sender.currentTitle!
        if UserInTheMiddleOfTypingANumber {
            enter()
        }

        // refactoring more and more from "X" onward
        switch operation {
            case "✖️": performOperation({ (op1: Double, op2: Double) -> Double in return op1 * op2})
            
            case "➗": performOperation({ (op1, op2)  in return op2 / op1})
            
            case "➕": performOperation({ (op1, op2)  in op1 + op2})
            
            case "➖": performOperation { $1 - $0}

            case "✔️": performOperation { sqrt($0)}

        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
        
    }

    
}

