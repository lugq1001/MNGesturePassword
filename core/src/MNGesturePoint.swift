//
//  MNGesturePoint.swift
//  ECM
//
//  Created by 陆广庆 on 2017/1/18.
//  Copyright © 2017年 陆广庆. All rights reserved.
//

import UIKit

enum GesturePointTouchState {
    case normal
    case pass
    case error
    case success
}

class MNGesturePoint: NSObject {

    var ID: Int = 0
    
    var nextID: Int = 0
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    
    /// 点半径
    var diameters: CGFloat = 0
    
    
    var state = GesturePointTouchState.normal
    
    init(_ ID: Int, _ x: CGFloat, _ y: CGFloat, _ diameters: CGFloat) {
        self.ID = ID
        self.nextID = ID
        self.x = x
        self.y = y
        self.diameters = diameters
    }
    
    var centerX: CGFloat {
        return x + diameters / 2
    }
    
    var centerY: CGFloat {
        return y + diameters / 2
    }
    
    func hasNextID() -> Bool {
        return nextID != ID
    }
    
    func isInRange(x: CGFloat, y: CGFloat) -> Bool {
        let selfX = self.x
        let selfY = self.y
        let inX = x > selfX && x < selfX + diameters
        let inY = y > selfY && y < selfY + diameters
        return inX && inY;
    }
}
