//
//  Node.swift
//  Snake
//
//  Created by keith on 2017/5/3.
//  Copyright © 2017年 keith. All rights reserved.
//

import UIKit

class Node: NSObject {
    
    var coordinate: CGPoint!
    
    class func nodeWithCoordinate(coordinate:CGPoint) ->Node {
        let node = Node()
        node.coordinate = coordinate
        return node
    }
}
