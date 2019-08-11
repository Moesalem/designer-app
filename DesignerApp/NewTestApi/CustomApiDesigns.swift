//
//  CustomApiDesigns.swift
//  DesignerApp
//
//  Created by Moe on 21/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//
import UIKit

struct CustomApi: Decodable {
    let id: Int
    let title, body: String
}

class CustomApiDesigns: UITableViewController {
    
    fileprivate var customApi = [CustomApi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Ha"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(handleNewDesign))
        
        fetchAllDesigns()
    }
    
    fileprivate func fetchAllDesigns() {
        
        Networking.shared.fetch { (res) in
            switch res{
            case .failure(let err):
                print(err)
            case .success(let designs):
                self.customApi = designs
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func handleNewDesign() {
        Networking.shared.createDesign(title: "iOS title", body: "iOS body") { (err) in
            if let err = err {
                print(err)
                return
            }
            print("Created")
            self.fetchAllDesigns()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customApi.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        cell.textLabel?.text = customApi[indexPath.row].title
        cell.detailTextLabel?.text = customApi[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let design = customApi[indexPath.row]
            Networking.shared.deleteDesign(id: design.id) { (err) in
                if let err = err {
                    print("Failed to delete", err)
                    return
                }
                print("Row Deleted")
                self.customApi.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
