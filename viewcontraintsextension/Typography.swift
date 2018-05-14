//
//  Typography.swift
//  viewcontraintsextension
//
//  Created by Scott Lydon on 5/14/18.
//  Copyright © 2018 Scott Lydon. All rights reserved.
//

import UIKit

extension String {
    typealias Str = NSMutableAttributedString
    
    var headingXXL: Str {return new(height: 1.2, "PayPal Sans Big Light", size: 30)}
    var headingXL: Str {return new(height: 12,  "PayPal Sans Big Light", size: 33)}
    var headingXLBold: Str {return new(height: 12,  "PayPal Sans Big Regular", size: 33)}
    var headlingL: Str {return new(height: 12, "PayPal Sans Big Light", size: 33)}
    var headlingLBold: Str {return new(height: 12, "PayPal Sans Big Regular", size: 33)}
    var headingMBold: Str {return new(height: 12,  "PayPal Sans Big Regular", size: 33)}
    var headingS: Str {return new(height: 12, "PayPal Sans Big Light", size: 33)}
    var headingSBold: Str {return new(height: 12,  "PayPal Sans Big Regular", size: 33)}
    var bodyL: Str {return new(height: 12,  "PayPal Sans Small Regular", size: 33)}
    var bodyBase: Str {return new(height: 12,  "PayPal Sans Small Regular", size: 33)}
    var bodyBaseBold: Str {return new(height: 12,  "PayPal Sans Small Medium", size: 33)}
    var bodySupporting: Str {return new(height: 12,  "PayPal Sans Small Regular", size: 34)}
    var bodySupportingBold: Str {return new(height: 12, "PayPal Sans Small Medium", size: 33)}
    
    func new(height: CGFloat, _ font: String, size: CGFloat, bold: Bool = false) -> NSMutableAttributedString {
        let str = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = height
        let font = UIFont(name: font, size: size)!
        str.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, self.count))
        str.addAttribute(.font, value: font, range: NSMakeRange(0, self.count))
        return str
    }
}
