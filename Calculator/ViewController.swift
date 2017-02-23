//
//  ViewController.swift
//  Calculator
//
//  Created by Henrique Cesar on 2/23/17.
//  Copyright © 2017 Henrique Cesar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0.0
    var operand = 0.0
    var operation :Operations?
    var flushOnOperation = false
    
    func updateValue(){
        self.resultLabel.text = String(currentValue)
    }
    func flushCalc(){
        
        switch self.operation! {
            case Operations.addition:
                self.currentValue += self.operand
            
            case Operations.subtraction:
                self.currentValue -= self.operand
            
            case Operations.division:
                self.currentValue = self.operand / self.currentValue
            
            case Operations.multiplication:
                self.currentValue *= self.operand
        }
        
        self.operand = 0.0
        self.operation = nil
        self.updateValue()

    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func flushCalc(_ sender: UIButton) {
        if self.operation != nil{
            flushCalc()
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        self.currentValue = 0.0
        self.operation = nil
        self.operand = 0.0
        updateValue()
    }
    
    @IBAction func touchDigit(_ sender: UIButton, forEvent event: UIEvent) {
        let value = Double(sender.currentTitle!)!
        currentValue *= 10
        currentValue += value
        updateValue()
        self.flushOnOperation = true
    }
    
    @IBAction func touchOperation(_ sender: UIButton) {
        
        //let userDefinedAttribute = sender.value(forKeyPath: "Op")
        //let opName : String =  userDefinedAttribute as! String
        let opName = sender.currentTitle!
        let operation = Operations(rawValue: opName)!
        
        if self.operation != nil && ( self.flushOnOperation || self.operation != operation) {
            self.flushCalc()
            self.updateValue()
        }
        
        self.operation = operation
        self.operand = self.currentValue
        self.currentValue = 0.0
        self.flushOnOperation = false
    }
    
}


enum Operations: String
{
    case addition = "+"
    case subtraction = "-"
    case multiplication = "×"
    case division = "÷"
}

