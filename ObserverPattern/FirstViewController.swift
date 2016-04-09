//
//  FirstViewController.swift
//  ObserverPattern
//
//  Created by Sanjay Noronha on 2016/04/09.
//  Copyright © 2016 funza Academy. All rights reserved.
//

import UIKit

let notificationCtr = NSNotificationCenter.defaultCenter()

class FirstViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var myLabel: UILabel!
    
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCtr.addObserver(self, selector: "notifyObservers", name: MyNotifications.broadcast, object: self)
    }
    
    // MARK: Observer Selector functions
    func notifyObservers(){
        myLabel.text = " I got Notified"
    }
    
    // MARK: IBAction
    @IBAction func doBroadcast(sender: AnyObject) {
        
        notificationCtr.postNotificationName(MyNotifications.broadcast, object: self)
        
    }
    
    // MARK: Deinit
    deinit {
        notificationCtr.removeObserver(self)
    }


}

