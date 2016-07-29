//
//  ViewController.swift
//  swift02
//  swift02 - 使用arc4random()、arc4random_uniform()取得随机数
//  Created by Alan on 16/6/16.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //arc4random()这个全局函数会生成9位数的随机整数
        
        //下面是使用arc4random函数求一个1~100的随机数（包括1和100）
        let temp:Int = Int(arc4random()%100) + 1;
        
        print(temp);
        
        
        //下面是使用arc4random_uniform函数求一个1~100的随机数（包括1和100）
        let temp2:Int = Int(arc4random_uniform(100))+1;
        print(temp2);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

