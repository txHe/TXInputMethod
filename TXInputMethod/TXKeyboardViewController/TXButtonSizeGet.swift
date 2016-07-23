//
//  TXButtonSizeGet.swift
//  TXInputMethod
//
//  Created by zhhz on 16/7/23.
//  Copyright © 2016年 zhhz. All rights reserved.
//

import Foundation
import UIKit

class TXButtonSizeGet: NSObject
{
    var row_height = [CGFloat](); //获取每一行的高度
    var row_button_width_first = [CGFloat](); // 第一行的按键的宽度
    var row_button_width_second = [CGFloat](); // 第二行的按键的宽度
    var row_button_width_third = [CGFloat](); // 第三行的按键的宽度
    var row_button_width_fourth = [CGFloat](); // 第四行的按键的宽度
    
    /*---------------------------创建一个单例模式---------------------------*/
    class var shared: TXButtonSizeGet
    {
        dispatch_once(&Inner.token)
        {
            Inner.instance = TXButtonSizeGet()
        }
        return Inner.instance!
    }
    
    struct Inner {
        static var instance:TXButtonSizeGet?
        static var token:dispatch_once_t = 0;
    }

    /*通过Set函数设置各行的参数*/
    func setRowHeight(heights:[CGFloat])
    {
        row_height = heights;
    }
    
    func setFirstRowWidth(widths:[CGFloat])
    {
        row_button_width_first = widths;
    }
    
    func setSecondRowWidth(widths:[CGFloat])
    {
        
        row_button_width_second = widths;
    }
    
    func setThirdRowWidth(widths:[CGFloat])
    {
        row_button_width_third = widths;
    }
    
    func setFourthRowWidth(widths:[CGFloat])
    {
        row_button_width_fourth = widths;
    }
    
    
    /*通过Get函数获得各行的Size参数*/
    func getRowHeight()->[CGFloat]
    {
        return row_height;
    }
    
    func getFirstRowWidth() -> [CGFloat]
    {
        return row_button_width_first;
    }
    
    func getSecondRowWidth() -> [CGFloat]
    {
        return row_button_width_second;
    }
    
    func getThirdRowWidth() -> [CGFloat]
    {
        return row_button_width_third;
    }
    
    func getFourthRowWidth() -> [CGFloat]
    {
        return row_button_width_fourth;
    }

}