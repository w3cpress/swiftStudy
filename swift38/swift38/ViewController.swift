//
//  ViewController.swift
//  swift38
//  Swift38 - 使用SSZipArchive实现文件的压缩、解压缩
//  Created by Alan on 16/7/12.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //解压普通zip文件
        let zipPath = NSBundle.mainBundle().pathForResource("test", ofType: "zip")
        SSZipArchive.unzipFileAtPath(zipPath!, toDestination: tempDestPath()!);
        
        
        //解压带密码的zip文件
        let zipPath2   = NSBundle.mainBundle().pathForResource("test_password", ofType: "zip")
        
        do {
            try SSZipArchive.unzipFileAtPath(zipPath2!, toDestination: tempDestPath()!, overwrite: true, password: "hangge.com")
        } catch {
        }
        
        //将文件打成压缩包
        let files = [NSBundle.mainBundle().pathForResource("logo", ofType: "png")!,
                     NSBundle.mainBundle().pathForResource("icon", ofType: "png")!]
        
        let zipPath3 = tempDestPath()! + "/hangge.zip"
        SSZipArchive.createZipFileAtPath(zipPath3, withFilesAtPaths: files)
        
        let zipPath4 = tempDestPath()! + "/hangge.zip"
        SSZipArchive.createZipFileAtPath(zipPath4, withFilesAtPaths: files, withPassword: "hangge.com") //带密码
        
        
        //将整个文件夹下的文件打成压缩包
        //需要压缩的文件夹啊
        let filePath:String = NSHomeDirectory() + "/Documents"
        //先在该文件夹下添加一个文件
        let image = UIImage(named: "logo.png")
        let data:NSData = UIImagePNGRepresentation(image!)!
        data.writeToFile(filePath + "/logo.png", atomically: true)
        
        let zipPath5 = tempDestPath()! + "/hangge.zip"
        SSZipArchive.createZipFileAtPath(zipPath5, withContentsOfDirectory: filePath)
        
        
        let zipPath6 = tempDestPath()! + "/hangge.zip"
        SSZipArchive.createZipFileAtPath(zipPath6, withContentsOfDirectory: filePath, withPassword: "hangge.com") //带密码
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tempDestPath() -> String?{
        var path = NSSearchPathForDirectoriesInDomains(.CachesDirectory,.UserDomainMask, true)[0]
        path += "/\(NSUUID().UUIDString)";
        let url = NSURL(fileURLWithPath: path)
        
        do {
            try NSFileManager.defaultManager().createDirectoryAtURL(url, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return nil
        }
        
        if let path = url.path {
            print("path:\(path)")
            return path
        }
        
        return nil
        
    }


}

