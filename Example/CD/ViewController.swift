//
//  ViewController.swift
//  CD
//
//  Created by liucaide on 12/14/2018.
//  Copyright (c) 2018 liucaide. All rights reserved.
//

import UIKit
import CD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let al = UIAlertController()
        al.cd.show(self, block: nil)
        
    }

    @IBAction func clickButton(_ sender: UIButton) {
        VC_TestOne.show(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

