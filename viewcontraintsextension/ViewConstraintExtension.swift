//
//  ViewConstraintExtension.swift
//  viewcontraintsextension
//
//  Created by Scott Lydon on 5/5/18.
//  Copyright © 2018 Scott Lydon. All rights reserved.
//

import UIKit

extension UIView {
    
    enum Flexibility {
        case flexible, notFlexible
    }
    
//    struct Constraint {
//        var toView: UIView
//        var axisAnchor: NSLayoutXAxisAnchor
//        var distance: CGFloat
//    }
//
//    @discardableResult
//    func constraints(
//        //Use the constraint struct here
//
//
//        leftNeighbor: UIView? = nil, leftNeighborAnchor: NSLayoutXAxisAnchor? = nil, distance: CGFloat? = nil, width: CGFloat? = nil, widthIs: Flexibility = .notFlexible, horizontallyCentered: Bool? = nil, centeredWithThis: UIView? = nil, distanceToRight: CGFloat? = nil, rightNeighbor: UIView? = nil, rightNeighborAnchor: NSLayoutXAxisAnchor? = nil, topNeighbor: UIView? = nil, topNeighborAnchor: NSLayoutYAxisAnchor? = nil, distance: CGFloat? = nil, height: CGFloat? = nil, heightIs: Flexibility = .notFlexible, verticallyCentered: Bool? = nil, centeredWithThis: UIView? = nil, distanceToBottom: CGFloat? = nil, bottomNeighbor: UIView? = nil, bottomNeighborAnchor: NSLayoutYAxisAnchor? = nil) -> [NSLayoutConstraint] {
//
//        return constraints(topNeighbor: <#T##UIView?#>, topNeighborAnchor: <#T##NSLayoutYAxisAnchor?#>, distance: <#T##CGFloat?#>, height: <#T##CGFloat?#>, heightIs: <#T##UIView.Flexibility#>, verticallyCentered: <#T##Bool?#>, centeredWithThis: <#T##UIView?#>, distanceToBottom: <#T##CGFloat?#>, bottomNeighbor: <#T##UIView?#>, bottomNeighborAnchor: <#T##NSLayoutYAxisAnchor?#>) + constraints(leftNeighbor: <#T##UIView?#>, leftNeighborAnchor: <#T##NSLayoutXAxisAnchor?#>, distance: <#T##CGFloat?#>, width: <#T##CGFloat?#>, widthIs: <#T##UIView.Flexibility#>, horizontallyCentered: <#T##Bool?#>, centeredWithThis: <#T##UIView?#>, distanceToRight: <#T##CGFloat?#>, rightNeighbor: <#T##UIView?#>, rightNeighborAnchor: <#T##NSLayoutXAxisAnchor?#>)
//    }
    
    @discardableResult
    func constraints(leftNeighbor: UIView? = nil, leftNeighborAnchor: NSLayoutXAxisAnchor? = nil, distance: CGFloat? = nil, width: CGFloat? = nil, widthIs: Flexibility = .notFlexible, horizontallyCentered: Bool? = nil, centeredWithThis: UIView? = nil, distanceToRight: CGFloat? = nil, rightNeighbor: UIView? = nil, rightNeighborAnchor: NSLayoutXAxisAnchor? = nil, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        checkForConflicts(leftNeighbor: leftNeighbor, leftNeighborAnchor: leftNeighborAnchor, distance: distance, width: width, horizontallyCentered: horizontallyCentered, centeredWithThis: centeredWithThis, distanceToRight: distanceToRight, rightNeighbor: rightNeighbor)
        
        var constraints: [NSLayoutConstraint] = []
        
        
        if let leftNeighbor = leftNeighbor, let distance = distance {
            constraints.append(leadingAnchor.constraint(equalTo: leftNeighbor.trailingAnchor, constant: distance))
        }
        
        if let leftNeighborAnchor = leftNeighborAnchor, let distance = distance {
            constraints.append(leadingAnchor.constraint(equalTo: leftNeighborAnchor, constant: distance))
        }
        
        if let width = width, widthIs == .notFlexible {
            constraints.append(widthAnchor.constraint(equalToConstant: width))
        }
        
        if horizontallyCentered == true, let centerView = centeredWithThis {
            constraints.append(centerXAnchor.constraint(equalTo: centerView.centerXAnchor))
        }
        
        if let rightNeighbor = rightNeighbor, let distance = distanceToRight {
            constraints.append(trailingAnchor.constraint(equalTo: rightNeighbor.leadingAnchor, constant: distance))
        }
        
        if let rightNeighborAnchor = rightNeighborAnchor, let distance = distanceToRight {
            constraints.append(trailingAnchor.constraint(equalTo: rightNeighborAnchor, constant: distance))
        }
        
        assert(constraints.count < 3, "If you have 3+ constraints here you have a conflict")
        if active {NSLayoutConstraint.activate(constraints)}
        return constraints
    }
    
    
    
    @discardableResult
    func constraints(topNeighbor: UIView? = nil, topNeighborAnchor: NSLayoutYAxisAnchor? = nil, distance: CGFloat? = nil, height: CGFloat? = nil, heightIs: Flexibility = .notFlexible, verticallyCentered: Bool? = nil, centeredWithThis: UIView? = nil, distanceToBottom: CGFloat? = nil, bottomNeighbor: UIView? = nil, bottomNeighborAnchor: NSLayoutYAxisAnchor? = nil, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        checkForConflicts(leftNeighbor: topNeighbor, leftNeighborAnchor: topNeighborAnchor, distance: distance, width: height, horizontallyCentered: verticallyCentered, centeredWithThis: centeredWithThis, distanceToRight: distanceToBottom, rightNeighbor: bottomNeighbor)
        
        var constraints: [NSLayoutConstraint] = []
        
        if let topNeighborAnchor = topNeighborAnchor, let distance = distance {
            constraints.append(topAnchor.constraint(equalTo: topNeighborAnchor, constant: distance))
        }
        
        if let topNeighbor = topNeighbor, let distance = distance {
            constraints.append(topAnchor.constraint(equalTo: topNeighbor.bottomAnchor, constant: distance))
        }
        
        
        if let height = height {
            constraints.append(widthAnchor.constraint(equalToConstant: height))
        }
        
        if verticallyCentered == true, let centerView = centeredWithThis {
            constraints.append(centerYAnchor.constraint(equalTo: centerView.centerYAnchor))
        }
        
        if let bottomNeighbor = bottomNeighbor, let distance = distanceToBottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottomNeighbor.topAnchor, constant: distance))
        }
        
        if let bottomNeighborAnchor = bottomNeighborAnchor, let distance = distance {
            constraints.append(bottomAnchor.constraint(equalTo: bottomNeighborAnchor, constant: distance))
        }
        
        assert(constraints.count < 3, "If you have 3 constraints here you have a conflict")
        if active {NSLayoutConstraint.activate(constraints)}
        return constraints
    }
    
    
    private func has(_ thing: Any?) -> Bool {
        return thing != nil
    }
    
    private func checkForConflicts(leftNeighbor: UIView?, leftNeighborAnchor: NSObject? , distance: CGFloat? , width: CGFloat?, horizontallyCentered: Bool?, centeredWithThis: UIView? , distanceToRight: CGFloat? = nil, rightNeighbor: UIView? = nil, rightNeighborAnchor: NSObject? = nil) {
        
        
        if (has(leftNeighbor) && has(leftNeighborAnchor)) ||
            (has(distance) && (leftNeighbor == nil && leftNeighborAnchor == nil)) {
            fatalError("""
                CONSTRAINT ERROR: line \(#line), This shouldn't be reached. IF you give a left anchor, a distance to it must be given
                """)
        }
        
//        if (width != nil && widthIs == .flexible) || (width == nil && widthIs == .notFlexible) {
//            fatalError("""
//                CONSTRAINT ERROR: line \(#line), This shouldn't be reached.
//                """)
//        }
        
        if (horizontallyCentered == nil && centeredWithThis != nil) || (horizontallyCentered != nil && centeredWithThis == nil) {
            fatalError("""
                CONSTRAINT ERROR: line \(#line), This shouldn't be reached.
                """)
        }
        
        if (has(rightNeighborAnchor) && has(rightNeighbor)) ||
            (has(distanceToRight) && (rightNeighbor == nil && rightNeighborAnchor == nil)) {
            fatalError("""
                CONSTRAINT ERROR: line \(#line), This shouldn't be reached.
                """)
        }
    }
}