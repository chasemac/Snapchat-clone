//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Chase McElroy on 2/24/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating
{
    var userEmails : [String] = []
    var filteredUserEmails  = [String]()
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    var searchController : UISearchController!
    var resultsConroller = UITableViewController()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
        self.resultsConroller.tableView.dataSource = self
        self.resultsConroller.tableView.dataSource = self
        
        self.searchController = UISearchController(searchResultsController: self.resultsConroller)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        
        //  createSearchBar()
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            let user = User()
            user.email = (snapshot.value as! NSDictionary)["email"] as! String

            user.uid = snapshot.key
            self.userEmails.append(user.email)
            self.users.append(user)

            self.tableView.reloadData()
            
            
        })
        
    }
    
        func updateSearchResults(for searchController: UISearchController) {
            // Filter through
            self.filteredUserEmails.filter { (emails:String) -> Bool in
                if emails.lowercased().contains(self.searchController.searchBar.text!.lowercased()) {
                    return true
                } else {
                    return false
                }
            }
    
            //update results tableview
            self.resultsConroller.tableView.reloadData()
    
    
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return userEmails.count
        } else {
            return self.filteredUserEmails.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if tableView == self.tableView {
            cell.textLabel?.text = userEmails[indexPath.row]
        } else {
            cell.textLabel?.text = filteredUserEmails[indexPath.row]
        }
        
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
