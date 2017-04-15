//
//  ThirdViewController.swift
//  recoding diet
//
//  Created by 久世昌和 on 2017/03/30.
//  Copyright © 2017年 久世昌和. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var goalweight: UILabel!
    
    var Array = ["Reasonable","Beauty","Fashion Model"]
    var chosencourse:String = ""
    var bmi:Int = 0
    var result:Double = 0.0
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        //goalweight.text = ""
        
        name.delegate = self
        height.delegate = self
        weight.delegate = self
        
        self.height.keyboardType = UIKeyboardType.numberPad
        self.weight.keyboardType = UIKeyboardType.numberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            chosencourse = "Reasonable"
            bmi = 22
        }
        else if row == 1{
            chosencourse = "Beauty"
            bmi = 20
        }
        else{
            chosencourse = "Fashion Model"
            bmi = 18
        }
        //change weight & height: string -> double
        //UItextField is not blank
        if height.text?.isEmpty == false{
            result = Double(height.text!)! / 100
            result = pow(result,2) * Double(bmi)
            result = result * 10
            result = round(result) / 10
            goalweight.text = String(result)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.resignFirstResponder()
        height.resignFirstResponder()
        weight.resignFirstResponder()
        
        //UItextField is not blank || course is not blank
        if height.text?.isEmpty == false{
            result = Double(height.text!)! / 100
            result = pow(result,2) * Double(bmi)
            result = result * 10
            result = round(result) / 10
            goalweight.text = String(result)
        }

        return true
    }
    
    
    
    func tapScreen(_ sender: Any) {
        self.view.endEditing(true)
        
        //UItextField is not blank || course is not blank
        if height.text?.isEmpty == false{
            result = Double(height.text!)! / 100
            result = pow(result,2) * Double(bmi)
            result = result * 10
            result = round(result) / 10
            goalweight.text = String(result)
        }
        //print("tap")
    }
    
    
    @IBAction func save(_ sender: Any) {
        appDelegate.namemessage = name.text
        appDelegate.weightmessage = weight.text
        appDelegate.goalmessage = chosencourse
        appDelegate.goalweightmessage = String(result)
        
        //post dbdata?
        let requestUrl = "http://192.168.33.10:8000"
        //...dictionary type
        let json = ["id": "0",
                    "name": "masa"
        ]

        let data = NSKeyedArchiver.archivedData(withRootObject: json) as Data
        Alamofire.upload(data, to:requestUrl).response{response in
            debugPrint(response)
        }
 
    }
    

}
