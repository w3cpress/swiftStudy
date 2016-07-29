//
//  ViewController.swift
//  swift03
//  Swift03 - 区间运算符（... 和 ..<）
//  区间运算符可以用来表示两个操作数之间的范围集合。
//  Created by Alan on 16/6/16.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.闭区间运算符：a...b 有点类似于[a,b]
        for iCount in 100...200 {
            print(iCount); //包括200;
        }
        //2.半闭区间运算符 a..<b 有点类似于[a,b)
        let temp = ["xiao ming","wang","jolly"];
        let iCount = temp.count;
        for i in 0..<iCount{
            print("第\(i+1)个人的名字是\(temp[i])");
        }
        
        //3.字符串范围也可以使用区间运算符
        let words = "xiaobai8.com";
        //不使用区间运算符x
        let index = words.startIndex.advancedBy(4)
        let index2 = words.startIndex.advancedBy(6)
        let range1 = Range<String.Index>(start: index, end: index2)
        let rangeStr1 = words.substringWithRange(range1) //ge
        print(rangeStr1)
        
        //使用区间运算符
        let range2 = words.startIndex.advancedBy(4)..<words.startIndex.advancedBy(6)
        let rangeStr2 = words.substringWithRange(range2) //ge
        print(range2,rangeStr2)
        
        //区间运算符除了返回一个Range外，还可以接受Comparable的输入，返回ClosedInterval或HalfOpenInterval
        //所以我们可以用这个特性检查字符串里的字符是不是都是合法字符（比如是不是都是小写）
        let words2 = "xiaobai8.COM";
        
        let interval = "a"..."z"
        for c in words2.characters {
            if !interval.contains(String(c)){
                print("\(c)不是小写字母")
            }
        }
        
        //H不是小写字母
        //.不是小写字母
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

