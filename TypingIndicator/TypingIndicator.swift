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
    let dotCornerRadius: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = dotCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TypingIndicator: UIView{
    
    let contentStackView = UIStackView.init()
    let dot1 : Dot = Dot(frame: CGRect.zero)
    let dot2 : Dot = Dot(frame: CGRect.zero)
    let dot3 : Dot = Dot(frame: CGRect.zero)
    let indicatorHight: NSInteger = 20
    let dotSpacing: CGFloat = 10
    
    
    var animationTimer: DispatchSourceTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutContentStackView()
        insertDotsIntoStackView()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func layoutContentStackView() {
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.alignment = .fill
        contentStackView.distribution = .fillEqually
        self.addSubview(contentStackView)
        
        // adding left Constraint for the view
        let left = NSLayoutConstraint.init(item: contentStackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        self.addConstraint(left)
        
        // adding right Constraint for the view
        let right = NSLayoutConstraint.init(item: contentStackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        self.addConstraint(right)
        
        // adding top Constraint for the view
        let top = NSLayoutConstraint.init(item: contentStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        self.addConstraint(top)
        
        // adding bottom Constraint for the view
        let bottom = NSLayoutConstraint.init(item: contentStackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(bottom)
    }
    
    func insertDotsIntoStackView() {
        contentStackView.addArrangedSubview(dot1)
        contentStackView.addArrangedSubview(dot2)
        contentStackView.addArrangedSubview(dot3)
        contentStackView.spacing = dotSpacing
    }
    
     func layoutContentStackViewSubviews() {
        
        
    }
    
    func arrangeIndicatorDots() {
        
        fixDimentionsSize(forView: self, withSize: CGSize.init(width: indicatorHight*3 + Int(dotSpacing), height: indicatorHight))
    }
    
    func fixDimentionsSize(forView view: UIView, withSize size: CGSize) {
        
        // adding Height Constraint for the view
        let heightLC = NSLayoutConstraint.init(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.height)
        view.addConstraint(heightLC)
        
        // adding Width Constraint for the view
        let widthLC = NSLayoutConstraint.init(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.width)
        view.addConstraint(widthLC)
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
