//
//  ViewController.swift
//  calculator
//
//  Created by Rollin Francois on 3/10/16.
//  Copyright © 2016 Rollin Francois. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
        
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    // the number that the user enters
    var runningNumber: String = ""
    var leftVarStr: String = ""
    var rightVarStr: String = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set where the file lives in the file system
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        // load URL
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            // assign audio player to button
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
         print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDivePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            // run some math
            if runningNumber != "" {
                rightVarStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                }
                
                leftVarStr = result
                
                outputLbl.text = result
            }
            
            currentOperation = op
            
        }else{
            // first time operator is pressed
            leftVarStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }

    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
}

