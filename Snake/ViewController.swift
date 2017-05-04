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
        
        food = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        food.image = UIImage(named: "star")
        gameView.addSubview(food)
        
        snake = Snake().snake()
        snake.moveFinishBlock = {
            self.isEatedFood()
            self.isDestory()
            self.gameView.setNeedsDisplay()
        }
        gameView.snake = snake
        createFood()
    }
    
    func createFood() {
        let x = (arc4random() % 20) * 10 + 5
        let y = (arc4random() % 30) * 10 + 5 
        let center : CGPoint = CGPoint(x: Int(x), y: Int(y))
        for n in snake.nodes {
            let node = n as! Node
            if __CGPointEqualToPoint(center, node.coordinate) {
                createFood()
                return
            }
        }
        food.center = center
    }
    
    func isEatedFood() {
        let node : Node! = snake.nodes.firstObject as! Node
        if __CGPointEqualToPoint(food.center, node.coordinate) {
            let score = Int(scoreLabel.text!)! + 1
            scoreLabel.text = String(score)
            if score < 90 && (score % 10 == 0){
                let level = score / 10
                levelLabel.text = String(level)
            }
            createFood()
            snake.growUp()
        }
    }
    
    func isDestory() {
        let head : Node! = snake.nodes.firstObject as! Node
        for i in 1..<snake.nodes.count {
            let node : Node! = snake.nodes[i] as! Node
            if __CGPointEqualToPoint(head.coordinate, node.coordinate) {
                gameOver()
            }
        }
        
        if head.coordinate.x < gameView.frame.origin.x - 5 || head.coordinate.x > gameView.frame.size.width - 5 {
            gameOver()
        }
        if head.coordinate.y < gameView.frame.origin.y - 5 || head.coordinate.y > gameView.frame.size.height - 5 {
            gameOver()
        }
    }

    func gameOver() {
        snake.pause()
        let alert = UIAlertController(title: "Game Over", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
            self.startButton.isSelected = false
            self.isGameOver = true
        })
        
        let again = UIAlertAction(title: "Again", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            self.scoreLabel.text = "0"
            self.levelLabel.text = "0"
            self.createFood()
            self.snake.reset()
        })
        
        alert.addAction(cancel)
        alert.addAction(again)
        present(alert, animated: true) {
            
        }
    }
    
    
    @IBAction func directionClick(_ sender: UIButton!) {
        if startButton.isSelected {
            if sender.tag == 0 {
                snake.direction = SnakeDirection.up;
            }
            if sender.tag == 1 {
                snake.direction = SnakeDirection.left;
            }
            if sender.tag == 2 {
                snake.direction = SnakeDirection.down;
            }
            if sender.tag == 3 {
                snake.direction = SnakeDirection.right;
            }
        }
    }

    @IBAction func pause(_ sender: UIButton!) {
        if sender.isSelected {
            snake.pause()
        } else {
            if isGameOver {
                scoreLabel.text = "0"
                levelLabel.text = "0"
                snake.reset()
                isGameOver = false
            } else {
                snake.start()
            }
        }
        sender.isSelected = !sender.isSelected
    }
    
    
}

