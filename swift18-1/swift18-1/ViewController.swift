//
//  ViewController.swift
//  swift18-1
//  Swift18-1 - 文本输入框内容改变时响应，并获取最新内容
//  http://www.hangge.com/blog/cache/detail_718.html
//  Created by Alan on 16/6/20.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    let button:UIButton = UIButton(type:.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let textField = UITextField(frame: CGRectMake(10,260,200,30))
        //设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.returnKeyType = UIReturnKeyType.Done
        textField.delegate = self
        self.view.addSubview(textField);
       
        //设置按钮位置和大小
        button.frame = CGRectMake(10, 150, 100, 30);
      
        button.enabled = false;
       
        //设置按钮文字
        button.setTitle("按钮", forState:UIControlState.Normal)
        self.view.addSubview(button);

    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        let newText = textField.text!.stringByReplacingCharactersInRange(
            range.toRange(textField.text!), withString: string)
       button.enabled = newText.characters.count > 0
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//扩展NSRange，让swift的string能使用stringByReplacingCharactersInRange
extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.startIndex.advancedBy(self.location)
        let endIndex = startIndex.advancedBy(self.length)
        return startIndex..<endIndex
    }
}

