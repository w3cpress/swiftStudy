//
//  ViewController.swift
//  swift33
//  Swift33 - 使用UIWebView和UIToolbar制作一个浏览器
//  Created by Alan on 16/6/29.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/*
 使用网页控件（UIWebView）与工具栏控件（UIToolbar），我们可以自制一个小型的浏览器，其功能如下：
 1，输入网址，点击“Go”按钮加载网页
 2，加载过程中有进度条，同时可以点击停止按钮取消加载
 3，有页面刷新按钮
 4，有前进后退按钮
 */
import UIKit

class ViewController: UIViewController, UIWebViewDelegate,UITextFieldDelegate {
    
    
    var webview:UIWebView!;
    var txturl:UITextField!;
    var btngo:UIButton!;
    var loadIndicator:UIActivityIndicatorView!
    
    //进度条计时器
    var ptimer:NSTimer!
    //进度条控件
    var progBar:UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initView();
        
        self.webview.delegate = self;
        
        txturl.delegate = self
        
        //构建浏览器工具条
        setupBrowserToolbar()
        
        goClicked(btngo);
        
    }
    
    func initView(){
        webview = UIWebView();
        webview.frame = CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height - 88);
        webview.scalesPageToFit = true;
        
        txturl = UITextField();
        txturl.frame = CGRectMake(20, 71, 200, 30);
        txturl.borderStyle = UITextBorderStyle.RoundedRect;
        txturl.text = "http://h5app.jollychic.com/#/index";
        
        btngo = UIButton(type:.System);
        btngo.frame = CGRectMake(220, 71, self.view.frame.size.width - 200 - 40, 30);
        btngo.setTitle("确定", forState:UIControlState.Normal);

        btngo.addTarget(self,action:#selector(goClicked(_:)),forControlEvents:.TouchUpInside);
        
        loadIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 32, 32));
        loadIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray;
        loadIndicator.center = self.view.center;
       
        self.view.addSubview(webview);
        self.view.addSubview(txturl);
        self.view.addSubview(btngo);
        self.view.addSubview(loadIndicator);
        
    }
    
    func setupBrowserToolbar() {
        // 创建一个浏览器工具条，并设置它的大小和位置
        let browserToolbar =  UIToolbar(frame:CGRectMake(0, 20, self.view.frame.size.width, 44))
        
        // 将工具条添加到当前应用的界面中
        self.view.addSubview(browserToolbar)
        
        //创建图片工具条，但是不是直接使用文件名，而是用 NSData 方式初始化 UIImage
        let path = NSBundle.mainBundle().pathForResource("back", ofType:"png",inDirectory: "images")
        
        let urlStr = NSURL.fileURLWithPath(path!);
        let data = NSData(contentsOfURL:urlStr);
        let btnback =  UIBarButtonItem(image:UIImage(data: data!), style:.Plain, target:self,action:#selector(backClicked));
        //第一个分隔按钮
        let btngap1 =  UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil);
        // 创建前进按钮 UIBarButtonItem
        let btnforward = UIBarButtonItem(image:UIImage(named:"forward.png"), style:.Plain, target:self, action:#selector(forwardClicked));
        
        // 第二个分隔按钮，创建一个可伸缩的UIBarButtonItem
        let btngap2 =  UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil);
        
        // 创建重新加载按钮 UIBarButtonItem
        let btnreload = UIBarButtonItem(image:UIImage(named:"reload.png"), style:.Plain, target:self, action:#selector(reloadClicked));
        
        //第三个分隔按钮
        let btngap3 =  UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil);
        
        //创建加载停止按钮
        let btnstop = UIBarButtonItem(image:UIImage(named:"stop"), style:.Plain, target:self, action:#selector(stopClicked));
        
        //第四个分隔按钮
        let btngap4 =  UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil);
        
        //创建进度工具条
        progBar = UIProgressView(progressViewStyle:UIProgressViewStyle.Bar)
        
        // 设置UIProgressView的大小
        progBar.frame = CGRectMake(0 , 0 , 80, 20)
        
        // 设置该进度条的初始进度为0
        progBar.progress = 0
        
        // 创建使用 UIView 的自定义的 UIBarButtonItem
        let btnprog =  UIBarButtonItem(customView:progBar)
        
        // 为工具条设置工具按钮
        browserToolbar.setItems( [btnback,btngap1, btnforward,btngap2,
            btnreload,btngap3, btnstop,btngap4, btnprog ], animated:true)
        
        //创建计时器对象
        ptimer = NSTimer.scheduledTimerWithTimeInterval(0.2,target:self ,selector: #selector(loadProgress), userInfo:nil,repeats:true);
        ptimer.invalidate()
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool{
        txturl.resignFirstResponder()
        print("url Changed!")
        let url = txturl.text;
        loadUrl(url!)
        return true
    }
    /*
     在 UIWebView 加载指定 URL
     */
    func loadUrl(url:String){
        let urlobj = NSURL(string:url)
        
        let request = NSURLRequest(URL:urlobj!)
        
        webview.loadRequest(request);
    }
    
    func stopClicked(sender:UIBarButtonItem){
        webview.stopLoading()
    }
    
    func reloadClicked(sender:UIBarButtonItem){
        webview.reload()
    }
    
    func backClicked(sender:UIBarButtonItem){
        webview.goBack()
    }
    
    func forwardClicked(sender:UIBarButtonItem){
        webview.goForward()
    }
    
    func goClicked(sender:UIButton){
        //收起输入面板
        txturl.resignFirstResponder()
        let url = txturl.text;
        loadUrl(url!)
    }
    
    func webViewDidStartLoad(webView:UIWebView) {
        progBar.setProgress(0, animated:false);
        ptimer.fire();
        loadIndicator.startAnimating();
    }
    func webViewDidFinishLoad(webView:UIWebView) {
        loadIndicator.stopAnimating();
        progBar.setProgress(1, animated:true);
        ptimer.invalidate();
    }
    func loadProgress() {
        // 如果进度满了，停止计时器
        if(progBar.progress >= 1.0){
            // 停用计时器
            ptimer.invalidate();
        } else {
            // 改变进度条的进度值
            progBar.setProgress(progBar.progress + 0.02, animated:true);
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        let alertController = UIAlertController(title: "出错!", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

