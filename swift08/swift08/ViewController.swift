//
//  ViewController.swift
//  swift08
//  Swift08 - 类初始化和反初始化方法（init与deinit）
//  参考 http://www.hangge.com/blog/cache/detail_518.html
//  Created by Alan on 16/6/17.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.
        let student = Student();
        print(student.number);
        
        let student2:Student = Student();
        print(student2.number);
        
        let student3:Student? = Student();
        print(student3?.number);
        
        let student4:Student! = Student();
        print(student4!.number);
        
        let p = Person(newName: "Alan",newAge: 28)
        print(p.say())
        
        //关于问号感叹号一些研究
        /***
        http://www.cnblogs.com/royi123/archive/2014/07/10/3834909.html
         http://letsswift.com/2014/06/swift-questionmark-exclamatorymark/
        ***/
        
        //2.
//        var db:DBClass? = DBClass()
//        db = nil //设置nil后即可执行deinit()方法
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//1.init()：类的初始化方法（构造方法）
/********************************
 使用默认构造函数
 ********************************/
class Student {
    //类属性
    var name:String = "";
    var number:Int = 0;
}
/************
 自定义构造函数
 ************/
class Person {
    //类属性
    var name:String
    var age:Int
    
    //类构造函数
    init(newName:String, newAge:Int){
        self.name = newName
        self.age = newAge
    }
    
    //类方法
    func say() -> String{
        return "我叫\(name)"
    }
}

//2.deinit()：类反初始化方法（析构方法）
//class DBClass{
//    var conn:Connection? = Connection()
//    deinit{
//        //可以做一些清理工作
//        self.conn!.close()
//        self.conn = nil
//    }
//}

