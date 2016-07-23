//
//  KeyboardViewController.swift
//  TXKeyboardViewController
//
//  Created by zhhz on 16/7/23.
//  Copyright © 2016年 zhhz. All rights reserved.
//

import UIKit

//定义枚举类型标注shift按键所单击的次数
enum SHIFT_TYPE
{
    case SHIFT_LOWERALWAYS;
    case SHIFT_UPPERONCE;
    case SHIFT_UPPERALWAYS;
}

//定义枚举类型标注当前键盘类型
enum KEYBOARD_TYPE
{
    case ALPHABET; //字母键盘
    case NUMBER; //数字键盘
}

//定义一个全局的变量，标注单击shift按键的次数
var shiftFlag:SHIFT_TYPE = SHIFT_TYPE.SHIFT_LOWERALWAYS;

class KeyboardViewController: UIInputViewController
{
    
    var nextButton: UIButton!
    
    var txAlphabetPlaneView:TXAlphabetPlaneView!;//字母键盘
    var timer:NSTimer!;
    var deleteTime:Double!;
    var keyboardType:KEYBOARD_TYPE!;
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let txButtonSizeGet = TXButtonSizeGet.shared;

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.keyboardType = KEYBOARD_TYPE.ALPHABET;
        self.deleteTime = 0.0;
     
        self.view.multipleTouchEnabled = false
        self.view.exclusiveTouch = true;
        
        self.putKeyboardToView();
    }
    
    func putKeyboardToView()
    {
        if(self.keyboardType == KEYBOARD_TYPE.ALPHABET)
        {
            shiftFlag = SHIFT_TYPE.SHIFT_LOWERALWAYS;
            self.txAlphabetPlaneView = TXAlphabetPlaneView(frame:CGRectMake(0, 0, screenWidth, CGFloat(keyboardHeight())));

            self.view.addSubview(self.txAlphabetPlaneView);
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        
        var row_height = txButtonSizeGet.getRowHeight(); //获取每一行的高度
        var row_button_width_first = txButtonSizeGet.getFirstRowWidth(); // 第一行的按键的宽度
        var row_button_width_second = txButtonSizeGet.getSecondRowWidth(); // 第二行的按键的宽度
        var row_button_width_third = txButtonSizeGet.getThirdRowWidth(); // 第三行的按键的宽度
        var row_button_width_fourth = txButtonSizeGet.getFourthRowWidth(); // 第四行的按键的宽度
        
        let touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        
        var rowIndex = 0;
        
        let positionX = touch.locationInView(self.view).x; //index_x为所在的点的横坐标
        let positionY = touch.locationInView(self.view).y; //y为所在点的纵坐标
        
        if(positionY > 0)
        {
            
            if(0 < positionY && positionY < row_height[0])
            {
                rowIndex = 1;
            }
            else if(row_height[0] < positionY && positionY < row_height[1])
            {
                rowIndex = 2;
            }
            else if(row_height[1] < positionY && positionY < row_height[2])
            {
                rowIndex = 3;
            }
            else if(row_height[2] < positionY && positionY < row_height[3])
            {
                rowIndex = 4;
            }
        }
        
        if(self.keyboardType == KEYBOARD_TYPE.ALPHABET)
        {
            if(rowIndex == 1)
            {
                if(0 < positionX && positionX < row_button_width_first[0])
                {
                    self.didTapAlphabetButton("q");
                }
                else if(row_button_width_first[0] < positionX && positionX < row_button_width_first[1])
                {
                    self.didTapAlphabetButton("w");
                }
                else if(row_button_width_first[1] < positionX && positionX < row_button_width_first[2])
                {
                    self.didTapAlphabetButton("e");
                }
                else if(row_button_width_first[2] < positionX && positionX < row_button_width_first[3])
                {
                    self.didTapAlphabetButton("r");
                }
                else if(row_button_width_first[3] < positionX && positionX < row_button_width_first[4])
                {
                    self.didTapAlphabetButton("t");
                }
                else if(row_button_width_first[4] < positionX && positionX < row_button_width_first[5])
                {
                    self.didTapAlphabetButton("y");
                }
                else if(row_button_width_first[5] < positionX && positionX < row_button_width_first[6])
                {
                    self.didTapAlphabetButton("u");
                }
                else if(row_button_width_first[6] < positionX && positionX < row_button_width_first[7])
                {
                    self.didTapAlphabetButton("i");
                }
                else if(row_button_width_first[7] < positionX && positionX < row_button_width_first[8])
                {
                    self.didTapAlphabetButton("o");
                }
                else if(row_button_width_first[8] < positionX && positionX < row_button_width_first[9])
                {
                    self.didTapAlphabetButton("p");
                }
            }
            else if(rowIndex == 2)
            {
                if(0 < positionX && positionX < row_button_width_second[0])
                {
                    self.didTapAlphabetButton("a");
                }
                else if(row_button_width_second[0] < positionX && positionX < row_button_width_second[1])
                {
                    self.didTapAlphabetButton("s");
                }
                else if(row_button_width_second[1] < positionX && positionX < row_button_width_second[2])
                {
                    self.didTapAlphabetButton("d");
                }
                else if(row_button_width_second[2] < positionX && positionX < row_button_width_second[3])
                {
                    self.didTapAlphabetButton("f");
                }
                else if(row_button_width_second[3] < positionX && positionX < row_button_width_second[4])
                {
                    self.didTapAlphabetButton("g");
                }
                else if(row_button_width_second[4] < positionX && positionX < row_button_width_second[5])
                {
                    self.didTapAlphabetButton("h");
                }
                else if(row_button_width_second[5] < positionX && positionX < row_button_width_second[6])
                {
                    self.didTapAlphabetButton("j");
                }
                else if(row_button_width_second[6] < positionX && positionX < row_button_width_second[7])
                {
                    self.didTapAlphabetButton("k");
                }
                else if(row_button_width_second[7] < positionX && positionX < row_button_width_second[8])
                {
                    self.didTapAlphabetButton("l");
                }
                
            }
            else if(rowIndex == 3)
            {
                if(0 < positionX && positionX < row_button_width_third[0])
                {
                    let tapcount = touch.tapCount;
                    if(tapcount == 1)
                    {
                        self.singleShift();
                    }
                    else if(tapcount == 2)
                    {
                        self.doubleShift();
                    }
                }
                else if(row_button_width_third[0] < positionX && positionX < row_button_width_third[1])
                {
                    self.didTapAlphabetButton("z");
                }
                else if(row_button_width_third[1] < positionX && positionX < row_button_width_third[2])
                {
                    self.didTapAlphabetButton("x");
                }
                else if(row_button_width_third[2] < positionX && positionX < row_button_width_third[3])
                {
                    self.didTapAlphabetButton("c");
                }
                else if(row_button_width_third[3] < positionX && positionX < row_button_width_third[4])
                {
                    self.didTapAlphabetButton("v");
                }
                else if(row_button_width_third[4] < positionX && positionX < row_button_width_third[5])
                {
                    self.didTapAlphabetButton("b");
                }
                else if(row_button_width_third[5] < positionX && positionX < row_button_width_third[6])
                {
                    self.didTapAlphabetButton("n");
                }
                else if(row_button_width_third[6] < positionX && positionX < row_button_width_third[7])
                {
                    self.didTapAlphabetButton("m");
                }
                else if(row_button_width_third[7] < positionX && positionX < row_button_width_third[8])
                {
                    deleteTime = touch.timestamp;
                    
                    self.performSelector(#selector(KeyboardViewController.longDelete), withObject: nil, afterDelay: 0.6);
                }
                
            }
            else if(rowIndex == 4)
            {
                if(0 < positionX && positionX < row_button_width_fourth[0])
                {
                    //To 123 keyboard
                }
                else if(row_button_width_fourth[0] < positionX && positionX < row_button_width_fourth[1])
                {
                    self.didTapEarthButton();
                }
                else if(row_button_width_fourth[1] < positionX && positionX < row_button_width_fourth[2])
                {
                    //To punc keyboard
                }
                else if(row_button_width_fourth[2] < positionX && positionX < row_button_width_fourth[3])
                {
                    self.didTapSpace();
                }
                else if(row_button_width_fourth[3] < positionX && positionX < row_button_width_fourth[4])
                {
                    self.didTapEnter();
                }
            }

        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesEnded(touches, withEvent: event)
        if(deleteTime != 0.0)
        {
            let diff:NSTimeInterval = (event?.timestamp)! - deleteTime;
            if(diff < 0.5)
            {
                deleteOneCharacter();
                NSObject.cancelPreviousPerformRequestsWithTarget(self,selector: #selector(KeyboardViewController.longDelete),object: nil);
            }
            deleteTime = 0.0;
        }
        
        if(timer != nil)
        {
            timer.invalidate();
            timer = nil;
            NSObject.cancelPreviousPerformRequestsWithTarget(self,selector: #selector(KeyboardViewController.longDelete),object: nil);
        }

    }
    
    /*---------------------------单击shift键---------------------------*/
    func singleShift(){
        if(shiftFlag == SHIFT_TYPE.SHIFT_LOWERALWAYS) //如果原来是纯小写，单机后转换当前字母大写
        {
            shiftFlag = SHIFT_TYPE.SHIFT_UPPERONCE;
            txAlphabetPlaneView.buttonShift.setNeedsDisplay()
        }
        else if(shiftFlag == SHIFT_TYPE.SHIFT_UPPERONCE) //如果是当前字母大写，则转换成纯小写
        {
            shiftFlag = SHIFT_TYPE.SHIFT_LOWERALWAYS;
            txAlphabetPlaneView.buttonShift.setNeedsDisplay()
        }
        else if(shiftFlag == SHIFT_TYPE.SHIFT_UPPERALWAYS)
        {
            shiftFlag = SHIFT_TYPE.SHIFT_LOWERALWAYS;
            txAlphabetPlaneView.buttonShift.setNeedsDisplay()
        }
        
    }
    /*---------------------------双击shift键---------------------------*/
    func doubleShift()
    {
        if(shiftFlag != SHIFT_TYPE.SHIFT_UPPERALWAYS)
        {
            shiftFlag = SHIFT_TYPE.SHIFT_UPPERALWAYS;
            txAlphabetPlaneView.buttonShift.setNeedsDisplay()
        }
        
    }
    
    /*---------------------------按英文键响应---------------------------*/
    func didTapAlphabetButton(title:String)
    {
        
        var inputstring:String = "";
        
        if(shiftFlag == SHIFT_TYPE.SHIFT_LOWERALWAYS)
        {
            inputstring = title.lowercaseString;
        }
        else if(shiftFlag == SHIFT_TYPE.SHIFT_UPPERONCE)
        {
            shiftFlag = SHIFT_TYPE.SHIFT_LOWERALWAYS;
            txAlphabetPlaneView.buttonShift.setNeedsDisplay()
            inputstring = title.uppercaseString;
        }
        else if (shiftFlag == SHIFT_TYPE.SHIFT_UPPERALWAYS)
        {
            inputstring = title.uppercaseString
        }
        
        let proxy = textDocumentProxy
        proxy.insertText(inputstring)
        
        //putKeyboardViewsWithPlaneType(1); // 展示英文输入界面
    }
    
    /*---------------------------按空格---------------------------*/
    func didTapSpace()
    {
        let proxy = textDocumentProxy
        proxy.insertText(" ")
    }
    
    /*---------------------------按换行键---------------------------*/
    func didTapEnter()
    {
        let proxy = textDocumentProxy
        proxy.insertText("\n")
    }
    
    /*---------------------------按地球键---------------------------*/
    func didTapEarthButton()
    {
        advanceToNextInputMode()
    }
    
    /*---------------------------长按加速删除---------------------------*/
    func longDelete()
    {
        timer = NSTimer(timeInterval: 0.1, target: self, selector: #selector(UIKeyInput.deleteBackward), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    
    /*---------------------------当你按下一个删除键时，删除一个字符---------------------------*/
    func deleteOneCharacter()
    {
        let proxy = textDocumentProxy
        proxy.deleteBackward()
    }
    
    /*---------------------------删除一个字符---------------------------*/
    func deleteBackward()
    {
        let proxy = textDocumentProxy
        proxy.deleteBackward()
    }
    
    /*--------------------------设置键盘高度---------------------------*/
    func keyboardHeight()->Float
    {
        var keyboardheight:Float
        
        switch screenWidth
        {
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
    /*
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
    }*/
    
    override func updateViewConstraints()
    {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
}
