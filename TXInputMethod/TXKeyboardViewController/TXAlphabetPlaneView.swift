//
//  AlphabetPlaneView.swift
//  iOS-ThirdParty-InputMethod
//
//  Created by txHe on 16/7/23.
//  Copyright © 2016年 txHe. All rights reserved.
//

/*
 *
 * 字母键盘布局类 - TXAlphabetPlaneView
 * 1.定义字母键盘上的所有按键，字母键、地球键、大小写键、空格键和删除键等
 * 2.按键布局，完全使用Contraints来实现AutoLayout布局，先每行自适应布局，再各行之间自适应布局
 *
 */

import UIKit
import Foundation

class TXAlphabetPlaneView : UIView
{
    /*------键盘按键的显示title，每一行title因布局不同单独定义-----*/
    var buttonTitles1 = [String]();
    var buttonTitles2 = [String]();
    var buttonTitles3 = [String]();
    var buttonTitles4 = [String]();
    
    var buttonAlphabet = [NormalButton](); //字母按键
    
    var buttonShift:ShiftButton!;//大小写切换按键
    var buttonDelete:DeleteButton!;//删除按键
    var button123:NormalButton!; //数字键盘按键
    var buttonEarth:EarthButton!; //地球键
    var buttonPunc:NormalButton!; //符号键
    var buttonSpace:NormalButton!;//空格按键
    var buttonEnter:NormalButton!;//换行按键
    
    let txButtonSizeGet = TXButtonSizeGet.shared;
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        buttonTitles1 = ["q","w","e","r","t","y","u","i","o","p"];
        buttonTitles2 = ["a","s","d","f","g","h","j","k","l"];
        buttonTitles3 = ["|","z","x","c","v","b","n","m","<-"];
        buttonTitles4 = ["123","CHG","符","space","return"];
        
        let keyboardWidth = frame.size.width;
        
        /*---------------------------添加按钮---------------------------*/
        
        let row1 = createFirstRowOfButtons(buttonTitles1,screenWidth: keyboardWidth);
        let row2 = createSecondRowOfButtons(buttonTitles2,screenWidth: keyboardWidth);
        let row3 = createThirdRowOfButtons(buttonTitles3,screenWidth: keyboardWidth);
        let row4 = createFourthRowOfButtons(buttonTitles4,screenWidth: keyboardWidth);
        
        self.addSubview(row1);
        self.addSubview(row2);
        self.addSubview(row3);
        self.addSubview(row4);
        
        row1.translatesAutoresizingMaskIntoConstraints = false;
        row2.translatesAutoresizingMaskIntoConstraints = false;
        row3.translatesAutoresizingMaskIntoConstraints = false;
        row4.translatesAutoresizingMaskIntoConstraints = false;
        addConstraintsToInputView(self,rowViews: [row1, row2, row3, row4]);
        
        self.layoutIfNeeded();
    
        txButtonSizeGet.setRowHeight([getOriginalHeight(row1),
                                      getOriginalHeight(row2),
                                      getOriginalHeight(row3),
                                      getOriginalHeight(row4)]);
        
        self.getButtonViewSize();
        
        self.backgroundColor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
        self.multipleTouchEnabled = false;
        self.exclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    /*-----------------获取当前按键布局的高度----------------*/
    func getOriginalHeight(buttonView:UIView) -> CGFloat
    {
        
        return buttonView.frame.origin.y + buttonView.frame.size.height;
    }
    
    /*-----------------获取当前按键布局的宽度----------------*/
    func getOriginalWidth(buttonView:UIView)->CGFloat
    {
        
        return buttonView.frame.origin.x + buttonView.frame.size.width;
    }
    
    /*-----------------获取当前布局下所有按键的宽度和高度----------------*/
    func getButtonViewSize()
    {
        var first_row_widths = [CGFloat]();
        var second_row_widths = [CGFloat]();
        var third_row_widths = [CGFloat]();

        for i in 0...9
        {
            first_row_widths.append(getOriginalWidth(self.buttonAlphabet[i]));
        }
        txButtonSizeGet.setFirstRowWidth(first_row_widths);
        
        for i in 10...18
        {
            second_row_widths.append(getOriginalWidth(self.buttonAlphabet[i]));
        }
        txButtonSizeGet.setSecondRowWidth(second_row_widths);
        
        
        third_row_widths.append(getOriginalWidth(self.buttonShift));
        for i in 19...25
        {
            third_row_widths.append(getOriginalWidth(self.buttonAlphabet[i]));
        }
        third_row_widths.append(getOriginalWidth(self.buttonDelete));
        txButtonSizeGet.setThirdRowWidth(third_row_widths);
        
        
        txButtonSizeGet.setFourthRowWidth([self.getOriginalWidth(button123),
                                           self.getOriginalWidth(buttonEarth),
                                           self.getOriginalWidth(buttonPunc),
                                           self.getOriginalWidth(self.buttonSpace),
                                           self.getOriginalWidth(buttonEnter)]);
    }
    
    /*---------------------------绘制第一行---------------------------*/
    func createFirstRowOfButtons(buttonTitles: [String],screenWidth:CGFloat) -> UIView
    {
        var buttons = [UIView]();
        let keyboardRowView = UIView(frame: CGRectMake(0, 0,screenWidth, 50));
        
        for i in 0...buttonTitles.count-1
        {
            let  tempButton = createNormalButtonWithTitle(buttonTitles[i]);
            buttonAlphabet.append(tempButton);
            buttons.append(tempButton);
            keyboardRowView.addSubview(tempButton);
        }
        
        addfirstrowButtonConstraints(buttons, mainView: keyboardRowView);
        
        return keyboardRowView;
    }
    
    /*---------------------------绘制第二行---------------------------*/
    func createSecondRowOfButtons(buttonTitles: [String],screenWidth:CGFloat) -> UIView
    {
        
        var buttons = [UIView]();
        //var tempButton:UIButton!
        let keyboardRowView = UIView(frame: CGRectMake(0, 0,screenWidth, 50));
        
        for i in 0...buttonTitles.count-1
        {
            let tempButton = createNormalButtonWithTitle(buttonTitles[i]);
            buttonAlphabet.append(tempButton);
            buttons.append(tempButton);
            keyboardRowView.addSubview(tempButton);
        }
        
        addsecondrowButtonConstraints(buttons, mainView: keyboardRowView);
        
        return keyboardRowView;
    }
    
    /*---------------------------绘制第三行---------------------------*/
    func createThirdRowOfButtons(buttonTitles: [String],screenWidth:CGFloat) -> UIView {
        
        var buttons = [UIView]();
        let keyboardRowView = UIView(frame: CGRectMake(0, 0,screenWidth, 50));
        
        self.buttonShift = ShiftButton(frame:CGRectMake(0.0, 0.0, 0.0, 0.0));
        buttons.append(self.buttonShift);
        keyboardRowView.addSubview(self.buttonShift);
        
        
        for i in 1...buttonTitles.count-2
        {
            let tempButton = createNormalButtonWithTitle(buttonTitles[i]);
            buttonAlphabet.append(tempButton);
            buttons.append(tempButton);
            keyboardRowView.addSubview(tempButton);
        }
        
        self.buttonDelete = DeleteButton(frame:CGRectMake(0.0, 0.0, 0.0, 0.0));
        buttons.append(self.buttonDelete);
        keyboardRowView.addSubview(self.buttonDelete);
        
        addthirdrowButtonConstraints(buttons, mainView: keyboardRowView);
        
        return keyboardRowView;
    }
    
    /*---------------------------绘制第四行---------------------------*/
    func createFourthRowOfButtons(buttonTitles: [String],screenWidth:CGFloat) -> UIView {
        
        var buttons = [UIView]();
        let keyboardRowView = UIView(frame: CGRectMake(0, 0,screenWidth, 50));
        
        self.button123 = createNormalButtonWithTitle(buttonTitles[0]);
        buttons.append(self.button123);
        
        self.buttonEarth = EarthButton(frame:CGRectMake(0.0, 0.0, 0.0, 0.0));
        buttons.append(self.buttonEarth);
        
        self.buttonPunc = createNormalButtonWithTitle(buttonTitles[2]);
        buttons.append(self.buttonPunc);
        
        self.buttonSpace = createNormalButtonWithTitle(buttonTitles[3]);
        buttons.append(self.buttonSpace);
        
        self.buttonEnter = createNormalButtonWithTitle(buttonTitles[4]);
        buttons.append(self.buttonEnter);
        
        keyboardRowView.addSubview(self.button123);
        keyboardRowView.addSubview(self.buttonEarth);
        keyboardRowView.addSubview(self.buttonPunc);
        keyboardRowView.addSubview(self.buttonSpace);
        keyboardRowView.addSubview(self.buttonEnter);
        
        addfourthrowIndividualButtonConstraints(buttons,mainView: keyboardRowView)
        
        return keyboardRowView
    }
    /*---------------------------绘制字母的按键---------------------------*/
    func createNormalButtonWithTitle(title: String) -> NormalButton
    {
        let button = NormalButton(frame:CGRectMake(0, 0.0, 0.0, 0.0));
        button.setTitle(title);
        
        return button;
    }
    
    /*---------------------------第一行内的按键的布局控制---------------------------*/
    func addfirstrowButtonConstraints(buttons: [UIView], mainView: UIView)
    {
        for (index, button) in buttons.enumerate()
        {
            let topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: mainView, attribute: .Top, multiplier: 1.0, constant: 1.0);
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: mainView, attribute: .Bottom, multiplier: 1.0, constant: -1.0);
            var rightConstraint : NSLayoutConstraint!;
            var leftConstraint : NSLayoutConstraint!;
            
            if(index == buttons.count - 1)
            {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: mainView, attribute: .Right, multiplier: 1.0, constant: -1.0);
            }
            else
            {
                let nextButton = buttons[index+1];
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left,multiplier: 1.0, constant: -4.0);
            }
            
            if(index == 0)
            {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: mainView, attribute: .Left, multiplier: 1.0, constant: 1.0);
                
            }
            else
            {
                let prevtButton = buttons[index-1];
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevtButton, attribute: .Right, multiplier: 1.0, constant: 4.0);
            }
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint]);
            
        }
        
        for i in 0...buttons.count-2
        {
            let widthConstraint = NSLayoutConstraint(item: buttons[i], attribute: .Width, relatedBy: .Equal, toItem: buttons[i + 1], attribute: .Width, multiplier: 1.0, constant: 0);
            mainView.addConstraint(widthConstraint);
        }
    }
    
    /*---------------------------第二行内的按键的布局控制---------------------------*/
    func addsecondrowButtonConstraints(buttons: [UIView], mainView: UIView)
    {
        for (index, button) in buttons.enumerate()
        {
            let topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: mainView, attribute: .Top, multiplier: 1.0, constant: 1.0);
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: mainView, attribute: .Bottom, multiplier: 1.0, constant: -1.0);
            var rightConstraint : NSLayoutConstraint!;
            var leftConstraint : NSLayoutConstraint!;

            if(index == buttons.count - 1)
            {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: mainView, attribute: .Right, multiplier: 1.0, constant: -10.0);
            }
            else
            {
                let nextButton = buttons[index+1];
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left,multiplier: 1.0, constant: -4.0);
            }
            
            if(index == 0)
            {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: mainView, attribute: .Left, multiplier: 1.0, constant: 10.0);
            }
            else
            {
                let prevtButton = buttons[index-1];
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevtButton, attribute: .Right, multiplier: 1.0, constant: 4.0);
            }
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint]);
        }
        
        for i in 0...buttons.count-2
        {
            let widthConstraint = NSLayoutConstraint(item: buttons[i], attribute: .Width, relatedBy: .Equal, toItem: buttons[i + 1], attribute: .Width, multiplier: 1.0, constant: 0);
            mainView.addConstraint(widthConstraint);
        }
        
    }
    
    /*---------------------------第三行内的按键的布局控制---------------------------*/
    func addthirdrowButtonConstraints(buttons: [UIView], mainView: UIView)
    {
        for (index, button) in buttons.enumerate()
        {
            let topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: mainView, attribute: .Top, multiplier: 1.0, constant: 1.0);
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: mainView, attribute: .Bottom, multiplier: 1.0, constant: -1.0);
            var rightConstraint : NSLayoutConstraint!;
            var leftConstraint : NSLayoutConstraint!;

            if(index == buttons.count - 1)
            {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: mainView, attribute: .Right, multiplier: 1.0, constant: -1.0);
            }
            else
            {
                let nextButton = buttons[index+1];
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left,multiplier: 1.0, constant: -4.0);
            }

            if(index == 0)
            {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: mainView, attribute: .Left, multiplier: 1.0, constant: 1.0);
                
            }
            else
            {
                let prevtButton = buttons[index-1];
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevtButton, attribute: .Right, multiplier: 1.0, constant: 4.0);
            }
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint]);
        }
        
        /*---------------------------使得最后一个与第一个按键的大小一致--------------------------*/
        let widthConstraint_second = NSLayoutConstraint(item: buttons[buttons.count - 1], attribute: .Width, relatedBy: .Equal, toItem: buttons[0], attribute: .Width, multiplier:1.0, constant: 0);
        mainView.addConstraint(widthConstraint_second);
        
        /*---------------------------使得第2~8按键宽度一致--------------------------*/
        for i in 1...buttons.count-3
        {
            let widthConstraint = NSLayoutConstraint(item: buttons[i], attribute: .Width, relatedBy: .Equal, toItem: buttons[i + 1], attribute: .Width, multiplier: 1.0, constant: 0);
            mainView.addConstraint(widthConstraint);
        }
        
        let widthConstraint_third = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: buttons[1], attribute: .Width, multiplier: 2.0, constant: 0);
        mainView.addConstraint(widthConstraint_third);
    }
    
    /*---------------------------第四行内的按键的布局控制---------------------------*/
    func addfourthrowIndividualButtonConstraints(buttons: [UIView], mainView: UIView)
    {
        
        for (index, button) in buttons.enumerate()
        {
            let topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: mainView, attribute: .Top, multiplier: 1.0, constant: 1.0);
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: mainView, attribute: .Bottom, multiplier: 1.0, constant: -1.0);
            var rightConstraint : NSLayoutConstraint!;
            var leftConstraint : NSLayoutConstraint!;

            if(index == buttons.count - 1)
            {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: mainView, attribute: .Right, multiplier: 1.0, constant: -1.0);
            }
            else
            {
                let nextButton = buttons[index+1];
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left,multiplier: 1.0, constant: -4.0);
            }

            if(index == 0)
            {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: mainView, attribute: .Left, multiplier: 1.0, constant: 1.0);
            }
            else
            {
                let prevtButton = buttons[index-1];
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevtButton, attribute: .Right, multiplier: 1.0, constant: 4.0);
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint]);
        }
        /*---------------------------使第一个、第二个按键宽度一致---------------------------*/

        let widthConstraintFirst = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: buttons[1], attribute: .Width, multiplier: 1.0, constant: 0);
        
        
        /*---------------------------使得第三个按键为第二个的2/3-------------------------*/
        let widthConstraintSecond = NSLayoutConstraint(item: buttons[2], attribute: .Width, relatedBy: .Equal, toItem: buttons[1], attribute: .Width, multiplier: 2/3, constant: 0);
        
        /*---------------------------使得第四个按键为第三个按键宽度的4倍--------------------------*/
        let widthConstraintThird = NSLayoutConstraint(item: buttons[3], attribute: .Width, relatedBy: .Equal, toItem: buttons[2], attribute: .Width, multiplier: 4.0, constant: 0);
        
        /*---------------------------使得第五个按键为第四个按键的2/3--------------------------*/
        let widthConstraintFourth = NSLayoutConstraint(item: buttons[4], attribute: .Width, relatedBy: .Equal, toItem: buttons[3], attribute: .Width, multiplier: 1/2, constant: 0);
        
        mainView.addConstraints([widthConstraintFirst, widthConstraintSecond, widthConstraintThird, widthConstraintFourth]);
    }
    
    /*---------------------------行与行之间的布局控制---------------------------*/
    func addConstraintsToInputView(inputView: UIView, rowViews: [UIView])
    {
        for (index, rowView) in rowViews.enumerate()
        {
            let rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .Right, relatedBy: .Equal, toItem: inputView, attribute: .Right, multiplier: 1.0, constant: -1);
            
            let leftConstraint = NSLayoutConstraint(item: rowView, attribute: .Left, relatedBy: .Equal, toItem: inputView, attribute: .Left, multiplier: 1.0, constant: 1);
            
            
            var topConstraint: NSLayoutConstraint;
            var bottomConstraint: NSLayoutConstraint;

            if(index == 0)
            {
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: inputView, attribute: .Top, multiplier: 1.0, constant: 3.0);
            }
            else
            {
                let prevRow = rowViews[index-1];
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: prevRow, attribute: .Bottom, multiplier: 1.0, constant: 3.0);
            }

            if(index == rowViews.count - 1)
            {
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: inputView, attribute: .Bottom, multiplier: 1.0, constant: -1.5);
            }
            else
            {
                let nextRow = rowViews[index+1];
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: nextRow, attribute: .Top, multiplier: 1.0, constant: -3.0);
            }
            inputView.addConstraints([leftConstraint, rightSideConstraint, bottomConstraint, topConstraint]);

        }
        /*---------------------------行与行之间高度的限制---------------------------*/
        let heightConstraintSecond = NSLayoutConstraint(item: rowViews[0], attribute: .Height, relatedBy: .Equal, toItem: rowViews[1], attribute: .Height, multiplier: 1.0, constant: 0);
        let heightConstraintThird = NSLayoutConstraint(item: rowViews[1], attribute: .Height, relatedBy: .Equal, toItem: rowViews[2], attribute: .Height, multiplier: 1.0, constant: 0);
        let heightConstraintFourth = NSLayoutConstraint(item: rowViews[2], attribute: .Height, relatedBy: .Equal, toItem: rowViews[3], attribute: .Height, multiplier: 1.0, constant: 0);
        
        inputView.addConstraints([heightConstraintSecond, heightConstraintThird, heightConstraintFourth]);
        
    }
    
    
    func updateViewConstraints() {
        updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    
}