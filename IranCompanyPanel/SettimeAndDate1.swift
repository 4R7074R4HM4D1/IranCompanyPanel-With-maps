//
//  SettimeAndDate.swift
//  IranCompanyPanel
//
//  Created by Ryo on 12/3/1395 AP.
//  Copyright © 1395 Ryo. All rights reserved.
//

import UIKit
import FSCalendar
class SettimeAndDate1: UIViewController,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    fileprivate let gregorian = Calendar(identifier: .persian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter
    }()
    
    @IBOutlet var calendar_view: UIView!
    @IBOutlet var To_Day: UILabel!
    @IBOutlet var To_Month: UILabel!
    @IBOutlet var To_Year: UILabel!
    @IBOutlet var dayornight: UILabel!
    @IBOutlet var time_num: UILabel!
    @IBOutlet var day: UILabel!
    @IBOutlet var month: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var secondnav_bar: UINavigationBar!
    @IBOutlet var nav_bar: UINavigationBar!
    @IBOutlet var Done: UIBarButtonItem!
    @IBOutlet var Cancel: UIBarButtonItem!
    
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
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
    let Persian_months:[String]=["Farvardin","Ordibehesht","Khordad","Tir","Mordad","Shahrivar","Mehr","Aban","Azar","Dey","Bahman","Esfand"]
    override func viewDidLoad() {
        let blurredEffectView = UIVisualEffectView(effect: blureffect)
        blurredEffectView.frame = view.bounds
        self.view.addSubview(blurredEffectView)
        self.view.sendSubview(toBack: blurredEffectView)
        self.view.backgroundColor = UIColor.clear
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
        
        let View = UIView(frame: UIScreen.main.bounds)
        View.backgroundColor = UIColor.groupTableViewBackground
        self.calendar_view = View
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 300
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 64, width: View.frame.size.width, height: height))
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.calendarHeaderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        calendar.calendarWeekdayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today = nil // Hide the today circle
        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.clipsToBounds = true // Remove top/bottom line
        
        calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        
        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
        calendar.addGestureRecognizer(scopeGesture)
        

        
               super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EXIT(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion:nil)
    }
    
    
    
    
    @IBAction func Set(_ sender: Any) {
       // var storyboard = UIStoryboard(name: "ReportsViewController", bundle: )
        //let myVC = storyboard?.instantiateViewController(withIdentifier: "ReportsView") as! ReportsViewController
        //var controller  = storyboard.instantiateViewController(withIdentifier: "timeAndDate1") as! ReportsViewController
        //print(controller.FromDay)

      //  myVC.FromDay.text=Got_Date[0]
       // myVC.FromMonth.text=Persian_months[Int(Got_Date[1])!-1]
       // myVC.FromYear.text=Got_Date[2]
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion:nil)
        
    }
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if self.gregorian.isDateInToday(date) {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            let result = formatter.string(from: date)
            if  result.hasPrefix("0")
            {
                let E = result[result.index(result.startIndex,offsetBy:1)]
                return String(E)
            }
            
            return result
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 2
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
        //self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
       // calendar.selectedDates.append(Date())
        print(calendar.selectedDates)
        if(selected_start==0)
            {
                StartDate=date
                calendar.end_Date=date
                calendar.start_Date=date
                EndDate=date
                selected_start=1
                
                
        
        }
        else if (date<StartDate)
            {
                StartDate=date;
                calendar.start_Date=StartDate;
            }
        else  if(date > EndDate)
            {
                
                EndDate=date;
                calendar.end_Date=EndDate
            }
       // var RSA=date.timeIntervalSince(EndDate)
        print("StartDate is \(self.formatter.string(from: StartDate))")
        print("EndDate is \(self.formatter.string(from: EndDate))")
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
        
        var Deselected_Date = self.formatter.string(from: date).components(separatedBy: " ")
        var End_Date=self.formatter.string(from: EndDate).components(separatedBy: " ")
        var Start_Date=self.formatter.string(from: StartDate).components(separatedBy: " ")
        var DD=Int(Deselected_Date[0])!
        var SD=Int(Start_Date[0])!
        var ED=Int(End_Date[0])!
        if(DD-SD<ED-DD){StartDate=date
        calendar.start_Date=StartDate}
        else if(DD-SD>ED-DD){EndDate=date
        calendar.end_Date=EndDate}
        else
            {
                 DD=Int(Deselected_Date[1])!
                 SD=Int(Start_Date[1])!
                 ED=Int(End_Date[1])!
                if(DD-SD<ED-DD){StartDate=date
                calendar.start_Date=StartDate}
                else if(DD-SD>ED-DD){EndDate=date
                calendar.end_Date=EndDate}
                else
                    {
                        DD=Int(Deselected_Date[2])!
                        SD=Int(Start_Date[2])!
                        ED=Int(End_Date[2])!
                        if(DD-SD<ED-DD)
                        {StartDate=Calendar.current.date(byAdding: .day, value: 1, to: StartDate)!
                        calendar.start_Date=StartDate}
                        else if(DD-SD>ED-DD){EndDate=Calendar.current.date(byAdding: .day, value: -1, to: EndDate)!
                        calendar.end_Date=EndDate}
                    }

        
        
        }
        print("StartDate is \(self.formatter.string(from: StartDate))")
        print("EndDate is \(self.formatter.string(from: EndDate))")

        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.orange]
        }
        return [appearance.eventDefaultColor]
    }
    
    // MARK: - Private functions
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! DIYCalendarCell)
        // Custom today circle
        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)
        // Configure selection layer
        if position == .current {
            
            var selectionType = SelectionType.none
            //print("INJA DARIM DOROST MIKONIM")
          //  print(calendar.selectedDates)
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar.selectedDates.contains(date) {
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if calendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
            
        } else {
            diyCell.circleImageView.isHidden = true
            diyCell.selectionLayer.isHidden = true
        }
    }
    
}




