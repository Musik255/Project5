//
//  TableViewController.swift
//  Project5
//
//  Created by Павел Чвыров on 17.11.2023.
//

import UIKit

class TableViewController: UITableViewController {

    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "site", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = websites[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    

  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let siteViewer = storyboard?.instantiateViewController(withIdentifier: "siteViewer") as? ViewController else{
            return
        }
        siteViewer.websites = websites
        siteViewer.firstWeb = websites[indexPath.row]
        navigationController?.pushViewController(siteViewer, animated: true)
    }
}
