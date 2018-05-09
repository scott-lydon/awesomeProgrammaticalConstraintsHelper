//
//  ViewConstraintExtension.swift
//  viewcontraintsextension
//
//  Created by Scott Lydon on 5/5/18.
//  Copyright © 2018 Scott Lydon. All rights reserved.
//

import UIKit

protocol Constriant {}

struct ViewWithLeftMargin {
    var leftMargin: CGFloat
    var view: UIView
    var width: CGFloat
    var height: CGFloat? = nil
}

struct ViewWithRightMargin {
    var rightMargin: CGFloat
    var view: UIView
    var width: CGFloat
    var height: CGFloat? = nil
}

extension UIView {
    //MARK Group subviews.

    enum Orientation {
        case horizontal, vertical
    }
    
    enum Centering {
        case centered, latchToTopMargin
    }
    
    //MARK IN PROGRESS
    @discardableResult
    func subViewsConstraints(topMargin: CGFloat, subViews: ViewWithLeftMargin..., lastSubView: ViewWithRightMargin, leftSideOfLastMargin: CGFloat, centering: Bool = true, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [[NSLayoutConstraint]] = []
        var leftNeighbor: NSLayoutXAxisAnchor = leadingAnchor
        var horizontal1 =  HorizontalDescriptor.width(1000)
        var horizontal2 =  HorizontalDescriptor.width(1000)
        var vertical1 =  VerticalDescriptor.height(1000)
        var vertical2 =  VerticalDescriptor.height(1000)
        
        constraints = subViews.map {
            horizontal1 = .distanceToLeft(leftNeighbor, $0.leftMargin)
           horizontal2 = .width($0.width)
            vertical1 = centering ? .centeredTo(self) : .distanceToTop(topAnchor, topMargin)
            
            if let height = $0.height {
                vertical2 = .height(height)
            } else {
                vertical2 = centering ? .distanceToTop(topAnchor, topMargin) : .flexibleHeight
            }
            
            if centering {
                vertical2 = ($0.height != nil) ? .height($0.height!) : .distanceToTop(topAnchor, topMargin)
            } else {
                vertical2 = ($0.height != nil) ? .height($0.height!) : .flexibleHeight
            }
            
            if $0.view === subViews.last!.view {
                horizontal1 = .distanceToRight(lastSubView.view.leadingAnchor, leftSideOfLastMargin) //give second to last view flexible width
                horizontal2 = .distanceToLeft(leftNeighbor, $0.leftMargin)
            }

            print("\n\n horizontal1 = \(horizontal1.description), horizontal2 = \(horizontal2.description), vertical1= \(vertical1.description), vertical2 = \(vertical2.description)")
            
            leftNeighbor = $0.view.trailingAnchor
            
            return $0.view.constraints(horizontal: horizontal1, secondHorizontal: horizontal2, vertical: vertical1, secondVertical: vertical2)
            }
        
        var secondVertical: VerticalDescriptor
        
        if let height = lastSubView.height {
            secondVertical = .height(height)
        } else {
            secondVertical = centering ? .distanceToTop(topAnchor, topMargin) : .flexibleHeight
        }
        
        constraints.append(
            lastSubView.view.constraints(horizontal: .width(lastSubView.width), secondHorizontal: .distanceToRight(self.trailingAnchor ,lastSubView.rightMargin), vertical: centering ? .centeredTo(self) : .distanceToTop(topAnchor, topMargin), secondVertical: secondVertical)
        )
        return constraints.flatMap {$0}
    }
    
    
    
    
    //MARK TRY #2
    
    enum HorizontalDescriptor  {
        var description: String {
            switch self {
            case .distanceToLeft(let anchor, let distance):
                return ".distanceToLeft, anchor: \(anchor), distance: \(distance)"
            case .centeredWith(let view):
                return ".centeredWith, view: \(view)"
            case .width(let width):
                return ".width: \(width)"
            case .distanceToRight(let anchor, let distance):
                return ".distanceToRight, anchor: \(anchor), distance: \(distance)"
            case .flexibleWidth:
                return ".flexibleWidth"
            }
        }
        case width(CGFloat),
        distanceToLeft(NSLayoutAnchor<NSLayoutXAxisAnchor>, CGFloat),
        distanceToRight(NSLayoutAnchor<NSLayoutXAxisAnchor>, CGFloat),
        centeredWith(UIView),
        flexibleWidth

    }
    
    enum VerticalDescriptor {
        var description: String {
            switch self {
            case .height(let height):
                return ".height: \(height)"
            case .distanceToTop(let anchor, let distance):
                return ".distanceToTop, anchor: \(anchor), distance: \(distance)"
            case .distanceToBottom(let anchor, let distance):
                return ".distanceToBottom, anchor: \(anchor), distance: \(distance)"
            case .centeredTo(let view):
                return ".centeredTo, view: \(view)"
            case .flexibleHeight:
                return ".flexibleHeight"
            }
        }
        case height(CGFloat),
        distanceToTop(NSLayoutAnchor<NSLayoutYAxisAnchor>, CGFloat),
        distanceToBottom(NSLayoutAnchor<NSLayoutYAxisAnchor>, CGFloat),
        centeredTo(UIView),
        flexibleHeight
    }
    
    @discardableResult
    func constraints(horizontal: HorizontalDescriptor, secondHorizontal: HorizontalDescriptor, vertical: VerticalDescriptor, secondVertical: VerticalDescriptor, activated shouldActivate: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        constraints += [horizontal, secondHorizontal].compactMap {constraint(from: $0)}
        constraints += [vertical, secondVertical].compactMap {constraint(from: $0)}
        if shouldActivate {NSLayoutConstraint.activate(constraints)}
        return constraints
    }
    
    
    func constraint(from: HorizontalDescriptor) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        switch from {
        case .width(let width):
            return widthAnchor.constraint(equalToConstant: width)
        case let .distanceToLeft(anchor, distance):
            return leadingAnchor.constraint(equalTo: anchor, constant: distance)
        case let .distanceToRight(anchor, distance):
            return trailingAnchor.constraint(equalTo: anchor, constant: distance)
        case .centeredWith(let view):
            return centerXAnchor.constraint(equalTo: view.centerXAnchor)
        case .flexibleWidth:
            return nil
        }
    }
    
    func constraint(from: VerticalDescriptor) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        switch from {
        case .height(let height):
            return heightAnchor.constraint(equalToConstant: height)
        case let .distanceToTop(anchor, distance):
            return topAnchor.constraint(equalTo: anchor, constant: distance)
        case let .distanceToBottom(anchor, distance):
            return bottomAnchor.constraint(equalTo: anchor, constant: distance)
        case .centeredTo(let view):
            return centerYAnchor.constraint(equalTo: view.centerYAnchor)
        case .flexibleHeight:
            return nil
        }
    }
    
    
    
    
    //MARK TRY #1
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
