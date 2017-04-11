//
//  CustomButton.swift
//  iOS-ThirdParty-InputMethod
//
//  Created by txHe on 16/7/23.
//  Copyright © 2016年 txHe. All rights reserved.
//

/*
 *
 * 亟待完善：提供各按键的背景颜色，整体键盘的背景颜色，字体颜色，字体大小，按键背景颜色等一些自定义“皮肤”组件
 *
 */

/*
 *
 * 该文件为自定义组件类，主要包含如下几类组件：
 * 1.NormalButton:普通按键自绘制，包含数字、字母等字符串绘制的视图
 * 2.DeleteButton:删除按键自绘制
 * 3.EarthButton:地球键自绘制
 * 4.ShiftButton:大小写按键自绘制
 * 5.BackButtonView:背景按键，即触摸以上按键时，按键效果
 *
 */

import UIKit
import Foundation


/*---------------------------普通按键的自定义View---------------------------*/
class NormalButton: UIView
{
    var buttonTitle:String!; //按键上的title
    var fillColor:UIColor! //填充背景色
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.fillColor = UIColor.white;//初始化为白色
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.layer.cornerRadius = 6.0;
        self.clipsToBounds = true;
        self.layer.masksToBounds = true;
        self.isMultipleTouchEnabled = false
        self.isExclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        self.addSubview(BackButtonView(frame: self.bounds))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        for v in self.subviews
        {
            v.removeFromSuperview();
        }
    }
    
    func setFillcolor(_ color:UIColor)
    {
        self.fillColor = color;
    }
    
    func setTitle(_ title:String)
    {
        self.buttonTitle = title;
    }
    
    /*---------------------------自主绘制按键---------------------------*/
    override func draw(_ rect: CGRect)
    {
        let fontSize = UIFont.systemFont(ofSize: 18.0); //设置字体大小
        let fontColor = UIColor.black; //设置字体颜色
        let context:CGContext = UIGraphicsGetCurrentContext()!
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
        context.setFillColor(backgroundcolor.cgColor);
        
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail;
        paragraphStyle.alignment = NSTextAlignment.center;
        let titleAttr:NSDictionary = [NSFontAttributeName:fontSize,NSForegroundColorAttributeName:fontColor,NSParagraphStyleAttributeName:paragraphStyle];
        let titleSize = self.buttonTitle.size(attributes: titleAttr as? [String : AnyObject]);
        
        let float_x_pos = (rect.size.width - titleSize.width)/2;
        let float_y_pos = (rect.size.height - titleSize.height)/2;
        let point_title = CGPoint(x: float_x_pos,y: float_y_pos);
        
        context.fill(rect);
        self.fillColor.setFill()
        roundedRect .fill(with: CGBlendMode.normal, alpha: 1)
        
        self.buttonTitle.draw(at: point_title, withAttributes: titleAttr as? [String : AnyObject]);
    }
}

/*---------------------------删除按键自绘制---------------------------*/
class DeleteButton:UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.layer.cornerRadius = 6.0;
        self.isMultipleTouchEnabled = false
        self.isExclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        self.addSubview(BackButtonView(frame: self.bounds))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        for v in self.subviews
        {
            v.removeFromSuperview();
        }
    }
    
    override func draw(_ rect: CGRect)
    {
        let context:CGContext = UIGraphicsGetCurrentContext()!
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0)
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
        context.setFillColor(backgroundcolor.cgColor);
        
        context.fill(rect)
        UIColor.lightGray.setFill()
        
        roundedRect .fill(with: CGBlendMode.normal, alpha: 1)
        
        let size:CGSize = rect.size
        let p1:CGPoint = CGPoint(x: size.width * 1/2 - 15, y: size.height * 1/2)
        let p2:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2 - 10)
        let p3:CGPoint = CGPoint(x: size.width * 1/2 + 15, y: size.height * 1/2 - 10)
        let p4:CGPoint = CGPoint(x: size.width * 1/2 + 15, y: size.height * 1/2 + 10)
        let p5:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2 + 10)
        context.setFillColor(UIColor.white.cgColor)
        
        context.move(to: CGPoint(x: p1.x, y: p1.y))
        context.addLine(to: CGPoint(x: p2.x, y: p2.y))
        context.addLine(to: CGPoint(x: p3.x, y: p3.y))
        context.addLine(to: CGPoint(x: p4.x, y: p4.y))
        context.addLine(to: CGPoint(x: p5.x, y: p5.y))
        context.closePath()
        context.fillPath()
        
        let p6:CGPoint = CGPoint(x: size.width * 1/2 + 10, y: size.height * 1/2  - 5)
        let p7:CGPoint = CGPoint(x: size.width * 1/2 , y: size.height * 1/2  + 5)
        context.move(to: CGPoint(x: p6.x, y: p6.y))
        context.addLine(to: CGPoint(x: p7.x, y: p7.y))
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.strokePath()
        
        let p8:CGPoint = CGPoint(x: size.width * 1/2 + 10, y: size.height * 1/2  + 5);
        let p9:CGPoint = CGPoint(x: size.width * 1/2 , y: size.height * 1/2  - 5);
        context.move(to: CGPoint(x: p8.x, y: p8.y));
        context.addLine(to: CGPoint(x: p9.x, y: p9.y));
        context.setLineWidth(2.0);
        context.setStrokeColor(UIColor.lightGray.cgColor);
        context.strokePath();
    }
    
}

/*---------------------------地球按键(输入法切换)自绘制---------------------------*/
class EarthButton:UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.layer.cornerRadius = 6.0;
        self.isMultipleTouchEnabled = false;
        self.isExclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func draw(_ rect: CGRect)
    {
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
        context.setFillColor(backgroundcolor.cgColor);
        
        context.fill(rect);
        UIColor.lightGray.setFill();
        roundedRect .fill(with: CGBlendMode.normal, alpha: 1);
        
        let size:CGSize = rect.size;
        let r:CGFloat =  CGFloat(12); //(size.height - 12) / 2
        let p1:CGPoint = CGPoint(x: rect.origin.x + size.width / 2, y: rect.origin.y + size.height / 2 );//圆心
        let p2:CGPoint  = CGPoint(x: p1.x, y: p1.y - r * sqrt(2));
        let p3:CGPoint = CGPoint(x: p1.x, y: p1.y + r * sqrt(2));
        let p4:CGPoint = CGPoint(x: p1.x - r*3/4, y: p1.y);
        let p5:CGPoint = CGPoint(x: p1.x + r*3/4, y: p1.y);
        
        context.setStrokeColor(UIColor.white.cgColor);//设置画笔颜色
        context.setLineWidth(1.0);//设置线条粗细
        
        //顺时针画圆
        context.addArc(center: p1, radius: r, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: false)
        
        context.strokePath();
        
        //画上方的弧线
        context.addArc(center: p2, radius: r, startAngle: CGFloat(Double.pi/4), endAngle: CGFloat(Double.pi * 3 / 4), clockwise: false)
        
        context.strokePath();
        
        //画下方的弧线
        context.addArc(center: p3, radius: r, startAngle: -CGFloat(Double.pi*3/4), endAngle: -CGFloat(Double.pi/4), clockwise: false)
        
        context.strokePath();
        
        //画右方的弧线
        context.addArc(center: p4, radius: r*5/4, startAngle: -atan(4/3), endAngle: atan(4/3), clockwise: false)
        context.strokePath();
        
        //画左方的弧线
        context.addArc(center: p5, radius: r*5/4, startAngle: CGFloat(Double.pi - atan(4/3)), endAngle: CGFloat(Double.pi + atan(4/3)), clockwise: false)
        context.strokePath();
        
        //画从上到下的直线
        context.move(to: CGPoint(x: p1.x, y: p1.y - r));
        context.addLine(to: CGPoint(x: p1.x, y: p1.y + r));
        context.strokePath();
        //画从左到右的直线
        context.move(to: CGPoint(x: p1.x - r, y: p1.y));
        context.addLine(to: CGPoint(x: p1.x + r, y: p1.y));
        context.strokePath();
        
    }
    
}

/*---------------------------大小写按键自绘制---------------------------*/
class ShiftButton: UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.clipsToBounds = true;
        self.layer.masksToBounds = true;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.layer.cornerRadius = 6.0;
        self.isMultipleTouchEnabled = false;
        self.isExclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func draw(_ rect: CGRect)
    {
        if(shiftFlag == SHIFT_TYPE.shift_LOWERALWAYS)//当前键盘全小写
        {
            let context:CGContext = UIGraphicsGetCurrentContext()!;
            let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
            let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
            context.setFillColor(backgroundcolor.cgColor);
            
            context.fill(rect);
            UIColor.lightGray.setFill();
            
            roundedRect .fill(with: CGBlendMode.normal, alpha: 1);
            
            let size:CGSize = rect.size
            
            let p1:CGPoint = CGPoint(x: size.width * 1/2 - 10, y: size.height * 1/2)
            let p2:CGPoint = CGPoint(x: size.width * 1/2, y: size.height * 1/2 - 10)
            let p3:CGPoint = CGPoint(x: size.width * 1/2 + 10 , y: size.height * 1/2)
            let p4:CGPoint = CGPoint(x: size.width * 1/2 + 5, y: size.height * 1/2)
            let p5:CGPoint = CGPoint(x: size.width * 1/2 + 5, y: size.height * 1/2 + 10)
            let p6:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2 + 10)
            let p7:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2)
            
            context.setStrokeColor(UIColor.white.cgColor);
            context.setFillColor(UIColor.white.cgColor)
            
            context.setLineWidth(2.0);
            
            context.move(to: CGPoint(x: p1.x, y: p1.y));
            context.addLine(to: CGPoint(x: p2.x, y: p2.y));
            context.addLine(to: CGPoint(x: p3.x, y: p3.y));
            context.addLine(to: CGPoint(x: p4.x, y: p4.y));
            context.addLine(to: CGPoint(x: p5.x, y: p5.y));
            context.addLine(to: CGPoint(x: p6.x, y: p6.y));
            context.addLine(to: CGPoint(x: p7.x, y: p7.y));
            context.closePath();
            context.fillPath()
            
            context.strokePath();
        }
        else if(shiftFlag == SHIFT_TYPE.shift_UPPERONCE)//当前键盘首字母大写一次
        {
            let tapFillColor:UIColor = UIColor.black;
            
            let context:CGContext = UIGraphicsGetCurrentContext()!
            let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
            let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
            context.setFillColor(backgroundcolor.cgColor);
            
            context.fill(rect);
            UIColor.lightGray.setFill();
            
            roundedRect.fill(with: CGBlendMode.normal, alpha: 1)
            
            let size:CGSize = rect.size
            
            let p1:CGPoint = CGPoint(x: size.width * 1/2 - 10, y: size.height * 1/2)
            let p2:CGPoint = CGPoint(x: size.width * 1/2, y: size.height * 1/2 - 10)
            let p3:CGPoint = CGPoint(x: size.width * 1/2 + 10 , y: size.height * 1/2)
            let p4:CGPoint = CGPoint(x: size.width * 1/2 + 5, y: size.height * 1/2)
            let p5:CGPoint = CGPoint(x: size.width * 1/2 + 5, y: size.height * 1/2 + 10)
            let p6:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2 + 10)
            let p7:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2)
            
            //下划线
            //var p8:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2 + 13)
            //var p9:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 + 13)
            
            context.setStrokeColor(tapFillColor.cgColor);
            context.setFillColor(tapFillColor.cgColor)
            context.setLineWidth(2.0);
            
            context.move(to: CGPoint(x: p1.x, y: p1.y));
            context.addLine(to: CGPoint(x: p2.x, y: p2.y));
            context.addLine(to: CGPoint(x: p3.x, y: p3.y));
            context.addLine(to: CGPoint(x: p4.x, y: p4.y));
            context.addLine(to: CGPoint(x: p5.x, y: p5.y));
            context.addLine(to: CGPoint(x: p6.x, y: p6.y));
            context.addLine(to: CGPoint(x: p7.x, y: p7.y));
            
            context.closePath();
            context.fillPath()
            
            context.strokePath();
            
        }
        else if(shiftFlag == SHIFT_TYPE.shift_UPPERALWAYS)//当前键盘全大写
        {
            let tapFillColor:UIColor = UIColor.black;
            let context:CGContext = UIGraphicsGetCurrentContext()!;
            let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
            let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
            context.setFillColor(backgroundcolor.cgColor);
            
            context.fill(rect);
            UIColor.lightGray.setFill();
            roundedRect.fill(with: CGBlendMode.normal, alpha: 1);
            
            let size:CGSize = rect.size
            
            let p1:CGPoint = CGPoint(x: size.width * 1/2 - 10, y: size.height * 1/2)
            let p2:CGPoint = CGPoint(x: size.width * 1/2, y: size.height * 1/2 - 10)
            let p3:CGPoint = CGPoint(x: size.width * 1/2 + 10 , y: size.height * 1/2)
            let p4:CGPoint = CGPoint(x: size.width * 1/2 + 5, y: size.height * 1/2)
            let p5:CGPoint = CGPoint(x: size.width * 1/2 + 5, y: size.height * 1/2 + 10)
            let p6:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2 + 10)
            let p7:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2)
            
            //下划线
            let p8:CGPoint = CGPoint(x: size.width * 1/2 + 5, y: size.height * 1/2 + 13)
            let p9:CGPoint = CGPoint(x: size.width * 1/2 - 5, y: size.height * 1/2 + 13)
            
            context.setStrokeColor(tapFillColor.cgColor);
            context.setFillColor(tapFillColor.cgColor)
            context.setLineWidth(2.0);
            
            context.move(to: CGPoint(x: p1.x, y: p1.y));
            context.addLine(to: CGPoint(x: p2.x, y: p2.y));
            context.addLine(to: CGPoint(x: p3.x, y: p3.y));
            context.addLine(to: CGPoint(x: p4.x, y: p4.y));
            context.addLine(to: CGPoint(x: p5.x, y: p5.y));
            context.addLine(to: CGPoint(x: p6.x, y: p6.y));
            context.addLine(to: CGPoint(x: p7.x, y: p7.y));
            
            context.closePath();
            context.fillPath()
            
            context.strokePath();
            
            context.move(to: CGPoint(x: p8.x, y: p8.y))
            context.addLine(to: CGPoint(x: p9.x, y: p9.y))
            context.setLineWidth(2.0)
            context.setStrokeColor(tapFillColor.cgColor)
            context.strokePath()
            
        }
    }
}


/*---------------------------字母和数字按键的按键背景---------------------------*/
class BackButtonView: UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.layer.cornerRadius = 6.0;
        self.alpha = 0.35;
        self.isMultipleTouchEnabled = false
        self.isExclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func draw(_ rect: CGRect)
    {
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0)
        
        context.setFillColor(backgroundcolor.cgColor)
        context.fill(rect)
        backgroundcolor.setFill();
        roundedRect.fill(with: CGBlendMode.softLight, alpha: 0.5)
    }
}

