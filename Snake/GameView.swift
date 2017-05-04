//
//  GameView.swift
//  Snake
//
//  Created by keith on 2017/5/3.
//  Copyright © 2017年 keith. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    var snake : Snake!

    override func awakeFromNib() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(white: 0, alpha: 0.1).cgColor
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if snake.nodes.count == 0 {
            return
        }
        let node : Node! = snake.nodes.firstObject as! Node
        var center : CGPoint! = node.coordinate
        var bezier : UIBezierPath! = UIBezierPath()
        drawHead(bezier: bezier, center: center)
        UIColor.purple.set()
        bezier.lineWidth = 1.0
        bezier.fill()
        for i in 1..<snake.nodes.count {
            let node : Node! = snake.nodes[i] as! Node
            center = node.coordinate
            let rectangle : CGRect! = CGRect(x: center.x - 5, y: center.y - 5, width: 10, height: 10)
            bezier = UIBezierPath(ovalIn: rectangle)
            bezier.fill()
        }
    }
    
    func drawHead(bezier:UIBezierPath!, center:CGPoint!) {
        let w = 5.0 as CGFloat
        let x = center.x
        let y = center.y
        if snake.direction == SnakeDirection.right {
            bezier.move(to: CGPoint(x: x - w, y: y - w))
            bezier.addLine(to: CGPoint(x: x - w, y: y + w))
            bezier.addLine(to: CGPoint(x: x + w, y: y))
        }
        if snake.direction == SnakeDirection.left {
            bezier.move(to: CGPoint(x: x - w, y: y))
            bezier.addLine(to: CGPoint(x: x + w, y: y + w))
            bezier.addLine(to: CGPoint(x: x + w, y: y - w))
        }
        if snake.direction == SnakeDirection.down {
            bezier.move(to: CGPoint(x: x - w, y: y - w))
            bezier.addLine(to: CGPoint(x: x + w, y: y - w))
            bezier.addLine(to: CGPoint(x: x , y: y + w))
        }
        if snake.direction == SnakeDirection.up {
            bezier.move(to: CGPoint(x: x , y: y - w))
            bezier.addLine(to: CGPoint(x: x - w, y: y + w))
            bezier.addLine(to: CGPoint(x: x + w, y: y + w))
        }
    }
}
