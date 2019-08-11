//
//  Netwoking.swift
//  DesignerApp
//
//  Created by Moe on 29/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import Foundation

class Networking {
    
    static let shared = Networking()
    
    func fetch(completion: @escaping (Result<[CustomApi], Error>) -> ()) {
        
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
