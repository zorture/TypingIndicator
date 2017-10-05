//
//  TypingIndicator.swift
//  TypingIndicator
//
//  Created by Kanwar Zorawar Singh Rana on 10/4/17.
//  Copyright © 2017 Kanwar Zorawar Singh Rana. All rights reserved.
//

import UIKit
import QuartzCore

enum DotStage{
    case stage1
    case stage2
    case stage3
}

class Dot: UIView {
    var stage: DotStage = .stage1
    let dotCornerRadius: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = dotCornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TypingIndicator: UIView{
    
    let dot1 : Dot = Dot(frame: CGRect.zero)
    let dot2 : Dot = Dot(frame: CGRect.zero)
    let dot3 : Dot = Dot(frame: CGRect.zero)
    
    
    var animationTimer: DispatchSourceTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(dot1)
        self.addSubview(dot2)
        self.addSubview(dot3)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        dot1.translatesAutoresizingMaskIntoConstraints = false
        dot2.translatesAutoresizingMaskIntoConstraints = false
        dot3.translatesAutoresizingMaskIntoConstraints = false
        
        arrangeIndicatorDots()
        
        self.backgroundColor = UIColor.orange
        dot1.backgroundColor = UIColor.white
        dot1.stage = .stage1
        dot2.backgroundColor = UIColor.lightGray
        dot2.stage = .stage2
        dot3.backgroundColor = UIColor.gray
        dot3.stage = .stage3

        let queue = DispatchQueue(label: "com.firm.app.timer", attributes: .concurrent)
        animationTimer = DispatchSource.makeTimerSource(queue: queue)

        startAnimatino()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func arrangeIndicatorDots() {
        
        self.fixDimentionsSize(forView: self, withSize: CGSize.init(width: 150, height: 50))
        self.fixDimentionsSize(forView: dot1, withSize: CGSize.init(width: 50, height: 50))
        self.fixDimentionsSize(forView: dot2, withSize: CGSize.init(width: 50, height: 50))
        self.fixDimentionsSize(forView: dot3, withSize: CGSize.init(width: 50, height: 50))
        
        self.fixDimentionsOrigin(forView: dot1, withSize: CGPoint.init(x: 0, y: 0))
        self.fixDimentionsOrigin(forView: dot2, withSize: CGPoint.init(x: 50, y: 0))
        self.fixDimentionsOrigin(forView: dot3, withSize: CGPoint.init(x: 100, y: 0))
    }
    
    func fixDimentionsSize(forView view: UIView, withSize size: CGSize) {
        
        // adding Height Constraint for the view
        let heightLC = NSLayoutConstraint.init(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.height)
        view.addConstraint(heightLC)
        
        // adding Width Constraint for the view
        let widthLC = NSLayoutConstraint.init(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.width)
        view.addConstraint(widthLC)
    }
    
     func fixDimentionsOrigin(forView view: UIView, withSize origin: CGPoint) {
        
        // adding left Constraint for the view
        let left = NSLayoutConstraint.init(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: origin.x)
        self.addConstraint(left)
        
        // adding top Constraint for the view
        let top = NSLayoutConstraint.init(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: origin.y)
        self.addConstraint(top)
        
    }
    
    func startAnimatino() {
        
        animationTimer?.schedule(deadline: .now(), repeating: .milliseconds(500), leeway: .milliseconds(100))

        animationTimer?.setEventHandler { [weak self] in
            print("Daste::\(Date())")
            if let strongSelf = self {
                strongSelf.colorDot(dot: strongSelf.dot1)
                strongSelf.colorDot(dot: strongSelf.dot2)
                strongSelf.colorDot(dot: strongSelf.dot3)
            }
        }
        animationTimer?.resume()
    }
    
    func stopAnimation() {
        animationTimer?.cancel()
    }
    
    func colorDot(dot: Dot) {
        
        switch dot.stage {
        case .stage1:
            DispatchQueue.main.async {
                dot.backgroundColor = UIColor.white
                dot.stage = .stage2
            }
            break
        case .stage2:
            DispatchQueue.main.async {
                dot.backgroundColor = UIColor.lightGray
                dot.stage = .stage3
            }
            break
        case .stage3:
            DispatchQueue.main.async {
                dot.backgroundColor = UIColor.gray
                dot.stage = .stage1
            }
            break
        }
    }
}
