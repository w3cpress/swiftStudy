//
//  ViewController.swift
//  swift12
//  Swift12 - 下标脚本方法介绍及实例
//  定义下标脚本之后，可以使用"[]"来存取数据类型的值。
//  Created by Alan on 16/6/17.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //示例1.
        let str = SubString(str:"xiaobai8.com")
        print(str[9,3])  //获取字符串：com
        print(str[9])  //获取字符：c
        
        str[9,3] = "COM"  //设置部分字符串
        str[0] = "X" //设置部分字符
        print(str[0,12]) //Xiaobai8.COM
        
        //示例2.
        var str2 = "xiaobai8.com"
        print(str2[9,3])
        print(str2[9])
        
        str[9,3] = "COM"
        str[0] = "X"
        
        print(str[0,12]);
        
        
        //3.
        let value = Matrix(rows: 20,columns: 20)
        value[10,10] = 20;
        print(value[10,10]);
        
        //4.类扩展相关
        let value2 = 2000000000.0
        print(value2.mm());
        print(value2.cm());
        print(value2.dm());
        print(value2.m());
        print(value2.km());
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//示例1.实现一个我们自定的字符串类，可以方便的通过索引获取某一个字符值，或某一部分字符串。同时也可以通过索引，给某一部分赋值.
class SubString {
    var str:String = "";
    init(str:String){
        self.str = str;
    }
    
    //下标脚本，获取/设置部分字符串
    subscript(start:Int,length:Int) -> String {
        get {
            return (str as NSString).substringWithRange(NSRange(location: start,length: length));
        }
        set {
            let tmp = str;
            str = "";
            var s = "";
            var e = "";
            for (idx,item) in tmp.characters.enumerate(){
                if idx < start {
                   s += "\(item)";
                }
                
                if idx >= start + length {
                    e += "\(item)";
                }
            }
            
            str = s + newValue + e;
        }
    }
    
    //下标脚本：获取/设置字符
    subscript(index:Int) -> String {
        get {
            return String(str[str.startIndex.advancedBy(index)])
        }
        set {
            let tmp = str;
            str = "";
            for (idx, item) in tmp.characters.enumerate() {
                if idx == index {
                    str += "\(newValue)";
                } else {
                    str += "\(item)";
                }
            }
        }
    }
    
}

//2.示例1改进：通过类扩展，也可以直接给String类添加索引功能，代码如下：
extension String {
    subscript(start:Int, length:Int) -> String {
        get {
            return (self as NSString).substringWithRange(NSRange(location: start, length: length))
        }
        set {
            let tmp = self;
            var s = "";
            var e = "";
            for (idx, item) in tmp.characters.enumerate() {
                if(idx < start)
                {
                    s += "\(item)"
                }
                if(idx >= start + length)
                {
                    e += "\(item)"
                }
            }
            self = s + newValue + e
        }
    }
    subscript(index:Int) -> String {
        get {
            return String(self[self.startIndex.advancedBy(index)])
        }
        set {
            let tmp = self;
            self = "";
            for (idx, item) in tmp.characters.enumerate() {
                if idx == index {
                    self += "\(newValue)";
                } else {
                    self += "\(item)";
                }
            }
        }
    }
}

//示例2：使用一维数组结合下标方法一定程度上模拟实现了二维数组
//这个案例有点类似于坐标点
class Matrix {
    let rows:Int,columns:Int;
    var grid:[Double];
    init(rows:Int,columns:Int) {
        self.rows = rows;
        self.columns = columns;
        grid = Array(count:rows * columns,repeatedValue: 0.0);
    }
    
    func indexIsValidForRow(row:Int,column:Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns;
    }
    
    subscript(row:Int,column:Int) -> Double{
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range");
            return grid[(row * columns) + column];
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range");
            grid[(row * columns) + column] = newValue;
        }
    }
    
}

//4.类扩展案例：给Double增加mm，cm等方法，进行进制转换
extension Double {
    func mm()->String {
        return "\(self/1)mm";
    }
    func cm()-> String {
        return "\(self/10)cm";
    }
    
    func dm()->String {
        return "\(self/100)dm";
    }
    
    func m()->String {
        return "\(self/1000)m";
    }
    func km()->String {
        return "\(self/(1000*1000))km";
    }
}

