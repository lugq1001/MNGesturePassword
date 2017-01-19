//
//  MNGesturePassword.swift
//  ECM
//
//  Created by 陆广庆 on 2017/1/16.
//  Copyright © 2017年 陆广庆. All rights reserved.
//

import UIKit

class MNGesturePassword: NSObject {

    var delegate: MNGesturePasswordDelegate!
    var configure: MNGesturePasswordConfigure!
    fileprivate var _gestureView: MNGesturePasswordView!
    
    init(delegate: MNGesturePasswordDelegate, configure: MNGesturePasswordConfigure = MNGesturePasswordConfigure.defaultConfigure()) {
        super.init()
        self.delegate = delegate
        self.configure = configure
        _gestureView = MNGesturePasswordView(gesture: self)
    }
   
    var gestureView: UIView {
        return _gestureView
    }
    
    func showErrorView() {
        _gestureView.changeState(state: .error)
    }
    
    func showSuccessView() {
        _gestureView.changeState(state: .success)
    }
    
    func resetView() {
        _gestureView.changeState(state: .normal)
    }
    
    func dismiss() {
        
    }
}
