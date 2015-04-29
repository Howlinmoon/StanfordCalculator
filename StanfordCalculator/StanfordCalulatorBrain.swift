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
    
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            // Note - since all possibilities/cases of op are handled - no need for default case
            switch op {
            case .Operand(let operand):
                return(operand, remainingOps)
            
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        return result
    }
    
 
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) {
        // Dictionaries always return an optional (?)
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
}