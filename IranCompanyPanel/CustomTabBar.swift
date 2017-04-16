//
//  CustomTabBar.swift
//  IranCompanyPanel
//
//  Created by Ryo on 12/1/1395 AP.
//  Copyright © 1395 Ryo. All rights reserved.
//

import UIKit
class CustomTabBar: UITabBarController {
    let layerGradient = CAGradientLayer()
    var A=UIColor(red:0.25, green:0.74, blue:0.62, alpha:1.0)
    var C=UIColor(red:0.04, green:0.08, blue:0.11, alpha:1.0)
   // var A=UIColor(red:0.09, green:1.00, blue:1.00, alpha:1.0)
   // var B=UIColor(red:0.00, green:0.34, blue:0.61, alpha:1.0)
    var B=UIColor(red:0.07, green:0.14, blue:0.19, alpha:1.0)
    var D=UIColor(red:0.11, green:0.75, blue:0.80, alpha:1.0)
    var E=UIColor.white
    override func viewDidLoad() {
        layerGradient.colors=[C.cgColor,B.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        layerGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        self.tabBar.layer.insertSublayer(layerGradient, below: self.tabBar.layer.sublayers?[0])
        self.tabBar.tintColor = D
        //self.tabBar.unselectedItemTintColor=E
        self.tabBar.unselectedItemTintColor=E
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
