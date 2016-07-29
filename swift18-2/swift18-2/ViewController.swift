//
//  ViewController.swift
//  swift18-2
//  Swift18-2 - 键盘出现后自动改变页面布局，防止下方元素被键盘遮挡
//  http://www.hangge.com/blog/cache/detail_911.html
//  Created by Alan on 16/6/21.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //toolBar的下约束
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(keyboardWillChange),name: UIKeyboardWillChangeFrameNotification, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 键盘改变
    func keyboardWillChange(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.CGRectValue()
            let intersection = CGRectIntersection(frame, self.view.frame)
            
            //self.view.layoutIfNeeded();
            //改变下约束
            self.bottomConstraint.constant = CGRectGetHeight(intersection);
            UIView.animateWithDuration(duration, delay: 0.0,options: UIViewAnimationOptions(rawValue: curve), animations: { _ in self.view.layoutIfNeeded() }, completion: nil)
        }
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        //关闭键盘
        textField.resignFirstResponder()
    }
}

