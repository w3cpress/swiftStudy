//
//  ViewController.swift
//  swift05
//  Swift05 - 复杂数据类型说明（数组，字典，结构体，枚举）
//  Created by Alan on 16/6/16.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //1.数组 Array
        let types = ["none","warning","error"]  //省略类型的数组声明
        
        var menbers = [String]() //声明一个空数组
        
        menbers.append("six")  //添加元素
        menbers += ["seven"] //添加元素
        menbers.insert("one", atIndex:0)  //指定位置添加元素
        
        menbers[0] = "message"  //通过下标修改数组中的数据
        menbers[0...2] = ["message","xiaobai8","com"]  //通过小标区间替换数据（前3个数据）
        
        menbers.count  //获取数组元素个数
        menbers.isEmpty  //判断数组是否为空
        
        menbers.removeAtIndex(2)  //删除下标为2的数组
        menbers.removeLast()  //删除最后一个元素
        //menbers.removeAll(keepCapacity:true)  //删除数组中所有元素
        print(menbers);
        let addStringArr = types + menbers //数组组合
        print(addStringArr);
        //使用for in 实现数组遍历
        for value in menbers{
            print("\(value)");
        }
        
        //通过enumerate函数同时遍历数组的所有索引与数据
        for (index,value) in menbers.enumerate(){
            print("索引：\(index) 数据：\(value)");
        }
        
        //2.字典 - Dictionary（即键值对）
        
        let empty = [String: Int]()  //建立个空字典
        print(empty);
        
        var myDic = ["name":"xiaobai8",
                     "url":"xiaobai8.com"]  //声明一个字典
        
        myDic["address"] = "china" //添加或修改key值
        myDic.removeValueForKey("name")  //删除"name"这个key值
        myDic["name"] = nil  //同样可以删除"name"这个key值
        myDic.keys  //访问字典的key集合
        myDic.values //访问字典的values集合
        
        //遍历字典
        for (key,value) in myDic {
            print("\(key):\(value)");
        }
        
        //只遍历字典的键（key）
        for key in myDic.keys {
            print("\(key)");
        }
        
        //只遍历字典的值（value）
        for value in myDic.values {
            print("\(value)");
        }
        
        //3.结构体
        let book1 = BookInfo() //默认构造器创建结构体实例
        print(book1);
        var book2 = BookInfo(ID:0021,Name:"小白",Author:"Alan")  //调用逐一构造器创建实例
        book2.ID = 1234  //修改内部值
        
        //4.枚举
        enum CompassPoint {
            case North
            case South
            case East
            case West
        }
        let directionToHead = CompassPoint.West;
        
        enum Planet: Int {
            case Mercury = 1
            case Venus = 2
            case Earth = 3
        }
        let earthsOrder = Planet.Earth.rawValue //rawValue来获取他的原始值:3
        let possiblePlanet = Planet(rawValue: 2)  //通过原始值来寻找所对应的枚举成员:Venus
        
        print(directionToHead,earthsOrder,possiblePlanet?.rawValue);
        enum Direction {
            case Up
            case Down
            
            func description() -> String{
                switch(self){
                case .Up:
                    return "向上";
                case .Down:
                    return "向下";
                }
            }
        }
        print(Direction.Down.description());
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//3.结构体 - struct
//创建一个结构体
struct BookInfo {
    var ID:Int = 0
    var Name:String = "Defaut"
    var Author:String = "Defaut"
}
