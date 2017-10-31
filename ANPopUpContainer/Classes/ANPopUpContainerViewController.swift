
//
//  ANPopUpContainerViewController.swift
//  AN
//
//  Created by Abdallah Nehme on 10/27/17.
//  Copyright © 2017 AN. All rights reserved.
//

import UIKit


public class ANPopUpContainerViewController: UIViewController {

    // MARK: - variables
    //  track the keyboard visibility state
    var keyBoardVisible: Bool!
    //  instance of the parent view controller
    public var parentView: UIViewController!
    //  currentView loaded in the container
    public var currentViewController: UIViewController!
    //  constraints
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    // MARK: - life Cycle
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //containerView.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            //self.containerView.alpha = 1.0
        }, completion: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        UIView.transition(with: self.view, duration: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.addSubview(blurEffectView)
        }, completion: { (done) in
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                //self.containerView.alpha = 1.0
            }, completion: nil)
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardVisible), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHidden), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        keyBoardVisible = false
        
        
    }
    
    // MARK: - Keyboard State
    @objc func keyboardVisible()  {
        print("keyboardVisible")
        keyBoardVisible = true
    }
    
    @objc func keyboardHidden(){
        print("keyboardHidden")
        keyBoardVisible = false
    }
   
    // MARK: - display
    public func displayContentController(for viewController: UIViewController){
        addChildViewController(viewController)

        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
       
        //edit view layer
        viewController.view.layer.cornerRadius = 5.0
        
        
        //add Constraints to the viewController
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: viewController.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: viewController.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
         NSLayoutConstraint(item: viewController.view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //take copy of viewController
        currentViewController = viewController
        
        //add KVO if viewController
        if let tableViewController = viewController as? UITableViewController {
            tableViewController.tableView.addObserver(self, forKeyPath:"contentSize", options: [], context: nil)
            currentViewController = tableViewController
            let objectHeight = tableViewController.tableView.contentSize.height
            if #available(iOS 9.0, *) {
                heightConstraint = currentViewController.view.heightAnchor.constraint(equalToConstant: objectHeight)
            } else {
                // Fallback on earlier versions
            }
           heightConstraint.isActive = true
        }
        else {
            if #available(iOS 9.0, *) {
                heightConstraint = currentViewController.view.heightAnchor.constraint(equalToConstant: viewController.view.frame.size.height)
                heightConstraint.isActive = true
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    public func displayContentControllerWithFadeAnimation(for viewController: UIViewController) {
        hideContentController(for: viewController)
        viewController.view.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.displayContentController(for: viewController)
        }, completion:{ (done) in
            
            UIView.animate(withDuration: 1, delay: 0.5, options: [], animations: {
                viewController.view.alpha = 1.0
            }, completion: nil)
        })
        
    }
    public func displayContentControllerWithSlideAnimation(from oldVC: UIViewController, to newVC: UIViewController) {
        
        // Prepare the two view controllers for the change.
        oldVC.willMove(toParentViewController: nil)
        addChildViewController(newVC)
        view.addSubview(newVC.view)
        
        // Get the start frame of the new view controller and the end frame
        // for the old view controller. Both rectangles are offscreen.
        newVC.view.frame = CGRect(x: oldVC.view.frame.size.width, y: oldVC.view.frame.origin.y, width: newVC.view.frame.size.width, height: newVC.view.frame.size.height)
        //edit view layer
        newVC.view.layer.cornerRadius = 5.0
        
        //add Constraints to viewController
        newVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: newVC.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: newVC.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: newVC.view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        currentViewController = newVC
        
        //add KVO if viewController
        if let tableViewController = newVC as? UITableViewController {
            tableViewController.tableView.addObserver(self, forKeyPath:"contentSize", options: [], context: nil)
            currentViewController = tableViewController
            let objectHeight = tableViewController.tableView.contentSize.height
            if #available(iOS 9.0, *) {
                heightConstraint = currentViewController.view.heightAnchor.constraint(equalToConstant: objectHeight)
            } else {
                // Fallback on earlier versions
            }
            heightConstraint.isActive = true
        }
        else {
            if #available(iOS 9.0, *) {
                heightConstraint = currentViewController.view.heightAnchor.constraint(equalToConstant: newVC.view.frame.size.height)
                heightConstraint.isActive = true
            } else {
                // Fallback on earlier versions
            }
        }
        
        let endFrame: CGRect = CGRect(x: -oldVC.view.frame.size.width, y: oldVC.view.frame.origin.y, width: oldVC.view.frame.size.width, height: oldVC.view.frame.size.height)
        // Start the animation.
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
            
            newVC.view.frame = CGRect(x: 0, y: oldVC.view.frame.origin.y, width: newVC.view.frame.size.width, height: newVC.view.frame.size.height)
            oldVC.view.frame = endFrame
            
        }) { (done) in
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParentViewController()
            newVC.didMove(toParentViewController: self)
        }
    }
    
    // MARK: - Hide
    public func hideContentController(for viewController: UIViewController){
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    // MARK: - Observe value
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            
            
            if let obj = object as? UITableView
            {
                let objectHeight = obj.contentSize.height
                
                heightConstraint.isActive = false
                if #available(iOS 9.0, *) {
                    heightConstraint =  currentViewController.view.heightAnchor.constraint(equalToConstant: objectHeight)
                } else {
                    // Fallback on earlier versions
                }
                heightConstraint.isActive = true
            }
           
        }
    }
  
    // MARK: - misc
    override public var shouldAutomaticallyForwardAppearanceMethods: Bool{
        return false
    }
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !keyBoardVisible {
            self.dismiss(animated: true, completion: nil)
        }else{
             self.view.endEditing(true)
        }
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
// MARK: - UIView extension
extension UIView {
    func screenShot(_ frame: CGRect) -> UIImage? {
        let layer = self.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}

