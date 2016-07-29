//
//  ViewController.swift
//  swift27
//  Swift27 - 使用UIScrollView实现页面滚动切换
//  UIScrollView提供了以页面为单位滚动显示各个子页面内容的功能，每次手指滑动后会滚动一屏的内容
//  原文链接：http://www.hangge.com/blog/cache/detail_544.html
//  Created by Alan on 16/6/24.
//  Copyright © 2016年 jollycorp. All rights reserved.
//
/*
 要实现该功能，需要如下操作：
 1，将UIScrollView的 pagingEnabled 属性设置成true
 2，必须通过 contentSize 属性设置各个页面相加的宽度。比如iphone手机一屏宽度是320，如果有3个页面，则contentSize就需要设置为320*3=960
 3，最好将 showsHorizontalScrollIndicator 和 showsVerticalScrollIndicator 设置成 false 隐藏横向和纵向滚动条。
 4，如果 scrollsToTop 不需要也设置成false。
 */

import UIKit

class ViewController: UIViewController {
    
    let numOfPages = 3
    var pageWidth:CGFloat?
    var pageHeight:CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollViewInit();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewInit(){
        //scrollView的初始化
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds;
        //为了让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        pageWidth = self.view.frame.size.width;
        pageHeight = self.view.frame.size.height;
        scrollView.contentSize = CGSizeMake(pageWidth!*CGFloat(numOfPages),pageHeight!);
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        //添加子页面
        for i in 0..<numOfPages{
            let myViewController = MyViewController(number:(i+1))
            myViewController.view.frame = CGRectMake(pageWidth!*CGFloat(i), CGFloat(0), pageWidth!, pageHeight!)
            scrollView.addSubview(myViewController.view);
            
        }
        self.view.addSubview(scrollView)
    }
    

}

