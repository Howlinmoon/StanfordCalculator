//
//  StanfordCalulatorBrain.swift
//  StanfordCalculator
//
//  Created by jim Veneskey on 4/28/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import Foundation
class StanfordCalculatorBrain {
    
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = Array<Op>()
    // optional swift concise style
    //  var opStack = [Op]()
    
    // var knownOps = Dictionary<String, Op>()
    // swift concise style
    private var knownOps = [String:Op]()
    
    // aka the constructor - initializer
    init() {
        // verbose style
        knownOps["✖️"] = Op.BinaryOperation("✖️", { $0 * $1} )
        // swift concise style
        knownOps["➗"] = Op.BinaryOperation("➗") { $1 / $0}
        // swift super concise style
        knownOps["➕"] = Op.BinaryOperation("➕", +)
        knownOps["➖"] = Op.BinaryOperation("➖") { $1 - $0}
        knownOps["✔️"] = Op.UnaryOperation("✔️", sqrt)
    }
 
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) {
        // Dictionaries always return an optional (?)
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
}