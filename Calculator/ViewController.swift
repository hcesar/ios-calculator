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
    var decimalPlaces = 0
    var decimalPlacesSelected = false
    
    @IBOutlet weak var resultLabel: UILabel!
    
    func updateValue(){
        let format = "%." + String(self.decimalPlaces-1) + "f"
        self.resultLabel.text = String(format: format, currentValue)
    }

    func flushCalc(){
        
        switch self.operation! {
            case Operations.addition:
                self.currentValue += self.operand
            
            case Operations.subtraction:
                self.currentValue = self.operand - self.currentValue

            case Operations.division:
                self.currentValue = self.operand / self.currentValue
            
            case Operations.multiplication:
                self.currentValue *= self.operand
        }
        
        self.operand = 0.0
        self.operation = nil
        self.updateValue()

    }
    
    func resetDecimalPlaces(){
        self.decimalPlacesSelected = false
        self.decimalPlaces = 0
    }
    
    @IBAction func flushCalc(_ sender: UIButton) {
        if self.operation != nil{
            flushCalc()
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        self.currentValue = 0.0
        self.operation = nil
        self.operand = 0.0
        self.resetDecimalPlaces()
        self.updateValue()
    }
    
    @IBAction func touchDigit(_ sender: UIButton, forEvent event: UIEvent) {
        var value = Double(sender.currentTitle!)!
        
        if(decimalPlacesSelected){
            value = (value / pow(10, Double(self.decimalPlaces)))
            self.decimalPlaces += 1
            currentValue += value
        }
        else{
            currentValue *= 10
            currentValue += value
        }
        
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
        self.resetDecimalPlaces()
    }
    
    @IBAction func touchSignInverter(_ sender: UIButton) {
        if self.operation != nil{
            self.flushCalc()
        }
        self.currentValue = -self.currentValue
        self.updateValue()
    }
    
    @IBAction func touchPercent(_ sender: UIButton) {
        if self.operation != nil{
            self.currentValue = (self.operand * (self.currentValue / 100))
        }
        else{
            self.currentValue = (self.currentValue / 100)
        }
        
        self.updateValue()
        self.resetDecimalPlaces()
    }
    
    @IBAction func touchDot(_ sender: UIButton) {
        if !self.decimalPlacesSelected{
            self.decimalPlacesSelected = true;
            self.decimalPlaces = 1;
            self.updateValue()
        }
    }
}


enum Operations: String
{
    case addition = "+"
    case subtraction = "-"
    case multiplication = "×"
    case division = "÷"
}

