//
//  ViewController.swift
//  PopUpContainer
//
//  Created by abdallahnh on 10/31/2017.
//  Copyright (c) 2017 abdallahnh. All rights reserved.
//

import UIKit
import ANPopUpContainer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    @IBAction func popUpWithSlideAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let firstView = storyBoard.instantiateViewController(withIdentifier: "FirstPopupStoryBoardId") as! FirstPopupViewController
        firstView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        let popUpContainer = storyBoard.instantiateViewController(withIdentifier: "PopUPStoryId") as! ANPopUpContainerViewController
        firstView.inPopUpContainer = popUpContainer 
        popUpContainer.parentView = self
        popUpContainer.displayContentController(for: firstView)
        self.present(popUpContainer, animated: true, completion: nil)
    }
    @IBAction func popUpAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let currancyView = storyBoard.instantiateViewController(withIdentifier: "CurrencyStoryBoardId") as! CurrencyTableViewController
        let popUpContainer = storyBoard.instantiateViewController(withIdentifier: "PopUPStoryId") as! ANPopUpContainerViewController
         popUpContainer.parentView = self
        popUpContainer.displayContentControllerWithFadeAnimation(for: currancyView)
        self.present(popUpContainer, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

