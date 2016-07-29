//
//  ViewController.swift
//  swift07
//  Swift07 - 自定义函数规则说明
//  Created by Alan on 16/6/16.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //1.无返回值的函数
    func test1(name:String){
    }
    
    //2.返回一个返回值
    func test2(name:String) -> Bool{
        return true;
    }
    
    //3.返回由多个值组成的复合返回值
    func test3(name:String) -> (Int,Bool) {
        let pos = 1;
        let visiable = true;
        return (pos,visiable);
    }
    
    //4.可变形参：可以接受0个或者任意数量的输入参数
    func test4(numbers:Int...) -> Int{
        var count:Int = 0
        for number in numbers{
            count += number
        }
        return count;
    }
    
    //5.在Swift函数中，参数默认是常量。如果要改变参数的值，就需要在定义函数的时候加上关键字var。（外部的参数仍然不会被修改）
    //无法编译
//    func addAge(age:Int) {
//        age += 1
//    }
    
    //可以编译
    func addAge(age:Int) {
        var _age = age;
        _age += 1;
        print(_age);
    }
    
    //6.如果想要同时改变函数内外的参数值，可以利用inout关键字，同时调用函数的时候给参数加上前缀“&”
    func add(inout age:Int){
        age += 1
    }
    
    //7.可以使用函数类型的参数
    func additive(a:Int, b:Int) -> Int{
        return a + b
    }
    //函数类型的参数
    func printAdditiveResult(addFun: (Int, Int) -> Int, a:Int, b:Int){
        print("Result:\(addFun(a,b))")
    }
    
    //8.也可以使用函数类型的返回值
    //定义自增函数
    func increase(input:Int) -> Int {
        return input + 1;
    }
    //定义自减函数
    func reduce(input:Int) -> Int {
        return input - 1;
    }
    //定义一个返回函数类型的函数
    func chooseFunction(backwards:Bool) -> Int -> Int {
        return backwards ? reduce : increase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var age = 22;
        //5.
        addAge(age);
        print(age);//22
        
        //6.
        add(&age)
        print(age);//23
        
        //7.
        printAdditiveResult(additive, a: 5 ,b: 7);
        
        //8.
        let aFun = chooseFunction(1>3);
        print(aFun(3));//2
    }
}

