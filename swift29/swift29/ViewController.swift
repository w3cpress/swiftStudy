//
//  ViewController.swift
//  swift29
//  Swift29 - 各种手势检测大全（UIGestureRecognizer及其子类）
//  Created by Alan on 16/6/24.
//  Copyright © 2016年 jollycorp. All rights reserved.
//
//UIGestureRecognizer有许多子类，用于监听一些常见的手势事件，这些子类主要有：

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1.UISwipeGestureRecognizer：滑动（快速移动）
        //demo1();
        
        
        //注意1：如果UISwipeGestureRecognizer在不指定方向的时候，默认向右滑动才会触发事件。如果要指定方向，需要设置direction属性
        
        //注意2：有人问如果各个方向都要响应怎么办，只要多定义几个UISwipeGestureRecognizer就可以了
        //demo2();
        
        //2.UITapGestureRecognizer:轻点手势（点击）
        /*（1）可以通过numberOfTouchesRequired属性设置触摸点数，比如设置2表示必须两个手指触摸时才会触发
        （2）通过numberOfTapsRequired属性设置点击次数，单击设置为1，双击设置为2
        （3）如果一个控件既监听了单击事件也监听了双击事件，默认当双击事件触发的时候也同时会触发单击事件。如果想双击时不触发单击，需要通过requireGestureRecognizerToFail进行设置
         */
        //tapDemo();
        
        //3.UIPinchGestureRecognizer:捏合手势（两个手指进行放大缩小）
        //pinchDemo();
        
        //4.UIRotationGestureRecognizer:旋转手势（两个手指进行旋转）
        //rotationDemo();
        
        //5.UIPanGestureRecognizer:拖动手势
        //rectView();
        
        //6.UILongPressGestureRecognizer:长按
        longPressView();
        
    }
    
    func demo1(){
        let swipe = UISwipeGestureRecognizer(target: self,action: #selector(swipe(_:)));
        //表示监听滑动的方向为向上
        swipe.direction = UISwipeGestureRecognizerDirection.Up;
        self.view.addGestureRecognizer(swipe);
    }
    
    func demo2(){
        let swipeUp = UISwipeGestureRecognizer(target:self, action:#selector(swipe2(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target:self, action:#selector(swipe2(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func tapDemo(){
        //单击监听
        let tapSingle = UITapGestureRecognizer(target:self,action:#selector(tapSingleDid))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        //双击监听
        let tapDouble = UITapGestureRecognizer(target:self,action:#selector(tapDoubleDid(_:)))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        //声明点击事件需要双击事件检测失败后才会执行
        tapSingle.requireGestureRecognizerToFail(tapDouble);
        self.view.addGestureRecognizer(tapSingle)
        self.view.addGestureRecognizer(tapDouble)
    }
    func tapSingleDid(){
        print("单击");
    }
    func tapDoubleDid(sender:UITapGestureRecognizer){
        if(self.view == sender.view){
            print("双击");
        }
    }
    
    func swipe(recognizer:UISwipeGestureRecognizer){
        print("swipe ok")
        let point = recognizer.locationInView(self.view)
        //这个点是滑动的起点
        print(point.x)
        print(point.y)
    }
    
    func swipe2(recognizer:UISwipeGestureRecognizer){
        if recognizer.direction == UISwipeGestureRecognizerDirection.Up {
            print("向上滑动")
        }else if recognizer.direction == UISwipeGestureRecognizerDirection.Down {
            print("向下滑动")
        }
        
        let point=recognizer.locationInView(self.view)
        //这个点是滑动的起点
        print(point.x)
        print(point.y)
    }

    func pinchDemo(){
        //设置监听方法为pinchDid方法
        let pinch = UIPinchGestureRecognizer(target:self,action:#selector(pinchDid(_:)));
        self.view.addGestureRecognizer(pinch);
    }
    func pinchDid(recognizer:UIPinchGestureRecognizer){
        //在监听方法中可以实时获得捏合的比例
        print(recognizer.scale);
    }
    
    func rotationDemo(){
        let rotation = UIRotationGestureRecognizer(target: self,action: #selector(rotationDid(_:)))
        self.view.addGestureRecognizer(rotation);
    }
    func rotationDid(recognizer:UIRotationGestureRecognizer){
        //旋转的弧度转换为角度
        print(recognizer.rotation*(180/CGFloat(M_PI)))
    }
    
    var rect:UIView!;
    func rectView(){
        rect = UIView(frame:CGRectMake(0,0,100,100));
        rect.center = self.view.center;
        rect.backgroundColor = UIColor.redColor();
        self.view.addSubview(rect);
        
        let pan = UIPanGestureRecognizer(target: self,action: #selector(panDid(_:)));
        pan.maximumNumberOfTouches = 1
        rect.addGestureRecognizer(pan);
    }
    func panDid(recognizer:UISwipeGestureRecognizer){
        let point = recognizer.locationInView(self.view);
        //设置矩形的位置
        rect.center = point;
    }
    
    func longPressView(){
        //长按监听
        let longPress = UILongPressGestureRecognizer(target:self, action:#selector(longPressDid(_:)));
        self.view.addGestureRecognizer(longPress);
    }
    
    func longPressDid(sender: UILongPressGestureRecognizer){
        if sender.state == .Began {
            print("长按响应开始")
        } else {
            print("长按响应结束")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

