//
//  ViewController.swift
//  swift06
//  Swift06 - 控制流/控制结构说明（if，switch，for，while）
//  Created by Alan on 16/6/16.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //_init(10,fruit:"apple",age:10,point: (2,0),height:1.72);
        
        _init_for();
    }
    
    func _init(count:Int,fruit:String,age:Int,point:(Int,Int),height:Float){
        //1.if语句
        if count>=3 {
            print("yes")
        } else {
            print("no")
        }
        
        //2.switch 语句
        //（1）Swift中不需要在case块中显示地使用break跳出switch。
        // 如果想要实现C风格的落入特性，可以给需要的case分支插入fallthrough语句
        switch fruit {
            case "apple":
                print("good")
                fallthrough
            case "banana","orange":
                print("great")
            default:
                print("bad")
        }
        //（2）case分支还可以进行区间匹配
        switch age {
            case 0...11:
                print("青年")
            case 12...30:
                print("年轻人")
            default:
                print("大叔")
        }
        
        //（3）使用元组匹配（判断属于哪个象限）
        switch point {
            case (0,0):
                print("坐标在原点")
            case (_,0):
                print("坐标在x轴上")
            case (0,_):
                print("坐标在y轴上")
            case (-3...3, -3...3):
                print("坐标在长宽为6的正方形内")
            default:
                print("在什么地方")
        }
        
        //（4）case中还可以使用where关键字来做额外的判断条件
        switch height{
            case 1...3 where height == 1.72:
                print("case 1")
            case 1...3 where height == 2:
                print("case 2")
            default:
                print("default")
        }
        
    }
    
    func _init_for(){
        //3.for循环语句
        //（1）for条件递增循环（注意：由于++语法将在Swift3中被废除，所以for循环建议使用下面的for-in写法）
//        for var i=0; i<100; i++ {
//            print("\(i)")
//        }
        //（2）for-in循环
        for i in 0..<100 {
            print("\(i)");
        }
        
        //遍历数组元素
        let numbers = [1,2,4,7]
        for num in numbers{
            print("\(num)")
        }
        
        //遍历字典
        let nameOfAge = ["lily":18, "Candy":24];
        for (aName, iAge) in nameOfAge{
            print("\(aName) is \(iAge)")
        }
        
        //遍历字符串的字符
        for chare in "xiaobai8.com".characters {
            print(chare);
        }
        
        //4，while循环语句
        var n = 0;
        while n<10 {
            n += 1;
            print(n);
        }
        var m = 0;
        repeat {
            m += 1;
            print(m);
        } while m<10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

