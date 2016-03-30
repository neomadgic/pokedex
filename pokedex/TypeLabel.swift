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
        let attributedString = NSMutableAttributedString(string: self.text!)
        identifyType("Normal", attributedString: attributedString, hexCode: 0xA8A77A)
        identifyType("Fire", attributedString: attributedString, hexCode: 0xEE8130)
        identifyType("Water", attributedString: attributedString, hexCode: 0x6390F0)
        identifyType("Electric", attributedString: attributedString, hexCode: 0xF7D02C)
        identifyType("Grass", attributedString: attributedString, hexCode: 0x7AC74C)
        identifyType("Ice", attributedString: attributedString, hexCode: 0x96D9D6)
        identifyType("Fighting", attributedString: attributedString, hexCode: 0xC22E28)
        identifyType("Poison", attributedString: attributedString, hexCode: 0xA33EA1)
        identifyType("Ground", attributedString: attributedString, hexCode: 0xE2BF65)
        identifyType("Flying", attributedString: attributedString, hexCode: 0xA98FF3)
        identifyType("Psychic", attributedString: attributedString, hexCode: 0xF95587)
        identifyType("Bug", attributedString: attributedString, hexCode: 0xA6B91A)
        identifyType("Rock", attributedString: attributedString, hexCode: 0xB6A136)
        identifyType("Ghost", attributedString: attributedString, hexCode: 0x735797)
        identifyType("Dragon", attributedString: attributedString, hexCode: 0x6F35FC)
        identifyType("Dark", attributedString: attributedString, hexCode: 0x705746)
        identifyType("Steel", attributedString: attributedString, hexCode: 0xB7B7CE)
        identifyType("Fairy", attributedString: attributedString, hexCode: 0xD685AD)
        
    }
    
    func identifyType(type: String, attributedString: NSMutableAttributedString, hexCode: Int)
    {
        if (self.text?.rangeOfString(type) != nil)
            {
                let range = (self.text! as NSString).rangeOfString(type)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(netHex: hexCode), range: range)
                self.attributedText = attributedString;
            }
    }
}

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue:CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int)
    {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: (netHex & 0xff))
    }
}
