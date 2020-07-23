//
//  TimerViewController.swift
//  SmileKintai
//
//  Created by Miki Arakawa on 2020/07/21.
//  Copyright © 2020 Miki Arakawa. All rights reserved.
//

import UIKit
import MBCircularProgressBar
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift



class TimerViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // FirestoreのDBのインスタンスを作成
//    let db = Firestore.firestore()

    var alertController: UIAlertController!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    
    
    @IBOutlet weak var txtYear: UILabel!
    
    @IBOutlet weak var txtMonth: UILabel!
    
    @IBOutlet weak var txtDay: UILabel!
    
    @IBOutlet weak var txtHour: UILabel!
    
    @IBOutlet weak var txtWeekday: UILabel!
    
    @IBOutlet weak var txtMinute: UILabel!
    
    @IBOutlet weak var txtSecond: UILabel!
    
    @IBOutlet weak var Comma_One: UILabel!
    
    @IBOutlet weak var Comma_Two: UILabel!
    
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
        
        Comma_Two.text = ""
        
        timerFiring()
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
            
            Comma_Two.text = ":"
        }

        func editTextField(textField:UITextField, size:CGFloat, color:UIColor) {
            textField.font = UIFont.boldSystemFont(ofSize: size)
            textField.textColor = color
            textField.isEnabled = false
        }

    @IBAction func SmileCheck(_ sender: Any) {
        
        // アクションシートを表示する
        let alertSheet = UIAlertController(title: nil, message: "選択してください", preferredStyle: .actionSheet)
        //カメラを選んだとき
        let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { action in
            print("カメラが選択されました")
            self.presentPicker(sourceType: .camera)
        }
        //アルバムを選んだとき
//        let albumAction = UIAlertAction(title: "アルバムから選択", style: .default) { action in
//            print("アルバムが選択されました")
//            self.presentPicker(sourceType: .photoLibrary)
//        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { action in
            print("キャンセルが選択されました")
        }
        alertSheet.addAction(cameraAction)
        //alertSheet.addAction(albumAction)
        alertSheet.addAction(cancelAction)

        present(alertSheet, animated: true)
    }
    
    //アルバムとカメラの画面を生成する関数, todoアプリのコピペ
    func presentPicker(sourceType:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            //ソースタイプが利用できるとき
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            //デリゲート先に自らのクラスを指定
            picker.delegate = self
            //画面を表示する
            present(picker, animated: true, completion: nil)
        } else {
            print("The SourceType is not found")
        }
    }
    //撮影もしくは画像を選択したら呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("撮影もしくは画像を選択したよ！")

        if let pickedImage = info[.originalImage] as? UIImage{
            //撮影or選択した画像をimageViewの中身に入れる
            imageView.image = pickedImage.resize(toWidth: 150)
           imageView.contentMode = .scaleAspectFill

            // progress barの初期化
            //progressBar.value = 0

            #warning("ここに顔検出ロジックを入れる")
            //顔検出を行う
            FaceDetector.shared.detectImage(pickedImage) { (result, errorMassage) in
                if errorMassage == nil {
                    // エラーが無い場合
                    // アニメーション付きでprogress barに値をセット
                    UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: {
                        self.progressBar.value = result * 100
                    }, completion: nil)
                    
                    if(result * 100<80){
                        self.alert(title: "スマイルが足りません",
                                message: "再度判定を行なってください")
                    }
                    else{
                        self.alert(title: "ナイススマイルです！",
                                message: "打刻に成功しました")
                        
                    }
                } else {
                    // エラーがある場合、Alertでエラー表示
                    let alert = UIAlertController(title: "エラー", message: errorMassage, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }
        //表示した画面を閉じる処理
        picker.dismiss(animated: true, completion: nil)

    }
    
    //Firestoreに保存する関数
    func createTaskToFirestore(_ title:String){
//        // taskに割り振るランダムな文字列を生成
//        let taskId = db.collection("Tasks").document().documentID
//        // taskIdを使ってTaskのインスタンスを作成
//        let task = Task(taskId: taskId, title: title, memo: memoTextView.text, createdAt: Timestamp(), updatedAt: Timestamp())
//        //Firestoreには、[String:Any]型で記録するため、Task型を変換する ※Encoder()にしないとエラーに なるので注意
//        do{ //エラー処理を強制されている関数は、tryをつけて処理する。tryをつけた箇所をdo{}で囲み、do~catch 文を使って処理する。
//            let encodedTask:[String:Any] = try Firestore.Encoder().encode(task) //変換に成功したとき
//            db.collection(“Tasks").document(taskId).setData(encodedTask) tasks.append(task) } catch let error as NSError { //変換に失敗したとき
//                print("エラー\(error)")
//
//        }
//
    }

        
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


