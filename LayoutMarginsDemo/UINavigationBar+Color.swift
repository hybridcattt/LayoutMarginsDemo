//
//  UINavigationBar+Color.swift
//  LayoutMarginsDemo
//
//  Created by Marina Gornostaeva on 14/11/2019.
//  Copyright © 2019 Marina Gornostaeva. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func configureWithColor(_ color: UIColor) {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(image, for: UIBarMetrics.default)
    }
}
