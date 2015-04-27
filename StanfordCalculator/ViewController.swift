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
    
    @IBAction func operation(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }

        // refactoring more and more from "X" onward
        switch operation {
            case "✖️": performOperation({ (op1: Double, op2: Double) -> Double in return op1 * op2})
            
            case "➗": performOperation({ (op1, op2)  in return op2 / op1})
            
            case "➕": performOperation({ (op1, op2)  in op1 + op2})
            
            case "➖": performOperation { $1 - $0}

//            case "✔️": performOperation { sqrt($0)}

        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        } else {
            println("Not enough values on the stack, need minimum of 2")
        }
    }


    
}

