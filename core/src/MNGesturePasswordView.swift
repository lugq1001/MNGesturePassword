//
//  MNGesturePasswordView.swift
//  ECM
//
//  Created by 陆广庆 on 2017/1/18.
//  Copyright © 2017年 陆广庆. All rights reserved.
//

import UIKit

enum MNGesturesState {
    case normal
    case error
    case success
}

class MNGesturePasswordView: UIView {

    var gesture: MNGesturePassword!
    var context: CGContext!
    var state = MNGesturesState.normal
    var points: [MNGesturePoint] = []
    var lineX = CGFloat.leastNormalMagnitude
    var lineY = CGFloat.leastNormalMagnitude
    
    var defaultPointBgImage: UIImage!
    
    
    var touchedPointBgImage: UIImage!
    var touchedPointImage: UIImage!
    
    var successPointBgImage: UIImage!
    var successPointImage: UIImage!
    
    var errorPointBgImage: UIImage!
    var errorPointImage: UIImage!
    var password: [Int] = []
    
    
    init(gesture: MNGesturePassword) {
        super.init(frame: CGRect.zero)
        self.gesture = gesture
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = UIColor.clear
        let cfg = gesture.configure!
        defaultPointBgImage = cfg.defaultPointBgImage
        touchedPointBgImage = cfg.touchedPointBgImage
        touchedPointImage = cfg.touchedPointImage
        
        successPointBgImage = cfg.successPointBgImage
        successPointImage = cfg.successPointImage
        
        errorPointBgImage = cfg.errorPointBgImage
        errorPointImage = cfg.errorPointImage

        if self.bounds.size.width > 0 {
            initPoints()
        }
    }
    
    // MARK: - TouchEvent
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            self.password = []
            let point = touch.location(in: self)
            var inRange = false
            for p in points {
                if p.isInRange(x: point.x, y: point.y) {
                    p.state = .pass
                    self.password.append(p.ID)
                    inRange = true
                    break
                }
            }
            if inRange {
                setNeedsDisplay()
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            self.lineX = point.x
            self.lineY = point.y
            for p in points {
                if p.isInRange(x: point.x, y: point.y) && p.state != .pass {
                    p.state = .pass
                    if !password.isEmpty {
                        let preID = password.last!
                        points[preID].nextID = p.ID
                        
                    }
                    self.password.append(p.ID)
                    break
                }
            }
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if password.isEmpty {
            return
        }
        resetPoints()
        setNeedsDisplay()
        if !password.isEmpty {
            var passwordStr = ""
            for p in password {
                passwordStr += "\(p)"
            }
            print("㊙️㊙️㊙️MNGesturePassword:\(passwordStr)㊙️㊙️㊙️")
            gesture.delegate.gesturePasswordOnGestured(gesturePassword: gesture, password: passwordStr)
        }
    }
    
    // MARK: - Override
    
    override func draw(_ rect: CGRect) {
        if points.isEmpty && self.bounds.size.width > 0 {
            initPoints()
        }
        context = UIGraphicsGetCurrentContext()
        context.setShouldAntialias(true)
        context.setLineWidth(10)
        var color: CGColor!
        switch state {
        case .success:
            color = self.gesture.configure.successColor.cgColor
        case .error:
            color = self.gesture.configure.errorColor.cgColor
        case .normal:
            color = self.gesture.configure.touchColor.cgColor
        }
        context.setStrokeColor(color)
        drawSelf()
    }
    
    // MARK: - Method
    fileprivate func drawSelf() {
        // 先画背景
        for p in points {
            let point = CGPoint(x: p.x, y: p.y)
            switch p.state {
            case .normal:
                defaultPointBgImage.draw(at: point)
            case .pass:
                touchedPointBgImage.draw(at: point)
            case .error:
                errorPointBgImage.draw(at: point)
            case .success:
                successPointBgImage.draw(at: point)
            }
        }
        if !password.isEmpty {
            var start = points[password.first!]
            while start.hasNextID() {
                let next = points[start.nextID]
                self.drawLine(startX: start.centerX, startY: start.centerY, endX: next.centerX, endY: next.centerY)
                start = next
            }
            if lineX != CGFloat.leastNormalMagnitude && lineY != CGFloat.leastNormalMagnitude {
                self.drawLine(startX: start.centerX, startY: start.centerY, endX: lineX, endY: lineY)
            }
        }
        // 画点
        for p in points {
            let point = CGPoint(x: p.x, y: p.y)
            switch p.state {
            case .normal:
                break
            case .pass:
                touchedPointImage.draw(at: point)
            case .error:
                errorPointImage.draw(at: point)
            case .success:
                successPointImage.draw(at: point)
            }
        }
    }
    
    /// 画线
    fileprivate func drawLine(startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat) {
        context.move(to: CGPoint(x: startX, y: startY))
        context.addLine(to: CGPoint(x: endX, y: endY))
        context.strokePath()
        
    }
    
    
    /// 重置点样式
    fileprivate func resetPoints() {
        for p in points {
            p.state = .normal
            p.nextID = p.ID
        }
        lineX = CGFloat.leastNormalMagnitude
        lineY = CGFloat.leastNormalMagnitude
        state = .normal
    }
    
    
    /// 初始化点
    fileprivate func initPoints() {
        let diameters = defaultPointBgImage.size.width
        
        let spacing = (self.bounds.size.width - diameters * 3) / 4
        var startX = spacing
        var startY = spacing
        for i in 0..<9 {
            if i == 3 || i == 6 {
                startX = spacing
                startY = startY + diameters + spacing
            }
            let point = MNGesturePoint(i, startX, startY, diameters)
            points.append(point)
            startX += diameters + spacing
        }
    }
    
    func changeState(state: MNGesturesState) {
        if state == .normal {
            self.isUserInteractionEnabled = true
            resetPoints()
            setNeedsDisplay()
            return
        }
        self.isUserInteractionEnabled = false
        self.state = state
        let length = self.password.count
        for i in 0..<length {
            let ID = password[i]
            switch state {
            case .normal:
                break
            case .error:
                points[ID].state = .error
            case .success:
                points[ID].state = .success
            }
            if i + 1 < length {
                points[ID].nextID = password[i + 1]
            }
        }
        setNeedsDisplay()
    }
}
