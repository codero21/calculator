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

    @IBOutlet weak var outputLbl: UILabel!
    
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
        btnSound.play()
    }

}

