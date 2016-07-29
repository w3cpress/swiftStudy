//
//  ViewController.swift
//  swift13
//  Swift13 - 协议（protocol）
//  参考 http://www.hangge.com/blog/cache/detail_526.html
//  Created by Alan on 16/6/17.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//1.Swift中协议类似于别的语言里的接口，协议里只做方法的声明，包括方法名、返回值、参数等信息，而没有具体的方法实现。

protocol Person {
    //读写属性
    var name:String{get set}
    
    //只读属性
    var age:Int{get}
    
    //类型方法
    static func method1()
    
    //实例方法
    func method2() -> Int
    
    //突变方法
    mutating func method3()
}
//2.协议可以继承另一个协议
protocol Animal{
    func move()
}

protocol Bird:Animal{
    func song()
}

class Chiken:Bird{
    func song(){
        print("母鸡咯咯");
    }
    
    func move(){
        print("母鸡走起");
    }
}
//3.如果某个类集继承了某个父类，又遵循了某个协议，那么冒号后面应该先写父类，再写协议
//class CC:继承的父类, 协议1, 协议2{
//}
