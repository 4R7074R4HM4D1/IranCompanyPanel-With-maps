//
//  SettimeAndDate2.swift
//  IranCompanyPanel
//
//  Created by Ryo on 12/22/1395 AP.
//  Copyright © 1395 Ryo. All rights reserved.
//

import UIKit

class SettimeAndDate2: UIViewController {
    @IBOutlet var To_Day: UILabel!
    @IBOutlet var To_Month: UILabel!
    @IBOutlet var To_Year: UILabel!
    @IBOutlet var To_Time: UILabel!
    @IBOutlet var To_AMPM: UILabel!
    @IBOutlet var From_Year: UILabel!
    @IBOutlet var From_Month: UIView!
    @IBOutlet var From_Day: UILabel!
     @IBOutlet var From_Time: UILabel!
    @IBOutlet var From_AMPM: UILabel!
    @IBOutlet var nav_bar: UINavigationBar!
    @IBOutlet var second_navbar: UINavigationBar!
   // @IBOutlet var secondnav_bar: UINavigationBar!
    //@IBOutlet var nav_bar: UINavigationBar!
    //@IBOutlet var Done: UIBarButtonItem!
    //@IBOutlet var Cancel: UIBarButtonItem!
    
    //fileprivate weak var calendar: FSCalendar!
    //fileprivate weak var eventLabel: UILabel!
    var StartDate=Date()
    var selected_start=0;
    var EndDate=Date()
    var selected_end=0;
    var C=UIColor(red:0.00, green:0.72, blue:0.83, alpha:1.0)
    var B=UIColor(red:0.00, green:0.90, blue:1.00, alpha:1.0)
    let layerGradient = CAGradientLayer()
    let secondlayerGradient = CAGradientLayer()
    var blureffect = UIBlurEffect(style: .dark)
    var Got_Date:[String] = []
    var Got_Time:[String] = []
    let blurredEffectView = UIVisualEffectView()
    let Persian_months:[String]=["Farvardin","Ordibehesht","Khordad","Tir","Mordad","Shahrivar","Mehr","Aban","Azar","Dey","Bahman","Esfand"]

    override func viewDidLoad() {
        blurredEffectView.effect=blureffect
        blurredEffectView.frame = view.bounds
        self.view.addSubview(blurredEffectView)
        self.view.sendSubview(toBack: blurredEffectView)
        super.viewDidLoad()
        layerGradient.colors=[C.cgColor,B.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        layerGradient.frame=nav_bar.bounds
        self.nav_bar.layer.insertSublayer(layerGradient, below: self.nav_bar.layer.sublayers?[0])
        secondlayerGradient.colors=[C.cgColor,B.cgColor]
        secondlayerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        secondlayerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        secondlayerGradient.frame=second_navbar.bounds
        self.second_navbar.layer.insertSublayer(secondlayerGradient, below: self.second_navbar.layer.sublayers?[0])
        
        
        

        // Do any additional setup after loading the view.
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

    @IBAction func Set(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion:nil)
    }
    @IBAction func exit(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion:nil)
    }
}






