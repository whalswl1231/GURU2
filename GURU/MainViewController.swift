//
//  MainViewController.swift
//  GURU
//
//  Created by swuad_19 on 17/07/2019.
//  Copyright © 2019 swuad_19. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var id_field: UITextField!
    @IBOutlet weak var pwd_field: UITextField!
    @IBOutlet weak var token_field: UILabel!
    @IBOutlet weak var autobutton: UIButton!
    
    @IBAction func btn_box(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    
    var id:String!
    var pwd:String!
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 /*   @IBAction func autoLoginAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        
       // UserDefaults.standard.set(sender.isSelected, forKey: "isAutoLogin")
    
        
    }
 */
 
    /*
     
     1. 회원 가입
     2. 로그인
     3. 토큰 얻기(저장)
     4. 화면 전환
     
     1. 오토로그인 이면
     2. 저장된 id, pwd로 토큰 얻기
     3. 화면전환
 */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dataSave = UserDefaults.standard
        guard let isAutoLogin = dataSave.value(forKey: "autoLogin") as? Bool else {
            return
        }
        
        if isAutoLogin {
            guard let id = dataSave.value(forKey:"save_id") as? String, let pwd = dataSave.value(forKey:"save_pwd") as? String else {
                return
            }
            print("autologin", id, pwd)
            self.getToken(id:id, pwd:pwd)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 244/255, green: 187/255, blue: 70/255, alpha: 1.0)
        
    }
    
    
    @IBAction func doSignLogin(_ sender: Any) {
        self.doSignup()
    }
    
    
    
    func doSignup() {
        self.id = (self.id_field.text != nil) ? self.id_field.text : ""
        self.pwd = (self.pwd_field.text != nil) ? self.pwd_field.text : ""
        
        var xcode_id = self.id_field.text
        var xcode_pwd = self.pwd_field.text
        guard let username = self.id_field.text, let id_data:Data = username.data(using: .utf8) else {
            return
        }
        guard let password = self.pwd_field.text, let pwd_data:Data = password.data(using: .utf8) else {
            return
        }
        
        if self.autobutton.isSelected == true {
            let dataSave = UserDefaults.standard
            dataSave.setValue(true, forKey: "autoLogin")
            dataSave.setValue(self.id, forKey:"save_id")
            dataSave.setValue(self.pwd, forKey: "save_pwd")
        } else {
            let dataSave = UserDefaults.standard
            dataSave.setValue("nil", forKey: "save_id")
            dataSave.setValue("nil", forKey: "save_pwd")
            UserDefaults.standard.synchronize()
        }
        print("\(UserDefaults.standard.value(forKey: "save_id")!)")
        print("\(UserDefaults.standard.value(forKey: "save_pwd")!)")
        
        
        Alamofire.upload(multipartFormData:{
            (multipartFormData) in multipartFormData.append(id_data, withName: "username")
            multipartFormData.append(pwd_data, withName: "password")
        }, to: "http://127.0.0.1:8000/accounts/signup/", encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON{
                    response in
                    debugPrint(response)
                    print("회원가입 성공")
                    self.doLogin()
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
        
    }
 
    
    
    func doLogin() {
        
        if let id = id_field.text, let pwd = pwd_field.text {
            if id != "" && pwd != "" {
                self.getToken(id:id, pwd:pwd)
                
            } else {
                print("null data")
            }
        }
    }
    
    func runLogin() {
        
        token_field.text = "Now login..."
        print("로그인 성공")
        
        guard let vc = self.storyboard?
            .instantiateViewController(withIdentifier: "mainList") else {
                return
        }
        self.present(vc, animated:false)
    }
    
    
    func getToken(id:String, pwd:String){
        let parameters:Parameters = [
            "username":id,
            "password":pwd
        ]
        let login_url = "http://127.0.0.1:8000/api/get_token/"
        Alamofire.request(login_url, method: .post, parameters: parameters).responseData{
            response in
            
            switch response.result{
            case .success:
                print("접속 성공")
                if let data = response.data, let utf8Text = String(data:data, encoding: .utf8){
                    print("Data", utf8Text)
                    
                    let decoder = JSONDecoder()
                    do{
                        let token_data = try decoder.decode(Token.self, from: data)
                        //id, pwd 일치
                        print(token_data.token)
                        self.token_field.text = token_data.token
                        self.saveToken(token: token_data.token)
                        let userDefault = UserDefaults.standard
                        userDefault.setValue(id, forKey: "id")
                        userDefault.setValue(pwd, forKey: "pwd")
                        
                        self.runLogin()
                    } catch {
                        //id, pwd 불일치
                        print(error.localizedDescription)
                    }
                }
            case .failure:
                print("접속 실패")
            }
        }
    }
    func saveToken(token:String){
        let userDefault = UserDefaults.standard
        userDefault.setValue(token, forKey: "token")
        userDefault.synchronize()
    }
    
    func getSavedToken() -> String{
        let userDefault = UserDefaults.standard
        if let token = userDefault.string(forKey: "token"){
            return token
        }
        return ""
    }
  

    
}
