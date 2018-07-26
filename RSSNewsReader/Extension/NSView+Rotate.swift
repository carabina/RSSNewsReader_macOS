//
//  UIView+Extension.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 21..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

extension NSView {
    
    func startRotate(timeToRotate: Double) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = Double.pi * 2
        rotateAnimation.duration = timeToRotate
        rotateAnimation.repeatCount = .infinity
        
        guard let layer = self.layer else {
            return
        }
        
        // TODO: 개삽질 했는데 anchor point가 계속 0.0, 0.0 으로 설정되어있음. 뭐가 문제지...
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.add(rotateAnimation, forKey: "rotation")
    }
    
    func stopRotate() {
        self.layer?.removeAllAnimations()
    }
}

