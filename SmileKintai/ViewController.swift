//
//  ViewController.swift
//  SmileKintai
//
//  Created by Miki Arakawa on 2020/07/21.
//  Copyright © 2020 Miki Arakawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtYear: UILabel!
    
    @IBOutlet weak var txtMonth: UILabel!
    
    @IBOutlet weak var txtDay: UILabel!
    
    @IBOutlet weak var txtHour: UILabel!
    
    @IBOutlet weak var txtMinute: UILabel!
    
    @IBOutlet weak var txtSecond: UILabel!
    
    @IBOutlet weak var txtWeekday: UILabel!

    @IBOutlet weak var Comma_One: UILabel!
    
    @IBOutlet weak var Comma_two: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtYear.text = ""
        
        txtMonth.text = ""
        
        txtDay.text = ""
        
        txtHour.text = ""
        
        txtMinute.text = ""
        
        txtSecond.text = ""
        
        txtWeekday.text = ""

        Comma_One.text = ""
        
        Comma_two.text = ""
        
        viewInit()
        timerFiring()
    }

    @IBAction func Syukkin(_ sender: Any) {
        
        UserDefaults.standard.set("1", forKey: "Start")
        let vc = TimerViewController() //モーダル表示をフルスクリーンに指定
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func Taikin(_ sender: Any) {
        
        UserDefaults.standard.set("1", forKey: "End")
        let vc = TimerViewController() //モーダル表示をフルスクリーンに指定
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func KyuukeiStart(_ sender: Any) {
        
        UserDefaults.standard.set("1", forKey: "Break_Start")
        let vc = TimerViewController() //モーダル表示をフルスクリーンに指定
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func KyuukeiEnd(_ sender: Any) {
        
        UserDefaults.standard.set("1", forKey: "Break_End")
        let vc = TimerViewController() //モーダル表示をフルスクリーンに指定
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

    
    func timerFiring() {
        let timer = Timer(timeInterval: 1,
                          target: self,
                          selector: #selector(timeCheck),
                          userInfo: nil,
                          repeats: true)
        RunLoop.main.add(timer, forMode: .default)
    }
    
        @objc func timeCheck() {
            let date = NSDate()
            let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)

            let arrWeekday: Array = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]

            let year = calendar?.component(.year, from: date as Date)
            let month = calendar?.component(.month, from: date as Date)
            let day = calendar?.component(.day, from: date as Date)
            let hour = calendar?.component(.hour, from: date as Date)
            let minute = calendar?.component(.minute, from: date as Date)
            let second = calendar?.component(.second, from: date as Date)
            let weekday = calendar?.component(.weekday, from: date as Date)
            let dayOfTheWeek = arrWeekday[weekday! - 1]

            txtYear.text = String(year!)
            //editTextField(textField: txtYear, size: 50.0, color: .white)
            txtMonth.text = String(format: "%02d", month!)
            //editTextField(textField: txtMonth, size: 50.0, color: .white)
            txtDay.text = String(format: "%02d", day!)
            //editTextField(textField: txtDay, size: 50.0, color: .white)
            txtHour.text = String(format: "%02d", hour!)
            //editTextField(textField: txtHour, size: 180.0, color: .white)
            txtMinute.text = String(format: "%02d", minute!)
            //editTextField(textField: txtMinute, size: 180.0, color: .white)
            txtSecond.text = String(format: "%02d", second!)
            //editTextField(textField: txtSecond, size: 180.0, color: .white)
            txtWeekday.text = String(dayOfTheWeek)
            //editTextField(textField: txtWeekday, size: 50.0, color: .white)
            
            Comma_One.text = ":"
            
            Comma_two.text = ":"
        }

        func editTextField(textField:UITextField, size:CGFloat, color:UIColor) {
            textField.font = UIFont.boldSystemFont(ofSize: size)
            textField.textColor = color
            textField.isEnabled = false
        }

        func viewInit() {
            //view.backgroundColor = UIColor.black
        }
    }

//}

