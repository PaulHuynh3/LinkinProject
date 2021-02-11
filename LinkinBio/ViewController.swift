//
//  ViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-11.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET, "https://app.latergram.me/api/pub/profiles.json?social_profile=latermedia", parameters: [:])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.result)     // server data

                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

