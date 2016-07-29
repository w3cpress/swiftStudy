//
//  ViewController.swift
//  swift01
//  Swift01 - 基本数据类型，及常/变量声明
//  Created by Alan on 16/6/16.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //变量：使用var声明
    var str:String = "xiaobai8.com";
    
    //常量：使用let声明
    let count:Int = 32;
    
    
    //整型：
    //有符号整型：Int，Int8，Int16，Int32，Int64
    //无符号整型：UInt，UInt8，UInt16，UInt32，UInt64
    
    //浮点型：
    //Float：32位浮点数类型
    //Double：64位浮点数类型
    
    //布尔型：Bool
    
    //字符串：String
    var str2:String = "";
    func _isEmpty(str:String){
        if(str.isEmpty){
            print("空字符串！");
        }
    }
    
    //获取字符数量：string.characters.count
    let str3:String = "xiaobai8.com";

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _isEmpty(str2);
        
        print("\(str3.characters.count)个字符");
        
        //检查字符串是否有特定前缀/后缀：hasPrefix/hasSuffix
        if str3.hasSuffix(".com"){
            print(".com")
        }
        
        //还可以用“\()”在字符串里包裹变量，常量
        let name = "xiaobai8.com"
        let msg = "欢迎来到 \(name)";
        print(msg);
        
        //大小写转换：
        //通过字符串的uppercaseString、lowercaseString、capitalizedString属性来访问一个字符串的大写/小写/首字母大写
        let str = "Welecome to xiaobai8.com";
        let uppercase = str.uppercaseString;
        //WELECOME TO XIAOBAI8.COM
        let lowercase = str.lowercaseString;
        //welecome to xiaobai8.com         
        let capitalized = str.capitalizedString;
        //Welecome To Xiaobai8.Com
        print(uppercase,lowercase,capitalized);
        
        //字符：Character
        let doller:Character = "$";
        print(doller);
        
        //元祖（对象）
        let myProject = (one:"game",two:1234);
        print("\(myProject.one)")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

