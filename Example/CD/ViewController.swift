//
//  ViewController.swift
//  CD
//
//  Created by liucaide on 12/14/2018.
//  Copyright (c) 2018 liucaide. All rights reserved.
//

import UIKit
import CD

import Config

class ViewController: UIViewController {
    
    
    
    lazy var vm:VM_ViewController = {
        return VM_ViewController()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Config.font.name)
        print(Config.font.fitSizeiPhone320)
        print(Config.font.fitSizeiPhone375)
        print(Config.font.fitSizeiPhone414)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}


extension ViewController:UITableViewDelegate, UITableViewDataSource{
    public func numberOfSections(in tableView: UITableView) -> Int {
        let num = vm.forms.count
        return num
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forms[section].count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = vm.forms[indexPath.section][indexPath.row]
        return row.h
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.forms[indexPath.section][indexPath.row]
        let cell = tableView.cd.cell(row.viewClass, bundleFrom:row.bundleFrom)
        row.bind(cell!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                _ = UIAlertController(title: "提示", message: nil, preferredStyle: .alert).cd.action("取消") { (a) in
                        print_cd(UIApplication.shared.keyWindow)
                    }
                    .action("确定") { (a) in
                        print_cd(UIApplication.shared.delegate?.window)
                }.show(self)
                print_cd(UIApplication.shared.keyWindow)
                print_cd(UIApplication.shared.delegate!.window!!)
            default:
                break
            }
        }
    }
}

