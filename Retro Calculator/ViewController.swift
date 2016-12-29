//
//  ViewController.swift
//  Retro Calculator
//
//  Created by walid amachraa on 12/3/15.
//  Copyright © 2015 wallPrograms. All rights reserved.
//

import UIKit
import AVFoundation
//Import audio, add a variable for it

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var Label: UILabel!;
    
    enum Operation: String {
        case Divide = "/";
        case Multiply = "*";
        case Subtract = "-";
        case Add = "+";
        case Empty = "";
    }
    
    //Variables
    var buttonSound: AVAudioPlayer!;
    
    var runningNumber = "";
    var leftValString = "";
    var rightValString = "";
    var currentOperation: Operation = Operation.Empty;
    var result = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a path for the wav sound
        let path = Bundle.main.path(forResource: "btn", ofType: "wav");
        //Create a URL for the path
        let soundURL = URL(fileURLWithPath: path!);
        
        do {
        try buttonSound = AVAudioPlayer(contentsOf: soundURL); //try this code
            buttonSound.prepareToPlay();  //If it succeeds
        } catch let err as NSError {  //If it fails, catch the error
            print(err.debugDescription);
        }
}
    
    
    //Actions
    @IBAction func numberPressed(_ button: UIButton!) {
        playSound();
        runningNumber += "\(button.tag)";  //Add the running number String to the converted tag integer (To a String)
        Label.text = runningNumber;  //Diplay the updated runningNumber as a String
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(Operation.Divide);
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(Operation.Multiply);
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(Operation.Subtract);
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(Operation.Add);
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        processOperation(currentOperation);
    }
    
    //Clear Button action
    @IBAction func onClearPressed(_ sender: AnyObject) {
        runningNumber = "";
        leftValString = "";
        rightValString = ""
        currentOperation = Operation.Empty;
        result = "";
        Label.text = "0";
    }
    
    
    //Functions not to repeat code
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop();
        }
        buttonSound.play();
    }
    
    func processOperation(_ op: Operation) {
        playSound();
        
        if currentOperation != Operation.Empty {
            
            //If the runningNumber is not empty, you can do the calculations, if not, the user has not selected an operator, meaning that nothing should happen or it is the first time the operator is pressed
            if runningNumber != "" {
            //Shows the result and prepare for the next operation
            rightValString = runningNumber; //The rightValString becomes the runningNumber on the screen so that it
            runningNumber = ""; //Initialize the runningNumber
            
            //performs the operation leftValString (operator) rightValString
            if currentOperation == Operation.Divide {
                result = "\(Double(leftValString)! / Double(rightValString)!)";
            } else if currentOperation == Operation.Multiply {
                result = "\(Double(leftValString)! * Double(rightValString)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValString)! - Double(rightValString)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValString)! + Double(rightValString)!)"
            }
            
            leftValString = result;
            Label.text = result;
            }
            //Store the operation, it only shows the result after an operator is pressed or after = is pressed
            currentOperation = op;
        } else {
            //The first time the operator is pressed
            leftValString = runningNumber;
            runningNumber = "";
            currentOperation = op; //The currentOperation is op of type Operation which is the enum
        }
    }
}
