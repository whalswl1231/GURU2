//
//  SiteController.swift
//  GURU
//
//  Created by swuad_25 on 17/07/2019.
//  Copyright © 2019 swuad_19. All rights reserved.
//

import UIKit

class SiteController:UIViewController{
    
    @IBOutlet weak var joberum: UIButton!
    @IBOutlet weak var cj: UIButton!
    @IBOutlet weak var doosan: UIButton!
    @IBOutlet weak var ncs: UIButton!
    @IBOutlet weak var jasoseol: UIButton!
    @IBOutlet weak var saramin: UIButton!
    @IBOutlet weak var jobkorea: UIButton!
    @IBOutlet weak var worknet: UIButton!
    @IBOutlet weak var mediajob: UIButton!
    @IBOutlet weak var peoplenjob: UIButton!
    
    @IBAction func go_joberum(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.joberum.com/")! as URL)
    }
    
    @IBAction func go_cj(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://recruit.cj.net/")! as URL)
    }
    
    @IBAction func go_doosan(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://career.doosan.com/")! as URL)
    }
    
    @IBAction func go_ncs(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.ncs.go.kr")! as URL)
    }
    
    @IBAction func go_jasoseol(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://jasoseol.com/")! as URL)
    }
    
    @IBAction func go_saramin(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.saramin.co.kr")! as URL)
    }
    
    @IBAction func go_jobkorea(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.jobkorea.co.kr/")! as URL)
    }
    
    @IBAction func go_worknet(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.work.go.kr/")! as URL)
    }
    
    @IBAction func go_mediajob(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.mediajob.co.kr/")! as URL)
    }
    
    @IBAction func go_peoplenjob(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.peoplenjob.com/home/")! as URL)
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

    }
}
