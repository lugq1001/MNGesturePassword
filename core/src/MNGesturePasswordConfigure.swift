//
//  MNGesturePasswordConfigure.swift
//  ECM
//
//  Created by 陆广庆 on 2017/1/16.
//  Copyright © 2017年 陆广庆. All rights reserved.
//

import UIKit

class MNGesturePasswordConfigure: NSObject {

    class func defaultConfigure() -> MNGesturePasswordConfigure {
        let configure = MNGesturePasswordConfigure()
        configure.defaultPointBgImage = UIImage(named: "gp_gray.png")
        
        configure.touchedPointImage = UIImage(named: "gp_bluedot.png")
        configure.touchedPointBgImage = UIImage(named: "gp_blue.png")
        
        configure.errorPointImage = UIImage(named: "gp_reddot.png")
        configure.errorPointBgImage = UIImage(named: "gp_red.png")
        
        configure.successPointImage = UIImage(named: "gp_greendot.png")
        configure.successPointBgImage = UIImage(named: "gp_green.png")
        
        configure.errorColor = UIColor(red: 209 / 255, green: 37 / 255, blue: 38 / 255, alpha: 0.7)
        configure.touchColor = UIColor(red: 21 / 255, green: 168 / 255, blue: 247 / 255, alpha: 0.7)
        configure.successColor = UIColor(red: 34 / 255, green: 207 / 255, blue: 87 / 255, alpha: 0.7)
        
        return configure
    }
    
    var defaultPointBgImage: UIImage!
    
    
    var touchedPointBgImage: UIImage!
    var touchedPointImage: UIImage!
    
    var successPointBgImage: UIImage!
    var successPointImage: UIImage!
    
    var errorPointBgImage: UIImage!
    var errorPointImage: UIImage!
    
    
    var errorColor: UIColor!
    var successColor: UIColor!
    var touchColor: UIColor!
}
