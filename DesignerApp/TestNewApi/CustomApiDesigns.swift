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

class ApiNetwoking {
    
    static let shared = ApiNetwoking()
    
    func fetchDesigns(completion: @escaping (Result<[CustomApi], Error>) -> ()) {
        
        let urlString = "http://localhost:1337/posts"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            DispatchQueue.main.async {
                if let err = error {
                    print("Failed to fetch: ", err.localizedDescription)
                    completion(.failure(err))
                    return
                }
                
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let designs = try decoder.decode([CustomApi].self, from: data)
                    completion(.success(designs))
                    
                } catch let err {
                    print(err)
                    completion(.failure(err))
                }
                
            }
        }.resume()
    }
    
    func createDesign(title: String, body: String, completion: (Error?) -> ()) {
        guard let url = URL(string: "http://localhost:1337/post") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let parms = ["title": title, "postBody": body]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parms, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, resp, error) in
//                guard let data = data else { return }
                
            }.resume()
            
        } catch {
            completion(error)
        }
    }
    
    func deleteDesign(id: Int, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "http://localhost:1337/post/\(id)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, error) in
//            guard let data = data else { return }
            DispatchQueue.main.async {
                if let err = error {
                    completion(err)
                }
                print("Deleted")
                completion(nil)
            }
        }.resume()
    }
    
}

class CustomApiDesigns: UITableViewController {
    
    fileprivate var customApi = [CustomApi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ha"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(handleNewDesign))
        //        navigationController?.navigationBar.barTintColor = .yellow
        
        fetchAllDesigns()
    }
    
    fileprivate func fetchAllDesigns() {
        
        ApiNetwoking.shared.fetchDesigns { (res) in
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
        ApiNetwoking.shared.createDesign(title: "iOS title", body: "iOS body") { (err) in
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
            ApiNetwoking.shared.deleteDesign(id: design.id) { (err) in
                if let err = err {
                    print("Failed to delete", err)
                    return
                }
                print("Row Deleted")
//                self.customApi.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.fetchAllDesigns()
            }
        }
    }
}
