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
        let imageV = UIImageView()
        view.addSubview(imageV)
        
        constraints = imageV.constraints(leftNeighborAnchor: view.leadingAnchor, distance: 100, width: 20) + imageV.constraints(topNeighborAnchor: view.topAnchor, distance: 50, verticallyCentered: true, centeredWithThis: view)
        
        imageV.image = #imageLiteral(resourceName: "isaheadshot-crop")
       
        
        
        
    }
    

    
    
}


