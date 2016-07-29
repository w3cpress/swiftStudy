//
//  ViewController.swift
//  swift14
//  Swift14 - 文件，文件夹操作大全
//  ios开发经常会遇到读文件，写文件等，对文件和文件夹的操作，这时就可以使用NSFileManager，NSFileHandle等类来实现。
//  来源:http://www.hangge.com/blog/cache/detail_527.html
//  操作文件还需要这篇文章
//  http://www.hangge.com/blog/cache/detail_765.html
//  Created by Alan on 16/6/17.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.遍历一个目录下的所有文件
        //假设用户文档下有如下文件和文件夹[test1.txt,fold1/test2.txt]
        let manager = NSFileManager.defaultManager();
        let urlForDocument = manager.URLsForDirectory( NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask);
        let url = urlForDocument[0] as NSURL;
        
        print(url);
        
        //（1）对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
        let contentsOfPath = try? manager.contentsOfDirectoryAtPath(url.path!)
        //contentsOfPath：Optional([fold1, test1.txt])
        print("contentsOfPath: \(contentsOfPath)")
        
        //（2）类似上面的，对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
        let contentsOfURL = try? manager.contentsOfDirectoryAtURL(url, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles);
        //contentsOfURL：Optional([file://Users/.../Application/.../Documents/fold1/,file://Users/.../Application/.../Documents/test1.txt])
        print("contentsOfURL: \(contentsOfURL)")
        
        //（3）深度遍历，会递归遍历子文件夹（但不会递归符号链接）
        let enumeratorAtPath = manager.enumeratorAtPath(url.path!)
        //enumeratorAtPath：Optional([fold1, fold1/test2.txt, test1.txt])
        print("enumeratorAtPath: \(enumeratorAtPath?.allObjects)")
        
        //（4）类似上面的，深度遍历，会递归遍历子文件夹（但不会递归符号链接）
        let enumeratorAtURL = manager.enumeratorAtURL(url, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, errorHandler:nil)
        //contentsOfURL：Optional([file://Users/.../Application/.../Documents/fold1/,file://Users/.../Application/.../Documents/fold1/test2.txt,file://Users/.../Application/.../Documents/test1.txt])
        print("enumeratorAtURL: \(enumeratorAtURL?.allObjects)")
        
        //（5）深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）
        let subPaths = manager.subpathsAtPath(url.path!)
        //subPaths：Optional([fold1, fold1/test2.txt, test1.txt])
        print("subPaths: \(subPaths)")
        
        
        
        //1.判断文件或文件夹是否存在
        let fileManager = NSFileManager.defaultManager()
        let filePath:String = NSHomeDirectory() + "/Documents/xiaobai.txt"
        let exist = fileManager.fileExistsAtPath(filePath)
        print(exist);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

