//
//  ActivitySelection.swift
//  Hancock
//
//  Created by Casey Kawamura  on 7/9/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import Foundation
import UIKit

public var currentStep = [[CGPoint]]()
public var activityPoints = [(x: CGFloat, y: CGFloat)]()

public class ActivitySelection {
    
    public func loadActivityA() {
        
        print("Called loadActivityA")
        activityPoints = [(x: 0.5, y: 0.15),(x: 0.1, y: 0.85)]
        print("The activity has points at: ", activityPoints)
    }
    
    public func loadActivityB() {
        print("Called loadActivityB")
    }
}
