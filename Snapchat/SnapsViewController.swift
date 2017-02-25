//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Chase McElroy on 2/24/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        print("logouttapped")
        dismiss(animated: true, completion: nil)
        
    }

}
