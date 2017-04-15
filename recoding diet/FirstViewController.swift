//
//  FirstViewController.swift
//  recoding diet
//
//  Created by 久世昌和 on 2017/03/29.
//  Copyright © 2017年 久世昌和. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    let date:NSDate = NSDate()//インスタンス生成　日付取得
    
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var goalweight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //name.text = "Yun"
        
        let testFormatter = DateFormatter()
        testFormatter.locale = NSLocale(localeIdentifier:"ja_JP") as Locale!
        testFormatter.dateFormat = "yyyy/MM/dd(E)"
        today.text = testFormatter.string(from: date as Date)
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        goal.text = appDelegate.goalmessage
        name.text = appDelegate.namemessage
        weight.text = appDelegate.weightmessage
        goalweight.text = appDelegate.goalweightmessage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func button(_ sender: Any) {
        weight.text = "50"
    }

}

