//
//  ViewController.swift
//  IOSCalculator
//
//  Created by Юлия Гудошникова on 12.09.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var numberFromScreen:Double = 0;
    var firstNumber:Double = 0;
    var operation:Int = 17;
    var mathSign:Bool = false;
    
    @IBOutlet weak var expression: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var acButton: UIButton!
    
    @IBOutlet weak var divided: UIButton!
    
    func formatResult(results: Double) -> String
        {
            if(results.truncatingRemainder(dividingBy: 1) == 0)
            {
                return String(format: "%.0f", results)
            }
            else
            {
                return String(format: "%.2f", results)
            }
        }
    
    @IBAction func digits(_ sender: UIButton) {
        if result.text == "0" {
            result.text = ""
        }
        if mathSign == true {
            result.text = String(sender.tag)
            mathSign = false
        }
        else {
            if result.text == "-0" {
                result.text = "-" + String(sender.tag)
            }
            else {
                result.text = result.text! + String(sender.tag)
            }
        }
        numberFromScreen = Double(result.text!)!
        
    }
    
    func checkResult() {
        var res:Double = numberFromScreen
        if operation == 13 {
            result.text = String(firstNumber / numberFromScreen)
            res = firstNumber / numberFromScreen
        }
        else if operation == 14 {
            result.text = String( firstNumber * numberFromScreen)
            res = firstNumber * numberFromScreen
        }
        else if operation == 15 {
            result.text = String(firstNumber - numberFromScreen)
            res = firstNumber - numberFromScreen
        }
        else if operation == 16 {
            result.text = String(firstNumber + numberFromScreen)
            res = firstNumber + numberFromScreen
        }
       result.text = formatResult(results: res)
        
    }
    
    @IBAction func functionButtons(_ sender: UIButton) {
        expression.text = expression.text! + result.text!
        if result.text != "" && sender.tag != 10 && sender.tag != 12 && sender.tag != 11 && sender.tag != 17 {
            checkResult()
            firstNumber = Double(result.text!)!
            // деление
            if sender.tag == 13 {
                result.text = "÷"
            }
            // умножение
            if sender.tag == 14 {
                result.text = "×"
            }
            // вычитание
            if sender.tag == 15 {
                result.text = "-"
            }
            // сложение
            if sender.tag == 16 {
                result.text = "+"
            }
            operation = sender.tag
            mathSign = true;
            expression.text = expression.text! + result.text!
        }
        else if sender.tag == 17 {
            var res:Double = numberFromScreen
            if operation == 13 {
                result.text = String(firstNumber / numberFromScreen)
                res = firstNumber / numberFromScreen
            }
            else if operation == 14 {
                result.text = String( firstNumber * numberFromScreen)
                res = firstNumber * numberFromScreen
            }
            else if operation == 15 {
                result.text = String(firstNumber - numberFromScreen)
                res = firstNumber - numberFromScreen
            }
            else if operation == 16 {
                result.text = String(firstNumber + numberFromScreen)
                res = firstNumber + numberFromScreen
            }
           result.text = formatResult(results: res)
            expression.text = result.text
            firstNumber = 0
        }
        else if sender.tag == 10 {
            if (result.text! == "0") {
                result.text = "0"
                firstNumber = 0
                numberFromScreen = 0
                operation = 17
                expression.text = ""
            } else {
                result.text = "0"
                numberFromScreen = 0
            }
        }
        else if sender.tag == 12 {
            var res:Double = numberFromScreen / 100
            result.text = formatResult(results: res)
            numberFromScreen = numberFromScreen / 100
            expression.text = expression.text! + result.text!
        } else if sender.tag == 11 {
            var res:Double = Double(result.text!)! * (-1)
            result.text = formatResult(results: res)
            numberFromScreen = numberFromScreen * (-1)
            expression.text = expression.text! + result.text!
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        result.text = result.text! + "."
        numberFromScreen = Double(result.text!)!
        expression.text = expression.text! + "."
    }
}

