# ANPopUpContainer

[![CI Status](http://img.shields.io/travis/abdallahnh/ANPopUpContainer.svg?style=flat)](https://travis-ci.org/abdallahnh/ANPopUpContainer)
[![Version](https://img.shields.io/cocoapods/v/ANPopUpContainer.svg?style=flat)](http://cocoapods.org/pods/ANPopUpContainer)
[![License](https://img.shields.io/cocoapods/l/ANPopUpContainer.svg?style=flat)](http://cocoapods.org/pods/ANPopUpContainer)
[![Platform](https://img.shields.io/cocoapods/p/ANPopUpContainer.svg?style=flat)](http://cocoapods.org/pods/ANPopUpContainer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ANPopUpContainer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ANPopUpContainer'
```
## How to use
### Normal Display
```
let storyBoard = UIStoryboard(name: "Main", bundle: nil)
let popUpContainer = storyBoard.instantiateViewController(withIdentifier: "PopUPStoryId") as! ANPopUpContainerViewController
    popUpContainer.parentView = self
let firstView = storyBoard.instantiateViewController(withIdentifier: "FirstPopupStoryBoardId") as! FirstPopupViewController
    firstView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
    firstView.inPopUpContainer = popUpContainer 
        
 popUpContainer.displayContentController(for: firstView)
 self.present(popUpContainer, animated: true, completion: nil)
 
 ```
 ### Fade Display
 ```
let storyBoard = UIStoryboard(name: "Main", bundle: nil)
let popUpContainer = storyBoard.instantiateViewController(withIdentifier: "PopUPStoryId") as! ANPopUpContainerViewController
    popUpContainer.parentView = self
let firstView = storyBoard.instantiateViewController(withIdentifier: "FirstPopupStoryBoardId") as! FirstPopupViewController
    firstView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
    firstView.inPopUpContainer = popUpContainer 
        
 popUpContainer.displayContentControllerWithFadeAnimation(for: firstView)
 self.present(popUpContainer, animated: true, completion: nil)
 
 ```
        
## Author

abdallahnh, abdallah.nh@gmail.com

## License

ANPopUpContainer is available under the MIT license. See the LICENSE file for more info.
