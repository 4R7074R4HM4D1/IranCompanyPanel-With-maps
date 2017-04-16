//
//  FirstViewController.swift
//  IranCompanyPanel
//
//  Created by Ryo on 11/29/1395 AP.
//  Copyright © 1395 Ryo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    //@IBOutlet var NAV_bar: UINavigationBar!
    @IBOutlet var second_navbar: UINavigationBar!
    @IBOutlet var Navbar: UINavigationBar!
    let layerGradient = CAGradientLayer()
    let secondlayerGradient = CAGradientLayer()
    var C=UIColor(red:0.00, green:0.72, blue:0.83, alpha:1.0)
    var B=UIColor(red:0.00, green:0.90, blue:1.00, alpha:1.0)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bckg.jpg")!)
        layerGradient.colors=[C.cgColor,B.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        layerGradient.frame=Navbar.bounds
        self.Navbar.layer.insertSublayer(layerGradient, below: self.Navbar.layer.sublayers?[0])
        
        secondlayerGradient.colors=[C.cgColor,B.cgColor]
        secondlayerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        secondlayerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        secondlayerGradient.frame=second_navbar.bounds
        self.second_navbar.layer.insertSublayer(secondlayerGradient, below: self.second_navbar.layer.sublayers?[0])
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

