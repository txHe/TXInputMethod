# TXInputMethod
一款iOS第三方输入法，供分享、学习和拓展之用。

<h2>iOS第三方输入法实例-Swift版</h2>

<h3>1、写这个项目的目的</h3>
输入法开发在众多App中较为小众，因为现实中，不仅仅是输入个字母、数字、字符或者表情就行的。

输入汉字，要想做到基本的需求，你得有**联想**、**模糊查询**、**热词搜索**、**智能纠错**、**自定义词库**等等，还不包括语音输入，手写输入，拍照输入……。

所以要想做成一款优质的输入法，需要一定的技术积累，包括自然语言处理的经验等等，也就不奇怪，在这方面，搜狗、百度和腾讯都很厉害了，毕竟都有很强的搜索班底。

但是对于个人开发者而言，其实也可以试试的，因为相应的技术已经不少已经成熟，很多可以拿过来直接用，还有就是要让自己的App有特点，有吸引人的地方，比如简便易用，专注某项输入的开发（表情输入法），或者自设计某个独特的功能点。

现阶段呢，关于输入法的文档非常少，除了几篇概括性、纲领性的文章，也就没了其他详解文章。这也是我写这个项目的主要目的，希望有志于开发输入法的开发者在摸索过程中，在爬坑过程中，能少走很多弯路。

<h3>2、添加输入法</h3>
这一步其实各大教程都有的，为了尽可能详细，就截几张图吧：

创建一个singleview Application，这个就是输入法的设置界面。

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/1.1.png)

添加一个target，即app extension（扩展），选择输入法扩展

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/1.2.png)

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/1.3.png)

大概的目录结构如下

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/1.4.png)

//主要的viewcontorller：keyboardviewcontroller，在这里实现输入法的界面、输入事件等等

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/1.5.png)


<h3>3、输入法展示，包括一些功能点</h3>
首先看个大概的输入法界面吧。

总体来讲，还是挺美观的，哈哈，这是模仿的系统的字母键盘界面，包括**字母的输入**、**大小写切换**、**长按快速删除**、**地球键切换**等等。

这里面的所有按键都是自己绘制的，包括字母按键、shift(大小写切换键)、delete(删除键)和输入法切换键(地球键)。

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/mainScreen.png)

<h4>3.1字母输入</h4>
动态图如下：

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/001.gif)

<h4>3.2大小写切换></h4>
单击shift这个按键，会允许当前首字母大写，并重新绘制界面。

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/002.gif)

双击shift按键，会开启全部字母大写设置，并重新绘制界面

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/003.gif)

<h4>3.3删除功能</h4>
短按delete按键，每次删除一个字符

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/004.gif)

长按delete按键，加速删除，**要注意下，你可能感觉观看效果删除缓慢，实际效果不是这样的，但是我转 gif 时，不知怎的就是慢，暂时就这样**

![image](https://github.com/txHe/TXInputMethod/blob/master/readImages/005.gif)

<h3>4、功能点解析</h4>

<h4>4.1 界面绘制和布局</h4>
刚开始开发输入法，开发者也许觉得，这不就是一个个button么，直接用button就行了，但是后续会遇到很多麻烦事情。比如滑动输入、键盘反应不灵敏、长按效果不加等等。

为了解决这些问题，所以本项目都是用自定义View来实现button的效果，自己绘制传入的字符。代码如下：

为了实现按键的效果，重载touchesBegan，touchesEnd这两个方法，然后在其中添加backView（背景图，暗一点),即可实现按键效果。</br>

<pre><code>
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

</code></pre>

再展示下地球键的绘制吧，这个比较复杂点，因为很多开发者可能没接触过，挺有意思的，但是呢，要想方便，直接贴图就是了。

<pre><code>
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
</code></pre>


**界面布局**

这么多的按键，如何快速准确，有效的布局呢？

使用autolayout,通过写constraint来设置各按键之间的依赖关系，达到快速简便布局的效果。

Masonry的Swift版本是SnapKit，但是我本人觉得不太习惯。所以就用的系统的自己的布局。也挺方便的。

大体思路呢，是讲输入法界面分成四行单独布局，然后行与行之间再布局。就展示下第一行的布局和行与行之间布局逻辑，就是"qwertyuiop"这些字母布局。其他的代码里都有


<pre><code>
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
</code><pre>
  
<h4>4.2按键事件响应</h4> 

因为使用了所有的按键都是view定制的，所以按键方法放在touchesBegan和touchesEnd中实现比较好，有以下几个好处

**1.滑动输入，后续可以添加各按键之间的滑动输入，以加快输入速度**

**2.长按删除，其实在button界面里也可以添加手势，不过试用过效果不好。主要在反应不够灵敏，长按一定时间后自动间断。**

**3.按键反应，通过直接触屏，反应更快，体验更好**

**4.界面可定制化更高，绘图，添加图片，按键效果，都可以自定制。非常方便**

**5.UIButton更占系统的资源，使用view自定制的按键，绘制效率更高。**

<pre><code>
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
{
    super.touchesBegan(touches, withEvent: event)
    //手指触屏
}
override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
{
    super.touchesEnded(touches, withEvent: event)
    //手指离屏
}
</code><pre>
    
具体可观看代码，github地址在后面。

<h4>4.3大小写切换</h4>
定义一个枚举类型，标注当前的大小写状态

<pre><code>
//定义枚举类型标注shift按键所单击的次数
enum SHIFT_TYPE
{
    case SHIFT_LOWERALWAYS;//全小写
    case SHIFT_UPPERONCE;//首字母大写
    case SHIFT_UPPERALWAYS;//全大写
}
</code></pre>

事件：

<pre><code>
/*---------------------------单击shift键---------------------------*/
func singleShift(){
   if(shiftFlag == SHIFT_TYPE.SHIFT_LOWERALWAYS) //如果原来是纯小写，单机后转换当前字母大写
   {
       shiftFlag = SHIFT_TYPE.SHIFT_UPPERONCE;
       self.txAlphabetPlaneView.buttonShift.setNeedsDisplay();
   }
   else if(shiftFlag == SHIFT_TYPE.SHIFT_UPPERONCE) //如果是当前字母大写，则转换成纯小写
   {
       shiftFlag = SHIFT_TYPE.SHIFT_LOWERALWAYS;
       self.txAlphabetPlaneView.buttonShift.setNeedsDisplay()
   }
   else if(shiftFlag == SHIFT_TYPE.SHIFT_UPPERALWAYS)
   {
       shiftFlag = SHIFT_TYPE.SHIFT_LOWERALWAYS;
       self.txAlphabetPlaneView.buttonShift.setNeedsDisplay();
   }
   self.upgradeAlphabetKeyboard();//更新下界面上的字母
}
/*---------------------------双击shift键---------------------------*/
func doubleShift()
{
   if(shiftFlag != SHIFT_TYPE.SHIFT_UPPERALWAYS)
   {
       shiftFlag = SHIFT_TYPE.SHIFT_UPPERALWAYS;
       self.txAlphabetPlaneView.buttonShift.setNeedsDisplay();
   }
   self.upgradeAlphabetKeyboard();
}
</code></pre>

<h4>4.4删除按键</h4>

主要实现的就是长按删除的功能。通过设定**计时器**来实现

//方法是在touesBegan中触屏delete按键时触发

<pre><code>
deleteTime = touch.timestamp; //记录下触屏的当前时间

//延迟0.6s后，进行长按的方法调用
self.performSelector(#selector(KeyboardViewController.longDelete), withObject: nil, afterDelay: 0.6);
</code></pre>

//长按方法

<pre><code>
/*---------------------------长按加速删除---------------------------*/
func longDelete()
{
    timer = NSTimer(timeInterval: 0.1, target: self, selector: #selector(UIKeyInput.deleteBackward), userInfo: nil, repeats: true);
    NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode);
}
</code></pre>

//touchesEnd中的方法，间隔小于0.6s,则只执行短按键。手指离屏了，判断下timer是否还开着，开着就关闭掉。

<pre><code>
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
</code></pre>
    
<h3>5.第一阶段总结</h3>

为什么是第一阶段总结呢，因为才做了个初步的工作，实现了几个基础的功能，后续还会更多添加和优化。

其实，实现起来，就是麻烦了点，难度并不大，不过也算提供一些参考吧，如果能点个赞(star)，就更好了，\(^o^)/~。

**我的博客地址：http://www.hetianxiong.com/**
