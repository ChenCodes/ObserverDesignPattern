//
//  SecondViewController.swift
//  ObserverPattern
//
//  Created by Sanjay Noronha on 2016/04/09.
//  Copyright © 2016 funza Academy. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var myLabel: UILabel!
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCtr.addObserver(self, selector: "notifyObservers", name: MyNotifications.broadcast, object: nil )
    }

    // MARK: Observer Selector functions
    func notifyObservers(){
        myLabel.text = " I got Notified Too"
    }

    // MARK: Deinit
    deinit {
        notificationCtr.removeObserver(self)
    }

}

