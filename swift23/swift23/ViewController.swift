//
//  ViewController.swift
//  swift23
//  Swift23 - 选择框（UIPickerView）的用法
//  http://www.hangge.com/blog/cache/detail_541.html
//  Created by Alan on 16/6/23.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerView:UIPickerView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerViewInit();
    }
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponentsInPickerView( pickerView: UIPickerView) -> Int{
        return 3
    }

    //设置选择框的行数为3行，继承于UIPickerViewDataSource协议
    func pickerView(pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        return 3
    }
    
    func pickerViewInit(){
        pickerView = UIPickerView();
        //将dataSource设置成自己
        pickerView.dataSource = self;
        //将delegate设置成自己
        pickerView.delegate = self;
        pickerView.selectRow(1, inComponent: 0, animated: true)
        pickerView.selectRow(2, inComponent: 1, animated: true)
        pickerView.selectRow(3, inComponent: 2, animated: true)
        self.view.addSubview(pickerView)
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let button = UIButton(frame:CGRectMake(0,0,100,30))
        button.center = self.view.center
        button.backgroundColor = UIColor.blueColor()
        button.setTitle("获取信息",forState:.Normal)
        button.addTarget(self, action:#selector(getPickerViewValue), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(row)+"-"+String(component)
    }
    
    //触摸按钮时，获得被选中的索引
    func getPickerViewValue(){
        let alertController = UIAlertController(title:"被选中的索引为",message:String(pickerView.selectedRowInComponent(0)) + "-"
            + String(pickerView!.selectedRowInComponent(1)) + "-"
            + String(pickerView.selectedRowInComponent(2)), preferredStyle: .Alert);
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .Default,handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //2.调整选择框的尺寸
    //UIPickerView 用 frame 和 center 两个属性设置整个选择框的大小和位置。
    //如果要调整内部列的宽度，需要实现 UIPickerViewDelegate 协议类中 pickerView:widthForComponent 方法设置
    //如果要调整内部行高，则需要实习上述协议类中 pickerView:rowHeightForComponent 方法设置
    
    //设置列宽
    func pickerView(pickerView: UIPickerView,widthForComponent component: Int) -> CGFloat{
        if(0 == component){
            //第一列变宽
            return 60
        } else {
            //第二、三列变窄
            return 100
        }
    }
    
    //设置行高
    func pickerView(pickerView: UIPickerView,rowHeightForComponent component: Int) -> CGFloat{
        return 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //3.将图片作为选择框选项
    //选择框选项的内容，除了可以使字符串类型的，还可以是任意UIView类型的元素。比如我们将选项内容设置为图片：
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let image = UIImage(named:"slider_"+String(row))
        let imageView = UIImageView()
        imageView.image = image;
        return imageView
    }
    
    //4.检测响应选项的选择状态
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        print(component)
        print(row)
    }


}

