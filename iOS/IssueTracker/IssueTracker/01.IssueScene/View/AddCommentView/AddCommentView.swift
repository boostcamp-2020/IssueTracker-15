//
//  AddCommentView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class AddCommentView: UIView {
    var upButtonTapped: (() -> Void)?
    var downButtonTapped: (() -> Void)?
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    var fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - (addCommentButton.frame.maxY + (self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureGesture()
    }
    
    private func configureGesture() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        self.addGestureRecognizer(gesture)
    }
}

// MARK: - loadNIB extension
extension AddCommentView {
    static let identifier = "AddCommentView"
    static func createView() -> AddCommentView? {
        return Bundle.main.loadNibNamed(AddCommentView.identifier, owner: self, options: nil)?.last as? AddCommentView
    }
}

// MARK: - Action
extension AddCommentView {
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let velocity = recognizer.velocity(in: self)
        let y = self.frame.minY
        
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.frame = CGRect(x: 0, y: y + translation.y, width: self.frame.width, height: self.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self)
        }
        
        if recognizer.state == .ended {
            var duration = velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if velocity.y >= 0 {
                    self.frame = CGRect(x: 0, y: self.partialView, width: self.frame.width, height: self.frame.height)
                } else {
                    self.frame = CGRect(x: 0, y: self.fullView, width: self.frame.width, height: self.frame.height)
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
