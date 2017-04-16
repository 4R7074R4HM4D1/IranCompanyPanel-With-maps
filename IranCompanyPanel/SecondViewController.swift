//
//  SecondViewController.swift
//  IranCompanyPanel
//
//  Created by Ryo on 11/29/1395 AP.
//  Copyright © 1395 Ryo. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class SecondViewController: UIViewController {
    var camera=GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0);
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
       //         // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bckg.jpg")!)
        GMSServices.provideAPIKey("AIzaSyA1aTw9Bzz13ezxIGHeGvjsIFby1jOu1Ic")
        var MAP=GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "dark", withExtension: "json") {
                MAP.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }       // MAP.mapStyle
        view=MAP

    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

