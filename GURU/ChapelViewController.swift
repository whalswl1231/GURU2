//
//  ChapelViewController.swift
//  GURU
//
//  Created by swuad_25 on 17/07/2019.
//  Copyright © 2019 swuad_19. All rights reserved.
//

import UIKit
import Alamofire


class ChapelViewController:UIViewController{
    var chapel:Chapel?
    
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var failLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    
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
        
        let timer = Timer.scheduledTimer(timeInterval: 8.5, target: self, selector: #selector(remove_spinner), userInfo: nil, repeats: false)
        
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
        let url = "http://127.0.0.1:8000/graduate/chapel/"
        Alamofire.request(url, method: .get,parameters: parameters, headers: headers).responseData{
            response in switch response.result{
            case .failure:
                print("경건회 조회 실패")
            case .success:
                print("경건회 조회 성공")
                guard let data = response.result.value else {
                    return
                }
                let decoder = JSONDecoder()
                do{
                    print(String(data:data, encoding: .utf8))
                    
                    self.chapel = try decoder.decode(Chapel.self, from: data)
                    self.remainLabel.text = "\(self.chapel!.remain)"
                    self.seatLabel.text = self.chapel!.seat
                    self.totalLabel.text = self.chapel!.total
                    self.failLabel.text = self.chapel!.fail
                    self.passLabel.text = self.chapel!.success
                } catch{
                    print(error)
                    
                    print(error.localizedDescription)
                }
            }
            
        }
    }

}

