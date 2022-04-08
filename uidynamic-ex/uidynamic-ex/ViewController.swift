//
//  ViewController.swift
//  uidynamic-ex
//
//  Created by 이정우 on 2022/04/06.
//

import UIKit

class ViewController: UIViewController {
    
    var ballView : UIView?
    var ball2View : UIView?
    var animator : UIDynamicAnimator?
    var currentLocation: CGPoint?
    var attachment: UIAttachmentBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ballView = UIView(frame: CGRect(x: 200, y: 100, width: 80, height: 80))
        ballView?.backgroundColor = .white
        ballView?.layer.borderColor = UIColor.black.cgColor
        ballView?.layer.borderWidth = 3
        ballView?.clipsToBounds = true
        ballView?.layer.cornerRadius = 40
        
        ball2View = UIView(frame: CGRect(x: 200, y: 100, width: 80, height: 80))
        ball2View?.backgroundColor = .white
        ball2View?.layer.borderColor = UIColor.black.cgColor
        ball2View?.layer.borderWidth = 3
        ball2View?.clipsToBounds = true
        ball2View?.layer.cornerRadius = 40
        
        self.view.addSubview(ballView!)
        self.view.addSubview(ball2View!)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        let gravity = UIGravityBehavior()
        let collision = UICollisionBehavior()
        let behavior = UIDynamicItemBehavior()
        
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addItem(ballView!)
        collision.addItem(ball2View!)
        
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 1)
        gravity.addItem(ballView!)
        gravity.addItem(ball2View!)
        
        behavior.elasticity = 0.7
        behavior.addItem(ballView!)
                
        animator?.addBehavior(behavior)
        animator?.addBehavior(gravity)
        animator?.addBehavior(collision)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let theTouch = touches.first! as UITouch
            currentLocation = theTouch.location(in: self.view)
            let offset = UIOffset(horizontal: 20, vertical: 20)
            attachment = UIAttachmentBehavior(item: ballView!, offsetFromCenter: offset, attachedToAnchor: currentLocation!)
            
            animator?.addBehavior(attachment!)
        }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let theTouch = touches.first! as UITouch
        
        currentLocation = theTouch.location(in: self.view)
        attachment?.anchorPoint = currentLocation!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animator?.removeBehavior(attachment!)
            
    }
        


}

