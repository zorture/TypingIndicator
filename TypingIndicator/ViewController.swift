//
//  ViewController.swift
//  TypingIndicator
//
//  Created by Kanwar Zorawar Singh Rana on 10/4/17.
//  Copyright © 2017 Kanwar Zorawar Singh Rana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let typingInd = TypingIndicator.init(frame: CGRect.zero)
        view.addSubview(typingInd)
        
        // adding Height Constraint for the view
        let leading = NSLayoutConstraint.init(item: typingInd, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 50)
        view.addConstraint(leading)
        
        // adding Width Constraint for the view
        let top = NSLayoutConstraint.init(item: typingInd, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150)
        view.addConstraint(top)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

