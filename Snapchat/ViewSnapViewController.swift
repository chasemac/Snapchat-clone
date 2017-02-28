//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Chase McElroy on 2/25/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (errpr) in
            
            print("we deleted this pic")
        }
    }
    
    
    
    
}
