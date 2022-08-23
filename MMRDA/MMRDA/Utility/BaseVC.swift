//
//  BaseVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // setGradientBackground()
        self.navigationController?.navigationBar.backgroundColor = .clear
        view.backgroundColor = UIColor(patternImage:(UIImage(named:"MainBG")?.resize(withSize:CGSize(width:self.view.frame.size.width, height:150)))!)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0/255.0, green: 49/255.0, blue: 113/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 42.0/255.0, green: 144.0/255.0, blue: 73.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 0.20,0.50,0.1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
