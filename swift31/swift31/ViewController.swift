//
//  ViewController.swift
//  swift31
//  Swift31 - 网页控件（UIWebView）加载本地数据，文件
//  Created by Alan on 16/6/27.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/*
 使用UIWebView加载本地数据或资源有如下三种方式：
 1.使用 loadHTMLString 方法加载HTML内容
 2.使用 loadRequest 方法加载本地资源（也可用于加载服务器资源）
 3.先将内容保存成 NSData 数据，再使用 loadData 方法加载
 */
import UIKit

class ViewController: UIViewController {
    
    var webview:UIWebView!;
    var loadtype:UISegmentedControl!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let items = ["显示html","显示pdf","loadData 显示pdf"] as [AnyObject]
        loadtype = UISegmentedControl(items:items)
        loadtype.frame = CGRectMake(20, 50, self.view.frame.size.width - 40, 30)
        loadtype.selectedSegmentIndex = 0 //默认选中第一项
        loadtype.addTarget(self, action: #selector(typeChanged),forControlEvents: UIControlEvents.ValueChanged)
        //添加值改变监听
        self.view.addSubview(loadtype)
       
        
        webview = UIWebView();
        webview.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, self.view.frame.size.height - 100);
        webview.scalesPageToFit = true;
        self.view.addSubview(webview)
        
        typeChanged(loadtype);
    }
    
    func typeChanged(sender:UISegmentedControl){
        let index = sender.selectedSegmentIndex;
        print(index);
        
        switch index {
        case 0:
            let html = "<h1>欢迎来到: <a href='http://xiaobai8.com'>小白</a>的网站</h1>";
            webview.loadHTMLString(html, baseURL: nil);
        case 1:
            let path = NSBundle.mainBundle().pathForResource("test1", ofType:"pdf")
            let urlStr = NSURL.fileURLWithPath(path!);
            print(urlStr)
            webview.loadRequest(NSURLRequest(URL:urlStr));
        case 2: //在 UIWebView 中显示 PDF, 但是是通过 loadData 方式加载
            let path = NSBundle.mainBundle().pathForResource("test1", ofType:"pdf")
            
            let urlStr = NSURL.fileURLWithPath(path!);
            let data = NSData(contentsOfURL:urlStr);
            webview.loadData(data!,  MIMEType:"application/pdf",textEncodingName:"utf-8",baseURL:NSURL());
        default:
            print("是不是出错了？")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

