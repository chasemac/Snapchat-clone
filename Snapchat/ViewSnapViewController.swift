//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Chase McElroy on 2/25/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
label.text = snap.descrip
        
        
    }



}
