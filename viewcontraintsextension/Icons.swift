//
//  Icons.swift
//  viewcontraintsextension
//
//  Created by Scott Lydon on 5/15/18.
//  Copyright © 2018 Scott Lydon. All rights reserved.
//

import UIKit

//usage let dots = Icon(dots).coreM
//preffered
//usage let dots: Icon = .dots.coreS

//dynamically change the size
//dots.corem()

class Icon: UIButton {
    
    //WHEN ADDING IMAGES TO THE ASSET CATALOG TICK "PRESERVE VECTOR DATA" IN ORDER FOR THEM TO SCALE ACCORDING TO ACCESSIBILITY PREFERENCES
    
    enum Size {case token, coreS, coreM, coreL}
    enum IconImg {case dots, arrow}
    
    var scaleForAccessibility: Bool = true
    
    required init(_ type: IconImg) {
        super.init(frame: .zero)
        //The image should change with the accessibility changes.
        //        super.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
        //        adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        //set image
    }
    
    func updateForAccessibility() {
        if !scaleForAccessibility {return}
        switch traitCollection.preferredContentSizeCategory {
            /*
             xSmall = 38,
             small = 39,
             medium = 40,
             large (default) = 41,
             xlarge = 43,
             xxlarge = 46,
             xxxlarge = 48,
             */
        case .unspecified:
            do {}
        case .extraSmall:
            do {}
        case .small:
            do {}
        case .medium:
            do {}
        case .large:
            do {}
        case .extraLarge:
            do {}
        case .extraExtraLarge:
            do {}
        case .extraExtraExtraLarge:
            do {}
            /*
             AX1 = 52,
             AX2 = 57,
             AX3 = 61,
             AX4 = 66,
             AX5 = 70
             */
        case .accessibilityMedium:
            do {}
        case .accessibilityLarge:
            do {}
        case .accessibilityExtraLarge:
            do {}
        case .accessibilityExtraExtraLarge:
            do {}
        case .accessibilityExtraExtraExtraLarge:
            do {}
        default:
            do {}
            
        }
    }
    
    
    
    var size: Size = .token {
        didSet {
            switch size {
            case .token:
                do {} //set token size values
            case .coreS:
                do {} //set coreS size values
            case .coreM:
                do {} //set coreM size values
            case .coreL:
                do {} //set coreL size values
            }
            setNeedsLayout()
            setNeedsUpdateConstraints()
        }
    }
    
    var token: Icon {size = .token; return self}
    var coreS: Icon {size = .coreS; return self}
    var coreM: Icon {size = .coreM; return self}
    var coreL: Icon {size = .coreL; return self}
    
    @discardableResult func tokeN() -> Icon {return token}
    @discardableResult func cores() -> Icon {return coreS}
    @discardableResult func corem() -> Icon {return coreM}
    @discardableResult func corel() -> Icon {return coreL}
    
    
    //Mandated by Xcode
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}
