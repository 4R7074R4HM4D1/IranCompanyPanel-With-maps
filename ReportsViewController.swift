//
//  ReportsViewController.swift
//  IranCompanyPanel
//
//  Created by Ryo on 11/30/1395 AP.
//  Copyright © 1395 Ryo. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

var GotFrom_D:[UILabel] = []
var GotFrom_T:[UILabel] = []
var GotTo_D:[UILabel] = []
var GotTo_T:[UILabel] = []
class ReportsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
   
    @IBOutlet var Seperator: UIImageView!
    @IBOutlet var Seperator2: UIImageView!
    
   // @IBOutlet var RS: RangeCircularSlider!
    @IBOutlet var FromDay: UILabel!
    @IBOutlet var FromMonth: UILabel!
    @IBOutlet var FromYear: UILabel!
    @IBOutlet var From_Time: UILabel!
    @IBOutlet var From_PMAM: UILabel!
    
    
    @IBOutlet var ToYear: UILabel!
    @IBOutlet var ToMonth: UILabel!
    @IBOutlet var ToDay: UILabel!
    @IBOutlet var ToTime: UILabel!
    @IBOutlet var To_PMAM: UILabel!
    
    
    @IBOutlet var nav_bar: UINavigationBar!
    @IBOutlet var secondnav_bar: UINavigationBar!
   // @IBOutlet var Set_Date_To: UIButton!
    @IBOutlet var Set_Date_From: UIButton!
    @IBOutlet var Data: UITableView!
    var C=UIColor(red:0.00, green:0.72, blue:0.83, alpha:1.0)
    var B=UIColor(red:0.00, green:0.90, blue:1.00, alpha:1.0)
    var SEP=UIColor(red:0.46, green:0.46, blue:0.46, alpha:0.5)
    let layerGradient = CAGradientLayer()
    let secondlayerGradient = CAGradientLayer()
    var IMG=UIImage(named: "DateTime")
let Persian_months:[String]=["Farvardin","Ordibehesht","Khordad","Tir","Mordad","Shahrivar","Mehr","Aban","Azar","Dey","Bahman","Esfand"]
    var A=UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.03)
  
    var REP=["Select Report", "Daily Report","Over Speed", "Stop Points"]
    override func viewDidLoad() {
        Seperator.backgroundColor=SEP
        Seperator2.backgroundColor=SEP
        Set_Date_From.setImage(IMG, for: UIControlState.normal)
       // Set_Date_To.setImage(IMG, for: UIControlState.normal)
        
                layerGradient.colors=[C.cgColor,B.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        layerGradient.frame=nav_bar.bounds
        self.nav_bar.layer.insertSublayer(layerGradient, below: self.nav_bar.layer.sublayers?[0])
        
        secondlayerGradient.colors=[C.cgColor,B.cgColor]
        secondlayerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        secondlayerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        secondlayerGradient.frame=secondnav_bar.bounds
        self.secondnav_bar.layer.insertSublayer(secondlayerGradient, below: self.secondnav_bar.layer.sublayers?[0])
        
        GotFrom_D.append(FromDay)
        GotFrom_D.append(FromMonth)
        GotFrom_D.append(FromYear)
        GotFrom_T.append(From_Time)
        GotFrom_T.append(From_PMAM)
        
        GotTo_D.append(ToDay)
        GotTo_D.append(ToMonth)
        GotTo_D.append(ToYear)
        GotTo_T.append(ToTime)
        GotTo_T.append(To_PMAM)
        
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bckg.jpg")!)
        Data.backgroundColor=A;
        
        
        
        //From_Date.
      // From_Date.dat
        //From_Date.setValue(UIColor.white, forKeyPath: "Color")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return REP.count
    }    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return REP[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        REP[row]=REP[row]
    }
   
    @IBAction func FromDateTapped(_ sender: UIButton) {
        var selected_date=Date()
        var ER=Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.calendar = Calendar(identifier: .persian)
        DatePickerPopover.appearFrom(originView: sender, baseViewController: self, title: "From Date", dateMode: .date, initialDate: Date(), doneAction: {
            selected_date in Date()
            var dateInPersian = formatter.string(from: selected_date)
            var dateArr=dateInPersian.components(separatedBy: " ")
            self.FromYear.text=dateArr[0]
            var INDEX=Int(dateArr[1])!-1
            self.FromMonth.text=self.Persian_months[INDEX]
            self.FromDay.text=dateArr[2]

        
        }, cancelAction: {print("cancel")})
        
        
    }
    
    
    @IBAction func FromTimeTapped(_ sender: UIButton) {
DatePickerPopover.appearFrom(originView: sender, baseViewController: self, title: "From Time", dateMode: .time, initialDate: Date(), doneAction: { selectedDate in Date()

    let formatter = DateFormatter()
    formatter.dateFormat = "h mm a"
    formatter.timeZone = NSTimeZone.local
    let Time = formatter.string(from: selectedDate)
    var dateArr=Time.components(separatedBy: " ")
    print(dateArr)
    self.ToTime.text=dateArr[0]+":"+dateArr[1]
    self.To_PMAM.text=dateArr[2].uppercased()}, cancelAction: {print("cancel")})
        
    }
    @IBAction func ToDateTapped(_ sender: UIButton) {
        var selected_date=Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.calendar = Calendar(identifier: .persian)
        DatePickerPopover.appearFrom(originView: sender, baseViewController: self, title: "To Date", dateMode: .date, initialDate: Date(), doneAction: { selected_date in Date()
            let dateInPersian = formatter.string(from: selected_date)
            var dateArr=dateInPersian.components(separatedBy: " ")
            self.ToYear.text=dateArr[0]
            let INDEX=Int(dateArr[1])!-1
            self.ToMonth.text=self.Persian_months[INDEX]
            self.ToDay.text=dateArr[2]
            }, cancelAction: {print("cancel")})
    }
    
    @IBAction func ToTIme(_ sender: UIButton) {
        DatePickerPopover.appearFrom(originView: sender, baseViewController: self, title: "To Time", dateMode: .time, initialDate: Date(), doneAction: { selectedDate in Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "h mm a"
            formatter.timeZone = NSTimeZone.local
            let Time = formatter.string(from: selectedDate)
            var dateArr=Time.components(separatedBy: " ")
            print(dateArr)
            self.ToTime.text=dateArr[0]+":"+dateArr[1]
            self.To_PMAM.text=dateArr[2].uppercased()
        
        }, cancelAction: {print("cancel")})
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
