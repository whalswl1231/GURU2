//
//  MyViewController.swift
//  GURU
//
//  Created by swuad_25 on 17/07/2019.
//  Copyright © 2019 swuad_19. All rights reserved.
//

import UIKit
import Alamofire
class MyViewController:UIViewController{
    var student:Student?
    
    @IBOutlet weak var total_my: UILabel!
    @IBOutlet weak var total_std: UILabel!
    @IBOutlet weak var CTM_my: UILabel!
    @IBOutlet weak var CTM_std: UILabel!
    @IBOutlet weak var CTS_my: UILabel!
    @IBOutlet weak var CTS_std: UILabel!
    @IBOutlet weak var major1_my: UILabel!
    @IBOutlet weak var major1_std: UILabel!
    @IBOutlet weak var major1M_my: UILabel!
    @IBOutlet weak var major1M_std: UILabel!
    @IBOutlet weak var majorS_my: UILabel!
    @IBOutlet weak var majorS_std: UILabel!
    @IBOutlet weak var major2M_my: UILabel!
    @IBOutlet weak var major2M_std: UILabel!
    @IBOutlet weak var major2_my: UILabel!
    @IBOutlet weak var major2_std: UILabel!
    @IBOutlet weak var major2S_my: UILabel!
    @IBOutlet weak var major2S_std: UILabel!
    
    
    @IBOutlet weak var ct1: UILabel!
    @IBOutlet weak var ct2: UILabel!
    @IBOutlet weak var ct3: UILabel!
    @IBOutlet weak var ct4: UILabel!
    @IBOutlet weak var ct5: UILabel!
    
    @IBOutlet weak var a1: UILabel!
    @IBOutlet weak var a2: UILabel!
    @IBOutlet weak var a3: UILabel!
    @IBOutlet weak var a4: UILabel!
    @IBOutlet weak var a5: UILabel!
    
    @IBOutlet weak var toeic: UILabel!
    @IBOutlet weak var english: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProductData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 167/255, blue: 0/255, alpha: 1.0)
        
        let image = UIImage(named: "logo_top")
        //let imageSize = CGSize(width:10, height:10)
        //let marginX: CGFloat = (self.navigationController!.navigationBar.frame.size.width / 2) - (imageSize.width / 2)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height))
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.showSpinner(onView: self.view)
        
        let timer = Timer.scheduledTimer(timeInterval: 14, target: self, selector: #selector(remove_spinner), userInfo: nil, repeats: false)
        
    }
    @objc func remove_spinner() {
        self.removeSpinner()
    }
    
    @objc func getProductData(){
        guard let token = UserDefaults.standard.string(forKey: "token") else{
            print("토큰 없음")
            return
        }
        
        let headers:HTTPHeaders = [
            "Authorization" : "Token \(token)", "Accept" : "application/json"]
        let userDefault = UserDefaults.standard
        var id = userDefault.value(forKey: "id")
        var pwd = userDefault.value(forKey: "pwd")
        let parameters:Parameters = [
            "id": id!,
            "pwd":pwd!
        ]
        let url = "http://127.0.0.1:8000/graduate/student/"
        Alamofire.request(url, method: .get,parameters: parameters, headers: headers).responseData{
            response in switch response.result{
            case .failure:
                print("학점 취득 현황 조회 실패")
            case .success:
                print("학점 취득 현황 조회 성공")
                guard let data = response.result.value else {
                    return
                }
                let decoder = JSONDecoder()
                do{
                    print(String(data:data, encoding: .utf8)) // 데이터 가져옴
                    
                    self.student = try decoder.decode(Student.self, from: data)
                    self.total_my.text = "\(self.student!.total_std_my)"
                    self.total_std.text = "\(self.student!.total_std)"
                    self.CTM_my.text = "\(self.student!.necc_culture_my)"
                    self.CTM_std.text = "\(self.student!.necc_culture)"
                    self.CTS_my.text = "\(self.student!.selec_culture_my)"
                    self.CTS_std.text = "\(self.student!.selec_culture)"
                    self.major1M_my.text = "\(self.student!.major_necc_my)"
                    self.major1M_std.text = "\(self.student!.major_necc)"
                    self.majorS_my.text = "\(self.student!.major_selec_my)"
                    self.majorS_std.text = "\(self.student!.major_selec)"
                    self.major1_my.text = "\(self.student!.major_my)"
                    self.major1_std.text = "\(self.student!.major)"
                    
                    self.major2M_my.text = "\(self.student!.sec_major_necc_my)"
                    self.major2M_std.text = "\(self.student!.sec_major_necc)"
                    self.major2S_my.text = "\(self.student!.sec_major_selec_my)"
                    self.major2S_std.text = "\(self.student!.sec_major_selec)"
                    self.major2_my.text = "\(self.student!.sec_major_my)"
                    self.major2_std.text = "\(self.student!.sec_major)"
                    
                    self.ct1.text = "\(self.student!.ct1)"
                    self.ct2.text = "\(self.student!.ct2)"
                    self.ct3.text = "\(self.student!.ct3)"
                    self.ct4.text = "\(self.student!.ct4)"
                    self.ct5.text = "\(self.student!.ct5)"
                    
                    self.a1.text = self.student!.a1
                    self.a2.text = self.student!.a2
                    self.a3.text = self.student!.a3
                    self.a4.text = self.student!.a4
                    self.a5.text = self.student!.a5
                    
                    self.toeic.text = self.student!.toeic
                    self.english.text = self.student!.english
                    

                } catch{
                    print(error)
                    
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

