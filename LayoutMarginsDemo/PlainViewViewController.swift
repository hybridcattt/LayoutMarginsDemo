//
//  PlainViewViewController.swift
//  LayoutMarginsDemo
//
//  Created by Marina Gornostaeva on 26/05/2019.
//  Copyright © 2019 Marina Gornostaeva. All rights reserved.
//

import UIKit

final class PlainViewViewController: UIViewController {

    private let fullscreenView: ViewWithMargins = .init()
    private let movableView: ViewWithMargins = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Styling
        
        self.title = "Plain View"
        self.view.backgroundColor = UIColor.white
        
        self.fullscreenView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.movableView.backgroundColor = UIColor.red.withAlphaComponent(0.5)

        // Sizing
        
        self.fullscreenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.fullscreenView.frame = self.view.bounds
        self.movableView.frame.size = CGSize(width: 250, height: 250)
        
        // Hierarchy
        
        self.fullscreenView.preservesSuperviewLayoutMargins = true
        self.movableView.preservesSuperviewLayoutMargins = true
        
        self.view.addSubview(self.fullscreenView)
        self.view.addSubview(self.movableView)
        
        self.addBarButtonItems()
        self.addPanGestureRecognizer()
        
        self.repositionMovableView()
    }

    private func repositionMovableView() {
        self.movableView.center = CGPoint(x: self.fullscreenView.bounds.midX, y: self.fullscreenView.bounds.midY)
    }
    
    @objc private func pan(sender: UIPanGestureRecognizer) {
        guard sender.state == .changed else {
            return
        }
        self.movableView.center.x += sender.translation(in: self.movableView).x.rounded()
        self.movableView.center.y += sender.translation(in: self.movableView).y.rounded()
        sender.setTranslation(.zero, in: self.movableView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
            // Making sure the view doesn't stay outside screen bounds
            self.repositionMovableView()
        })
    }
}

private extension PlainViewViewController {

    func addBarButtonItems() {
        let leftItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func addPanGestureRecognizer() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        self.movableView.addGestureRecognizer(panRecognizer)
    }
}
