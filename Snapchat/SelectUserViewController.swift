//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Chase McElroy on 2/24/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
    //UISearchResultsUpdating
{
    var userEmails : [String] = []
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    var searchController : UISearchController!
    var resultsConroller = UITableViewController()
    
    //    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.searchController = UISearchController(searchResultsController: self.resultsConroller)
        self.tableView.tableHeaderView = self.searchController.searchBar
        //       self.searchController.searchResultsUpdater = self
        
        //  createSearchBar()
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            let user = User()
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            print("email: -> \(user.email)")
            user.uid = snapshot.key
            self.userEmails.append(user.email)
            self.users.append(user)
            print("appended")
            self.tableView.reloadData()
            
            
        })
        
    }
    
    //    func updateSearchResults(for searchController: UISearchController) {
    //        // Filter through
    //        self.users.filter { (User:String) -> Bool in
    //            return true
    //        }
    //
    //        //update results tableview
    //
    //
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let snap = ["from":FIRAuth.auth()!.currentUser!.email!, "description":descrip, "imageURL":imageURL, "uuid":uuid]
        
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        print("USER EMAILS -----> \(userEmails)")
        navigationController!.popToRootViewController(animated: true)
    }
    
    //    func createSearchBar() {
    //    let searchBar = UISearchBar()
    //        searchBar.showsCancelButton = false
    //        searchBar.placeholder = "Enter Search"
    //        searchBar.delegate = self
    //        
    //        self.navigationItem.titleView = searchBar
    //    }
    
    
}
