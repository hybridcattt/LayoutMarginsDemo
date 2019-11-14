//
//  ViewWithMargins.swift
//  LayoutMarginsDemo
//
//  Created by Marina Gornostaeva on 26/05/2019.
//  Copyright © 2019 Marina Gornostaeva. All rights reserved.
//

import UIKit

final class ViewWithMargins: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.label)
        
        let layoutGuide = self.layoutMarginsGuide
        let constraints: [NSLayoutConstraint] = [
            self.label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            self.label.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            self.label.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        self.updateText()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.setNeedsDisplay()
        self.updateText()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let innerRect = self.bounds.inset(by: self.layoutMargins)
        context.setFillColor(UIColor.white.withAlphaComponent(0.7).cgColor)
        context.fill(innerRect)
    }
    
    private func updateText() {
        let lm = self.layoutMargins
        self.label.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        top: \(lm.top)
        bottom: \(lm.bottom)
        left: \(lm.left)
        right: \(lm.right)
        """
    }
}
