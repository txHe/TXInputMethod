//
//  CustomButton.swift
//  iOS-ThirdParty-InputMethod
//
//  Created by zhhz on 16/7/23.
//  Copyright © 2016年 zhhz. All rights reserved.
//

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
        
        self.fillColor = UIColor.whiteColor();//初始化为白色
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.layer.cornerRadius = 6.0;
        self.clipsToBounds = true;
        self.layer.masksToBounds = true;
        self.multipleTouchEnabled = false
        self.exclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        self.addSubview(BackButtonView(frame: self.bounds))
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesEnded(touches, withEvent: event)
        for v in self.subviews
        {
            v.removeFromSuperview();
        }
    }
    
    func setFillcolor(color:UIColor)
    {
        self.fillColor = color;
    }
    
    func setTitle(title:String)
    {
        self.buttonTitle = title;
    }
    
    /*---------------------------自主绘制按键---------------------------*/
    override func drawRect(rect: CGRect)
    {
        let fontSize = UIFont.systemFontOfSize(18.0); //设置字体大小
        let fontColor = UIColor.blackColor(); //设置字体颜色
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
        CGContextSetFillColorWithColor(context, backgroundcolor.CGColor);
        
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignment.Center;
        let titleAttr:NSDictionary = [NSFontAttributeName:fontSize,NSForegroundColorAttributeName:fontColor,NSParagraphStyleAttributeName:paragraphStyle];
        let titleSize = self.buttonTitle.sizeWithAttributes(titleAttr as? [String : AnyObject]);
        
        let float_x_pos = (rect.size.width - titleSize.width)/2;
        let float_y_pos = (rect.size.height - titleSize.height)/2;
        let point_title = CGPoint(x: float_x_pos,y: float_y_pos);
        
        CGContextFillRect(context, rect);
        self.fillColor.setFill()
        roundedRect .fillWithBlendMode(CGBlendMode.Normal, alpha: 1)
        
        self.buttonTitle.drawAtPoint(point_title, withAttributes: titleAttr as? [String : AnyObject]);
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
        self.multipleTouchEnabled = false
        self.exclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        self.addSubview(BackButtonView(frame: self.bounds))
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesEnded(touches, withEvent: event)
        for v in self.subviews
        {
            v.removeFromSuperview();
        }
    }
    
    override func drawRect(rect: CGRect)
    {
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0)
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
        CGContextSetFillColorWithColor(context, backgroundcolor.CGColor);
        
        CGContextFillRect(context, rect)
        UIColor.lightGrayColor().setFill()
        
        roundedRect .fillWithBlendMode(CGBlendMode.Normal, alpha: 1)
        
        let size:CGSize = rect.size
        let p1:CGPoint = CGPointMake(size.width * 1/2 - 15, size.height * 1/2)
        let p2:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 - 10)
        let p3:CGPoint = CGPointMake(size.width * 1/2 + 15, size.height * 1/2 - 10)
        let p4:CGPoint = CGPointMake(size.width * 1/2 + 15, size.height * 1/2 + 10)
        let p5:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 + 10)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        
        CGContextMoveToPoint(context, p1.x, p1.y)
        CGContextAddLineToPoint(context, p2.x, p2.y)
        CGContextAddLineToPoint(context, p3.x, p3.y)
        CGContextAddLineToPoint(context, p4.x, p4.y)
        CGContextAddLineToPoint(context, p5.x, p5.y)
        CGContextClosePath(context)
        CGContextFillPath(context)
        
        let p6:CGPoint = CGPointMake(size.width * 1/2 + 10, size.height * 1/2  - 5)
        let p7:CGPoint = CGPointMake(size.width * 1/2 , size.height * 1/2  + 5)
        CGContextMoveToPoint(context, p6.x, p6.y)
        CGContextAddLineToPoint(context, p7.x, p7.y)
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        CGContextStrokePath(context)
        
        let p8:CGPoint = CGPointMake(size.width * 1/2 + 10, size.height * 1/2  + 5);
        let p9:CGPoint = CGPointMake(size.width * 1/2 , size.height * 1/2  - 5);
        CGContextMoveToPoint(context, p8.x, p8.y);
        CGContextAddLineToPoint(context, p9.x, p9.y);
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor);
        CGContextStrokePath(context);
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
        self.multipleTouchEnabled = false;
        self.exclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func drawRect(rect: CGRect)
    {
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
        CGContextSetFillColorWithColor(context, backgroundcolor.CGColor);
        
        CGContextFillRect(context, rect);
        UIColor.lightGrayColor().setFill();
        roundedRect .fillWithBlendMode(CGBlendMode.Normal, alpha: 1);
        
        let size:CGSize = rect.size;
        let r:CGFloat =  CGFloat(12); //(size.height - 12) / 2
        let p1:CGPoint = CGPointMake(rect.origin.x + size.width / 2, rect.origin.y + size.height / 2 );//圆心
        let p2:CGPoint  = CGPointMake(p1.x, p1.y - r * sqrt(2));
        let p3:CGPoint = CGPointMake(p1.x, p1.y + r * sqrt(2));
        let p4:CGPoint = CGPointMake(p1.x - r*3/4, p1.y);
        let p5:CGPoint = CGPointMake(p1.x + r*3/4, p1.y);
        
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor);//设置画笔颜色
        CGContextSetLineWidth(context, 1.0);//设置线条粗细
        
        //顺时针画圆
        CGContextAddArc(context, p1.x, p1.y, r, 0, CGFloat(M_PI * 2), 0);
        
        CGContextStrokePath(context);
        
        //画上方的弧线
        CGContextAddArc(context,p2.x,p2.y,r , CGFloat(M_PI/4), CGFloat(M_PI*3/4),0);
        CGContextStrokePath(context);
        //画下方的弧线
        CGContextAddArc(context,p3.x,p3.y,r , -CGFloat(M_PI*3/4), -CGFloat(M_PI/4),0);
        CGContextStrokePath(context);
        //画右方的弧线
        CGContextAddArc(context,p4.x,p4.y,r * 5 / 4, -atan(4/3), atan(4/3),0);
        CGContextStrokePath(context);
        //画左方的弧线
        CGContextAddArc(context,p5.x,p5.y,r * 5 / 4, CGFloat(M_PI - atan(4/3)), CGFloat(M_PI + atan(4/3)),0);
        CGContextStrokePath(context);
        //画从上到下的直线
        CGContextMoveToPoint(context,p1.x,p1.y - r);
        CGContextAddLineToPoint(context, p1.x, p1.y + r);
        CGContextStrokePath(context);
        //画从左到右的直线
        CGContextMoveToPoint(context,p1.x - r ,p1.y);
        CGContextAddLineToPoint(context, p1.x + r, p1.y);
        CGContextStrokePath(context);
        
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
        self.multipleTouchEnabled = false;
        self.exclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func drawRect(rect: CGRect)
    {
        if(shiftFlag == SHIFT_TYPE.SHIFT_LOWERALWAYS)
        {
            let context:CGContextRef = UIGraphicsGetCurrentContext()!;
            let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
            let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
            CGContextSetFillColorWithColor(context, backgroundcolor.CGColor);
            
            CGContextFillRect(context, rect);
            UIColor.lightGrayColor().setFill();
            
            roundedRect .fillWithBlendMode(CGBlendMode.Normal, alpha: 1);
            
            let size:CGSize = rect.size
            
            let p1:CGPoint = CGPointMake(size.width * 1/2 - 10, size.height * 1/2)
            let p2:CGPoint = CGPointMake(size.width * 1/2, size.height * 1/2 - 10)
            let p3:CGPoint = CGPointMake(size.width * 1/2 + 10 , size.height * 1/2)
            let p4:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2)
            let p5:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2 + 10)
            let p6:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 + 10)
            let p7:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2)
            
            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor);
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            
            CGContextSetLineWidth(context, 2.0);
            
            CGContextMoveToPoint(context, p1.x, p1.y);
            CGContextAddLineToPoint(context, p2.x, p2.y);
            CGContextAddLineToPoint(context, p3.x, p3.y);
            CGContextAddLineToPoint(context, p4.x, p4.y);
            CGContextAddLineToPoint(context, p5.x, p5.y);
            CGContextAddLineToPoint(context, p6.x, p6.y);
            CGContextAddLineToPoint(context, p7.x, p7.y);
            CGContextClosePath(context);
            CGContextFillPath(context)
            
            CGContextStrokePath(context);
        }
        else if(shiftFlag == SHIFT_TYPE.SHIFT_UPPERONCE)
        {
            let tapFillColor:UIColor = UIColor.blackColor();
            
            let context:CGContextRef = UIGraphicsGetCurrentContext()!
            let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
            let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
            CGContextSetFillColorWithColor(context, backgroundcolor.CGColor);
            
            CGContextFillRect(context, rect);
            UIColor.lightGrayColor().setFill();
            
            roundedRect.fillWithBlendMode(CGBlendMode.Normal, alpha: 1)
            
            let size:CGSize = rect.size
            
            let p1:CGPoint = CGPointMake(size.width * 1/2 - 10, size.height * 1/2)
            let p2:CGPoint = CGPointMake(size.width * 1/2, size.height * 1/2 - 10)
            let p3:CGPoint = CGPointMake(size.width * 1/2 + 10 , size.height * 1/2)
            let p4:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2)
            let p5:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2 + 10)
            let p6:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 + 10)
            let p7:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2)
            
            //下划线
            //var p8:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2 + 13)
            //var p9:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 + 13)
            
            CGContextSetStrokeColorWithColor(context, tapFillColor.CGColor);
            CGContextSetFillColorWithColor(context, tapFillColor.CGColor)
            CGContextSetLineWidth(context, 2.0);
            
            CGContextMoveToPoint(context, p1.x, p1.y);
            CGContextAddLineToPoint(context, p2.x, p2.y);
            CGContextAddLineToPoint(context, p3.x, p3.y);
            CGContextAddLineToPoint(context, p4.x, p4.y);
            CGContextAddLineToPoint(context, p5.x, p5.y);
            CGContextAddLineToPoint(context, p6.x, p6.y);
            CGContextAddLineToPoint(context, p7.x, p7.y);
            
            CGContextClosePath(context);
            CGContextFillPath(context)
            
            CGContextStrokePath(context);
            
        }
        else if(shiftFlag == SHIFT_TYPE.SHIFT_UPPERALWAYS)
        {
            let tapFillColor:UIColor = UIColor.blackColor();
            let context:CGContextRef = UIGraphicsGetCurrentContext()!;
            let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0);
            let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0);
            CGContextSetFillColorWithColor(context, backgroundcolor.CGColor);
            
            CGContextFillRect(context, rect);
            UIColor.lightGrayColor().setFill();
            roundedRect.fillWithBlendMode(CGBlendMode.Normal, alpha: 1);
            
            let size:CGSize = rect.size
            
            let p1:CGPoint = CGPointMake(size.width * 1/2 - 10, size.height * 1/2)
            let p2:CGPoint = CGPointMake(size.width * 1/2, size.height * 1/2 - 10)
            let p3:CGPoint = CGPointMake(size.width * 1/2 + 10 , size.height * 1/2)
            let p4:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2)
            let p5:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2 + 10)
            let p6:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 + 10)
            let p7:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2)
            
            //下划线
            let p8:CGPoint = CGPointMake(size.width * 1/2 + 5, size.height * 1/2 + 13)
            let p9:CGPoint = CGPointMake(size.width * 1/2 - 5, size.height * 1/2 + 13)
            
            CGContextSetStrokeColorWithColor(context, tapFillColor.CGColor);
            CGContextSetFillColorWithColor(context, tapFillColor.CGColor)
            CGContextSetLineWidth(context, 2.0);
            
            CGContextMoveToPoint(context, p1.x, p1.y);
            CGContextAddLineToPoint(context, p2.x, p2.y);
            CGContextAddLineToPoint(context, p3.x, p3.y);
            CGContextAddLineToPoint(context, p4.x, p4.y);
            CGContextAddLineToPoint(context, p5.x, p5.y);
            CGContextAddLineToPoint(context, p6.x, p6.y);
            CGContextAddLineToPoint(context, p7.x, p7.y);
            
            CGContextClosePath(context);
            CGContextFillPath(context)
            
            CGContextStrokePath(context);
            
            CGContextMoveToPoint(context, p8.x, p8.y)
            CGContextAddLineToPoint(context, p9.x, p9.y)
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, tapFillColor.CGColor)
            CGContextStrokePath(context)
            
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
        self.multipleTouchEnabled = false
        self.exclusiveTouch = true;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func drawRect(rect: CGRect)
    {
        let backgroundcolor = UIColor(red: 209/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1.0)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        let roundedRect:UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0)
        
        CGContextSetFillColorWithColor(context, backgroundcolor.CGColor)
        CGContextFillRect(context, rect)
        backgroundcolor.setFill();
        roundedRect.fillWithBlendMode(CGBlendMode.SoftLight, alpha: 0.5)
    }
}

