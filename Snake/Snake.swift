//
//  Snake.swift
//  Snake
//
//  Created by keith on 2017/5/3.
//  Copyright © 2017年 keith. All rights reserved.
//

import UIKit
import Foundation

enum SnakeDirection {
    case up
    case left
    case down
    case right
}

class Snake: NSObject {
    var nodes : NSMutableArray!
    var direction : SnakeDirection!
    var timer : Timer!
    var speed : NSInteger!
    var lastPoint : CGPoint!
    
    func snake() -> Snake {
        let snake = Snake()
        snake.initBody()
        return snake;
    }
    
    func initBody() {
        nodes.removeAllObjects()
        for i in 1...4 {
            let point:CGPoint! = CGPoint(x: 10*i+5, y: 5)
            nodes.add(Node.nodeWithCoordinate(coordinate: point))
        }
        direction = SnakeDirection.right
    }
    
    func levelUpWithSpeed(s:NSInteger) {
        speed = s
        pause()
        start()
    }
    
    func growUp() {
        let node : Node = Node.nodeWithCoordinate(coordinate: lastPoint)
        nodes.add(node)
    }
    
    func start() {
        let s = Double(speed)
        let time : TimeInterval! = 0.2 - 0.02 * s
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(move), userInfo: nil, repeats: true)
    }
    
    func pause() {
        timer.invalidate()
        timer = nil
    }
    
    func reset() {
        initBody()
        speed = 0
        start()
    }
    
    func move() {
        let node : Node! = nodes.lastObject as! Node
        lastPoint = node.coordinate
        let c : Node! = nodes.firstObject as! Node
        var center : CGPoint! = c.coordinate
        if direction == SnakeDirection.up || direction == SnakeDirection.left {
            center.y -= 10;
        }
        if direction == SnakeDirection.down || direction == SnakeDirection.right {
            center.y += 10;
        }
        node.coordinate = center
        nodes.remove(node)
        nodes.insert(node, at: 0)
    }
}
