//
//  ViewController.swift
//  swift26
//  Swift26 - 微调器或叫步进器（UIStepper）, 滚动视图（UIScrollView）的用法
//  Created by Alan on 16/6/24.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    var stepper:UIStepper!;
    var label:UILabel!;
    
    var scrollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.
        //stepperInit();
        
        //2.
        //scrollViewInit();
        
        //3.
        scrollViewInit2();
    }
    
    func stepperInit(){
        stepper = UIStepper();
        //stepper.center = self.view.center;
        //设置范围
        stepper.frame = CGRectMake(10,50,300,30);
        stepper.maximumValue = 10;
        stepper.minimumValue = 1;
        stepper.value = 5.5;
        //设置每次增减的值
        stepper.stepValue = 0.5;
        
        //设置stepper可以按住不放来连续更改值
        stepper.continuous = true;
        stepper.addTarget(self,action:#selector(stepperValueIschanged), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(stepper)
        label = UILabel(frame:CGRectMake(100,190,300,30))
        print(stepper.value);
        label.text = "当前值为：\(stepper.value)"
        self.view.addSubview(label)
        
        //用自定义的图片替换“-”和“+”
//        stepper.setDecrementImage(UIImage(named: "voice1.jpg"), forState: UIControlState.Normal)
//        stepper.setIncrementImage(UIImage(named: "voice2.jpg"), forState: UIControlState.Normal)
        
    }
    func stepperValueIschanged(){
        label.text="当前值为：\(stepper.value)"
    }
    
    func scrollViewInit(){
        //1.当图片尺寸超过屏幕时，使用UIScrollView可以实现滚动条视图，即手指触摸滚动屏幕方便浏览整个页面。
        scrollView = UIScrollView();
        scrollView.frame = self.view.bounds;
        let imageView = UIImageView(image:UIImage(named:"140"))
        scrollView.contentSize = imageView.bounds.size;
        scrollView.addSubview(imageView);
        self.view.addSubview(scrollView)
    }
    
    //2.获取滚动视图移动的x,y坐标
    //通过scrollView.contentOffset.x与scrollView.contentOffset.y我们可以取到移动的偏移位置
    func scrollViewInit2(){
        scrollView = UIScrollView();
        scrollView.delegate = self;
        scrollView.frame=self.view.bounds
        let imageView = UIImageView(image:UIImage(named:"140"))
        scrollView.contentSize = imageView.bounds.size;
        scrollView.addSubview(imageView);
        self.view.addSubview(scrollView)
        
        scrollView.minimumZoomScale = 0.1 //最小比例
        scrollView.maximumZoomScale = 3 //最大比例

    }
    
    //视图滚动中一直触发
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("x:\(scrollView.contentOffset.x) y:\(scrollView.contentOffset.y)")
    }
    
    //3.手势放大缩小
    //要实现放大缩小功能，需要指定UIScrollView的允许缩放最大比例和最小比例（默认都是是1.0）。
   // 同时delegate属性指定一个委托类，委托类要继承UIScrollViewDelegate协议，并在委托类中实现viewForZoomingInScrollView方法。
    //（注：在模拟器中测试，需要按住option键再拖动内容）
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        for subview : AnyObject in scrollView.subviews {
            if subview.isKindOfClass(UIImageView) {
                return subview as? UIView
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

