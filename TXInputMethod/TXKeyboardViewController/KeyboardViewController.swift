//
//  KeyboardViewController.swift
//  TXKeyboardViewController
//
//  Created by zhhz on 16/7/23.
//  Copyright © 2016年 zhhz. All rights reserved.
//

import UIKit

//定义枚举类型标注shift按键所单击的次数
enum SHIFT_TAP
{
    case SHIFT_ONCE;
    case SHIFT_TWICE;
    case SHIFT_THIRD;
}

//定义枚举类型标注当前键盘类型
enum KEYBOARD_TYPE
{
    case ALPHABET; //字母键盘
    case NUMBER; //数字键盘
}

//定义一个全局的变量，标注单击shift按键的次数
var shiftFlag:SHIFT_TAP = SHIFT_TAP.SHIFT_ONCE;

class KeyboardViewController: UIInputViewController
{
    
    var nextButton: UIButton!
    
    var alphabetplaneview:AlphabetPlaneView!;//字母键盘
    var timer:NSTimer!;
    var keyboardType:KEYBOARD_TYPE!;
    let screenWidth = UIScreen.mainScreen().bounds.size.width

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //self.view.multipleTouchEnabled = false
        //self.view.exclusiveTouch = true;
        self.keyboardType = KEYBOARD_TYPE.ALPHABET;
    
        // Perform custom UI setup here
        self.nextButton = UIButton(type: .System)
        
        self.nextButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextButton.sizeToFit()
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextButton)
        
        self.nextButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        self.nextButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
 
        self.alphabetplaneview = AlphabetPlaneView(frame:CGRectMake(0, 0, screenWidth, CGFloat(keyboardHeight())))
        
        //self.view.backgroundColor = UIColor.blueColor();
        self.view.addSubview(self.alphabetplaneview)
    }
    
    func putKeyboardToView()
    {
        if(self.keyboardType == KEYBOARD_TYPE.ALPHABET)
        {
            shiftFlag = SHIFT_TAP.SHIFT_ONCE;
            alphabetplaneview = AlphabetPlaneView(frame:CGRectMake(0, 0, screenWidth, CGFloat(keyboardHeight())))

            self.view.addSubview(alphabetplaneview)
        }
    }
    
    /*--------------------------设置键盘高度---------------------------*/
    func keyboardHeight()->Float{
        var keyboardheight:Float
        
        switch screenWidth {
        case 320:
            keyboardheight = 216.0;
            break
        case 375:
            keyboardheight = 216.0;
            break
        case 414:
            keyboardheight = 226.0;
            break
        case 480:
            keyboardheight = 162.0;
            break
        case 568:
            keyboardheight = 162.0;
            break
        case 667:
            keyboardheight = 162.0;
            break
        case 736:
            keyboardheight = 162.0;
            break
        case 768:
            keyboardheight = 264.0;
            break
        case 1024:
            keyboardheight = 352.0;
            break
        default:
            keyboardheight = 216.0;
            break
        }
        return keyboardheight
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput?)
    {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput?)
    {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark
        {
            textColor = UIColor.whiteColor()
        }
        else
        {
            textColor = UIColor.blackColor()
        }
        self.nextButton.setTitleColor(textColor, forState: .Normal)
    }
    
    override func updateViewConstraints()
    {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
}
