//
//  TypeLabel.swift
//  pokedex
//
//  Created by Vu Dang on 3/28/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import Foundation
import UIKit

class TypeLabel: UILabel
{
    
    func changeColor()
    {
        identifyType("Fire", redFloat: 1.0, greenFloat: 0.0, blueFloat: 0.0)
        identifyType("Grass", redFloat: 0.0, greenFloat: 1.0, blueFloat: 0.0)
        identifyType("Water", redFloat: 0.0, greenFloat: 0.0, blueFloat: 1.0)
        identifyType("Electric", redFloat: 1.0, greenFloat: 1.0, blueFloat: 0.0)
        
        
        
    }
    
    func identifyType(type: String, redFloat: CGFloat, greenFloat: CGFloat, blueFloat: CGFloat)
    {
        if (self.text?.rangeOfString(type) != nil)
            {
                let range = (self.text! as NSString).rangeOfString(type)
                let attributedString = NSMutableAttributedString(string: self.text!)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: 1.0), range: range)
                self.attributedText = attributedString;
            }
    }
}
