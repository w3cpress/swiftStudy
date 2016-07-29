//
//  ViewController.swift
//  swift04
//  Swift04 - 运算符重载和运算符函数
//  让已有的运算符对自定义的类和结构进行运算或者重新定义已有运算符的运算规则，这种机制被称为运算符重载。
//  Created by Alan on 16/6/16.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

//1.通过重载加号运算符，使自定义的两个坐标结构体对象实现相加：
struct CenterPointer {
    var x = 0 , y = 0;
}
func + (left:CenterPointer,right:CenterPointer) -> CenterPointer{
    return CenterPointer(x:left.x+right.x,y:left.y+right.y);
}

//2.重载判断运算符，实现判断自定义类型是否相等
func == (left:CenterPointer, right:CenterPointer) -> Bool {
    return (left.x == right.x) && (left.y == right.y);
}

func != (left:CenterPointer, right:CenterPointer) -> Bool {
    return !(left == right);
}

//3.组合运算符，即将其他运算符和赋值运算符组合在一起，注意要把运算符左参数设置成inout类型
func += (inout left:CenterPointer, right:CenterPointer){
    left = left + right
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.
        var pointer1 = CenterPointer(x:2, y:3)
        var pointer2 = CenterPointer(x:4, y:5)
        var pointer3 = pointer1 + pointer2
        print(pointer3);
        //2.
        pointer1 = CenterPointer(x:20, y:30)
        pointer2 = CenterPointer(x:20, y:50)
        pointer3 = CenterPointer(x:20, y:30)
        print(pointer1==pointer2,pointer1==pointer3);
    
        //3.
        pointer1 = CenterPointer(x:2, y:3)
        pointer2 = CenterPointer(x:4, y:5)
        pointer1 += pointer2;
        print(pointer1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

