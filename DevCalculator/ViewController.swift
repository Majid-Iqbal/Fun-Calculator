//
//  ViewController.swift
//  DevCalculator
//
//  Created by Majid on 24/08/2016.
//  Copyright © 2016 Majid. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation:String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl :UILabel!
    
    var btnSound:AVAudioPlayer!
    
    var runningNumber = ""
    var rightValueStr = ""
    var leftValueStr = ""
    var currentOperation:Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main .path(forResource:"btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do{
            try btnSound =  AVAudioPlayer(contentsOf: soundUrl)
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    @IBAction func btnPressed(btn:UIButton){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
 
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(op: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(_ sender: Any) {
     processOperation(op: Operation.Multiply)   //Here we called it with complete Enum Operation.Multiply
    }
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(op: .Subtract) //Another way of sending an enum i,e .subtract
    }
    @IBAction func onAdditionPressed(_ sender: Any) {
        processOperation(op: .Add )
    }

    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(op: currentOperation)
    }

    func processOperation(op:Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            //Math Logic
            
            if runningNumber != "" {
                
                rightValueStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
                }
                
                leftValueStr = result
                outputLbl.text = result
            }
         
            currentOperation = op
        }
        else{
            leftValueStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
}
