//
//  CustomUINavigationController.swift
//  Youtube
//
//  Created by Vui Chee on 10/8/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class CustomUINavigationController : UINavigationController {
    
    static var hidden: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func hideStatusBar(_ toHide: Bool) {
        CustomUINavigationController.hidden = toHide
        setNeedsStatusBarAppearanceUpdate()
    }
}
