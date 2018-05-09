//
//  ViewController.swift
//  viewcontraintsextension
//
//  Created by Scott Lydon on 5/5/18.
//  Copyright © 2018 Scott Lydon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton()
        view.addSubview(btn)

        //constraints = btn.constraints(leftNeighborAnchor: view.leadingAnchor, distance: 100, width: 20) + btn.constraints(topNeighborAnchor: view.topAnchor, distance: 50, verticallyCentered: true, centeredWithThis: view)

        btn.setBackgroundImage(#imageLiteral(resourceName: "isaheadshot-crop"), for: .normal)
        let box = UIView()
        view.addSubview(box)
        box.backgroundColor = .black
        box.constraints(horizontal: .centeredWith(view), secondHorizontal: .width(view.frame.width), vertical: .height(200), secondVertical: .centeredTo(view))

        let profileImgV = UIImageView(image: #imageLiteral(resourceName: "isaheadshot-crop"))
        let textL = UILabel()
        let moonImgV = UIImageView(image: #imageLiteral(resourceName: "moon"))
        textL.textColor = .white
        textL.text = "I'm a pretty girl how are you today coolaide!?"
        textL.numberOfLines = 0
        _ = [profileImgV, textL, moonImgV].map {box.addSubview($0)}

        box.subViewsConstraints(topMargin: 10, subViews:
            ViewWithLeftMargin(leftMargin: 10, view: profileImgV, width: 100, height: 100),
            ViewWithLeftMargin(leftMargin: 10, view: textL, width: 0, height: nil)
            , lastSubView: ViewWithRightMargin(rightMargin: 25, view: moonImgV, width: 60, height: 60), leftSideOfLastMargin: 10)

    }
    

    
    
}


