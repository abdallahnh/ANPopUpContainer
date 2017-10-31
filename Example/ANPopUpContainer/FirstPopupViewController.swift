//
//  FirstPopupViewController.swift
//  ANPopUpContainer_Example
//
//  Created by Abdallah Nehme on 10/31/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ANPopUpContainer
class FirstPopupViewController: UIViewController {

    var inPopUpContainer: ANPopUpContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func slidePopUpView(_ sender: Any) {
       
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let slideView = storyBoard.instantiateViewController(withIdentifier: "SlidePopupStoryBoardId")
        slideView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        
        if let popUpContainer = inPopUpContainer {
        
            popUpContainer.displayContentControllerWithSlideAnimation(from:
                popUpContainer.currentViewController, to: slideView)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
