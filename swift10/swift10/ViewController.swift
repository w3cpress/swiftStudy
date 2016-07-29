//
//  ViewController.swift
//  swift10
//  Swift10 - 结构体属性（类静态属性）和类方法（类静态方法）
//  Created by Alan on 16/6/17.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.访问struct静态属性
        print(Account.interestBy(100));
        //2.访问class静态属性
        print(Account2.interestBy(100));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//1.结构体struct的静态属性，静态方法使用static关键字
struct Account {
    var amount:Double = 0.0; //账户金额
    var owner:String = ""; //账户名
    
    static var interestRate:Double = 0.6118 //利率
    
    static func interestBy(amount:Double) -> Double {
        return interestRate * amount;
    }
}
//2.类class的类型属性，类型方法使用class关键字
class Account2 {
    var amount : Double = 0.0               // 账户金额
    var owner : String = ""                 // 账户名
    
    class var staticProp : Double {
        return 0.6118
    }
    
    class func interestBy(amount : Double) -> Double {
        return staticProp * amount
    }
}

/***********************************
参考：http://www.hangge.com/blog/cache/detail_523.html
类和结构体的区别
类和结构体有许多相同之处，也有许多不同之处。

二者区别如下:
1.类可以继承，结构体不可以
2.可以让一个类的实例来反初始化，释放存储空间，结构体做不到
3.类的对象是引用类型，而结构体是值类型。所以类的赋值是传递引用，结构体则是传值。

相同点:
1.类和结构体都可以扩展
2.定义属性用于储存值
3.定义方法用于提供功能
4.定义下标用于通过下标语法访问值
5.定义初始化器用于生成初始化值
******************************************/

