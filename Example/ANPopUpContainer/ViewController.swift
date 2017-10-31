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
    @IBAction func popUpAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let currancyView = storyBoard.instantiateViewController(withIdentifier: "CurrencyStoryBoardId") as! CurrencyTableViewController
        let popUpContainer = storyBoard.instantiateViewController(withIdentifier: "PopUPStoryId") as! ANPopUpContainerViewController
         popUpContainer.parentView = self
        popUpContainer.displayContentController(for: currancyView)
        self.present(popUpContainer, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

