//
//  DetailViewController.swift
//  swift41
//
//  Created by Alan on 16/7/28.
//  Copyright © 2016年 jollycorp. All rights reserved.
//
import UIKit

class DetailViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景色
        self.view.backgroundColor = UIColor.whiteColor()
        //按title加载控件
        loadControl(self.title!)
        //设置代码和控件展示切换按钮，增加到导航条的右侧
        //这里采用了navigationController不能增加navigationItem
        let btn = UIBarButtonItem(title:"代码", style: .Plain, target: self, action: #selector(btnCodeClicked))
        self.navigationItem.rightBarButtonItem = btn;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //构建控件并加载页面
    func loadControl(ctrl:String){
        switch (ctrl) {
        case "UILabel":
            let label = UILabel(frame: self.view.bounds)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(36)
            label.text = "Hello, Alan"
            self.view.addSubview(label);
            
        case "UIButton":
            let button = UIButton(frame: CGRectMake(110,120,100,60))
            button.backgroundColor = UIColor.blueColor()
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
            button.setTitle("点击我", forState: .Normal)
            button.addTarget(self, action: #selector(buttonClicked), forControlEvents: UIControlEvents.TouchUpInside)
                self.view.addSubview(button)
            
        case "UIImageView":
            let image = UIImage(named: "ball.png")
            let imageView = UIImageView(frame: CGRectMake((CGRectGetWidth(self.view.bounds) - image!.size.width) / 2.0, 120.0,image!.size.width, image!.size.height))
            imageView.image = image!
            self.view.addSubview(imageView)
            
        case "UISlider":
            let slider = UISlider(frame:CGRectMake(60.0, 120.0, 200.0, 30.0))
            self.view.addSubview(slider)
            
        case "UIWebView":
            let webView = UIWebView(frame:self.view.bounds)
            let url = NSURL(string: "http://m.jollychic.com")
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
            self.view.addSubview(webView)
            
        default:
            print("control name: \(ctrl)");
        }
    }
    //显示控件的代码
    func loadCode(ctrl:String){
        print(ctrl)
        var str:String
        switch (ctrl) {
        case "UILabel":
            str = "let label = UILabel(frame: self.view.bounds)\n"
            str += "label.backgroundColor = UIColor.clearColor()\n"
            str += "label.textAlignment = NSTextAlignment.Center\n"
            str += "label.font = UIFont.systemFontOfSize(36)\n"
            str += "label.text = \"Hello, Ucai\"\n"
            str += "self.view.addSubview(label)"
        case "UIButton":
            str = "UIButton"
        case "UISlider":
            str = "let slider = UISlider(frame:CGRectMake(60.0, 120.0, 200.0, 30.0))\n"
            str += "self.view.addSubview(slider)"
        default:
            str = "other ctrl"
        }
        
        //在导航条下方位置显示源代码
        let txt = UITextView(frame: CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 60))
        txt.text = str
        self.view.addSubview(txt)
    }
    
    //清空所有子视图
    func clearViews(){
        for v in self.view.subviews as [UIView] {
            v.removeFromSuperview()
        }
    }
    
    func buttonClicked(sender:AnyObject) {
        print("you clicked button")
    }
    
    func btnCodeClicked (sender:AnyObject){
        print("title: \(self.title)")
        clearViews();
        if self.navigationItem.rightBarButtonItem!.title == "代码" {
            loadCode(self.title!)
            self.navigationItem.rightBarButtonItem!.title = "效果"
        }
        else {
            self.navigationItem.rightBarButtonItem!.title = "代码"
            loadControl(self.title!)
        }
    }
}