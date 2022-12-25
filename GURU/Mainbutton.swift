//
//  Mainbutton.swift
//  GURU
//
//  Created by swuad_25 on 16/07/2019.
//  Copyright © 2019 swuad_19. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class Mainbutton: UIViewController, WKUIDelegate, WKNavigationDelegate{
    
    @IBOutlet weak var webview: WKWebView!
    
    
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
        
        let url = URL(string: "https://www.swu.ac.kr/index.do")
        let request = URLRequest(url: url!)
        webview?.load(request)

        /*
        let url = URL(string: "https://www.swu.ac.kr/front/mboardlist.do?cmsDirPkid=339&cmsLocalPkid=0")
        let request = URLRequest(url: url!)
        webview?.load(request)
 */

    }


    @IBAction func go_action(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"https://www.swu.ac.kr/front/mboardlist.do?cmsDirPkid=339&cmsLocalPkid=0")! as URL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func go_Logout(_ sender: UIButton) {
        
        
    }
    
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
