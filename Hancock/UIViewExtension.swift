//
//  UIViewExtension.swift
//  Hancock
//
//  Created by Chris Ross on 7/1/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func pulsate(duration: Double) {
     
        //transform the scale with a CASpringAnimation
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        //duration of the animation
        //pulse.duration = 0.6
        pulse.duration = duration
        
        //starts at 95% of its size
        pulse.fromValue  = 1
        
        //ends at %100 of it's size
        pulse.toValue = 1.25
        
        //reverse the animation when finished
        pulse.autoreverses = true
        
        //how many times the animation plays
        pulse.repeatCount = 2
        
        //tweek the bounciness of the animation
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        //add the animation onto the UIView's layer
        //forKey can be nil, because only adding one animation. If more then one, each would have to be identified with a string keypath
        layer.add(pulse, forKey: nil)
    }
}
