//
//  ViewController.swift
//  OnOFF
//
//  Created by Namasang Yonzan on 14/11/17.
//  Copyright © 2017 Namasang Yonzan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ViewController: UIViewController {
    //MARK: Variables
    var ref: DatabaseReference!
    var value: Int!
    //MARK: Outlets
    
    @IBOutlet weak var powerView: UIView!
    @IBOutlet weak var device: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    //MARK: VC life
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.switch.isHidden = true
        deviceStatus()
    }
    //MARK: Device Status
    func deviceStatus()  {
        ref.child("device").observe(.value) { (snapshot) in
            let value = snapshot.value as! [String:Any]
            let status = value["value"] as? Int ?? 0
            self.switch.isHidden = false
            status == 1 ? self.on() : self.off()
        }
    }
    //MARK: Device is ON
    func on() {
        self.device.text = "ON"
        self.switch.isOn = true
        self.powerView.isHidden = false
    }
    //MARK: Device is off
    func off() {
        self.device.text = "OFF"
        self.switch.isOn = false
        self.powerView.isHidden = true
    }
    //MARK: Switch action
    @IBAction func `switch`(_ sender: UISwitch) {
        if (sender.isOn == true){
            value = 1
            setDevice()
        }else {
            value = 0
            setDevice()
        }
    }
    //MARK: SetValue
    func setDevice() {
        self.ref.child("device").setValue(["value": value])
    }
    
    @IBAction func btn(_ sender: UIButton) {
        if powerView.isHidden == true {
            value = 1
            setDevice()
        }else{
            value = 0
            setDevice()
        }
    }
    
    


}

