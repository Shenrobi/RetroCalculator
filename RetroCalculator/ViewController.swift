//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Terrell Robinson on 8/30/16.
//  Copyright © 2016 Terrell Robinson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var outputLBL: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    var buttonSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn 2", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        outputLBL.text = "0"
        
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLBL.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
        
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(operation: .Empty)
    }
    
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Empty {
                    result.removeAll()
                    outputLBL.text = "0"
                }
                
                leftValStr = result
                outputLBL.text = result
            }
            
            currentOperation = operation
        } else {
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
    }


}

