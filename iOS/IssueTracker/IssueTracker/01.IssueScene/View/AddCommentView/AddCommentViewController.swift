//
//  AddCommentViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {
    static let identifier = "AddCommentViewController"
    var upButtonTapped: (() -> Void)?
    var downButtonTapped: (() -> Void)?
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    var fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - (addCommentButton.frame.maxY + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGesture()
        configureLayer()
    }
    
    private func configureGesture() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    private func configureLayer() {
        self.view.layer.cornerRadius = self.view.frame.width * 0.05
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration = velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: nil)
        }
    }
    
    @IBAction func addCommentButtonTapped(_ sender: Any) {
    }
    
    @IBAction func upButtonTapped(_ sender: Any) {
        upButtonTapped?()
    }
    
    @IBAction func downButtonTapped(_ sender: Any) {
        downButtonTapped?()
    }
}
