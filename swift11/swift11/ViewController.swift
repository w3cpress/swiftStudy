//
//  ViewController.swift
//  swift11
//  Swift11 - 类的计算属性（使用get和set来间接获取/改变其他属性的值）
//  Created by Alan on 16/6/17.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.
        let sum = getSum();
        print(sum.sum); //2
        sum.sum = 5;
        print(sum.b); //4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//1.Swift中类可以使用计算属性，即使用get和set来间接获取/改变其他属性的值
class getSum{
    var a:Int = 1;
    var b:Int = 1;
    
    var sum:Int{
        get {
            return a + b;
        }
        set(val) {
            b = val - a;
        }
    }
}

//2.对于set有简写方法，简写时，新赋的值默认为newValue
class getSum2{
    var a:Int = 1;
    var b:Int = 1;
    
    var sum:Int{
        get {
            return a + b;
        }
        set {
            b = newValue - a;
        }
    }
}

//3.如果只要get，不要set方法时可以简写成如下代码
class getSum3{
    var a:Int = 1;
    var b:Int = 1;
    
    var sum:Int {
       return a + b;
    }
}

