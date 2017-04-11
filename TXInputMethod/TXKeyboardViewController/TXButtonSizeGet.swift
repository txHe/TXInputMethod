//
//  TXButtonSizeGet.swift
//  TXInputMethod
//
//  Created by txHe on 16/7/23.
//  Copyright © 2016年 txHe. All rights reserved.
//

/*
 *
 * 单例类 - TXButtonSizeGet
 * 功能点: 因为键盘上所有的按键视图都是Autolayout的,具体到各个机型上，按键的位置、大小都不是固定的。
 * 而我们的设计时，触屏按键输入字符，调用touchesBegan和touchesEnd时，需要知道当前触摸的地方所代表的按键
 * 故而，需要设计这个单例用于获取当前的Autolayout后的按键的布局信息，便于分析。
 *
 */

import Foundation
import UIKit

class TXButtonSizeGet: NSObject
{
    private static var __once: () = {
            Inner.instance = TXButtonSizeGet()
        }()
    var row_height = [CGFloat](); //获取每一行的高度
    var row_button_width_first = [CGFloat](); // 第一行的按键的宽度
    var row_button_width_second = [CGFloat](); // 第二行的按键的宽度
    var row_button_width_third = [CGFloat](); // 第三行的按键的宽度
    var row_button_width_fourth = [CGFloat](); // 第四行的按键的宽度
    
    /*---------------------------创建一个单例模式---------------------------*/
    class var shared: TXButtonSizeGet
    {
        _ = TXButtonSizeGet.__once
        return Inner.instance!
    }
    
    struct Inner {
        static var instance:TXButtonSizeGet?
        static var token:Int = 0;
    }

    /*--------通过Set函数设置各行的参数--------*/
    func setRowHeight(_ heights:[CGFloat])
    {
        row_height = heights;
    }
    
    func setFirstRowWidth(_ widths:[CGFloat])
    {
        row_button_width_first = widths;
    }
    
    func setSecondRowWidth(_ widths:[CGFloat])
    {
        
        row_button_width_second = widths;
    }
    
    func setThirdRowWidth(_ widths:[CGFloat])
    {
        row_button_width_third = widths;
    }
    
    func setFourthRowWidth(_ widths:[CGFloat])
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
