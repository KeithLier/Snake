//
//  ViewController.swift
//  Snake
//
//  Created by keith on 2017/5/3.
//  Copyright © 2017年 keith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameView : GameView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var levelLabel : UILabel!
    
    var snake : Snake!
    var food : UIImageView!
    var isGameOver : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func directionClick(_ sender: Any) {
        
    }

}

