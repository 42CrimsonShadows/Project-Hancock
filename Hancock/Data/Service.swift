//
//  Service.swift
//  Hancock
//
//  Created by Casey Kawamura on 3/31/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import Foundation

class Service {
    
    

    //MARK: --CREATE(POST)
    //All these functions are created for adding new entries to the database
    
    //Register new users
    static func register() {
        struct user: Codable {
            var firstName: String
            var lastName: String
            var username: String
            var password: String
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let test = user(firstName: "tester", lastName: "testing", username: "covid", password: "19")
        do{
            let endpoint = "https://abcgoapp.org/api/users/register"
            let data = try encoder.encode(test)
            guard let url = URL(string: endpoint) else {
                print("Could not set the URL, contact the developer")
                return
                
            }
                //print(String(data: data, encoding: .utf8)!)
        
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.httpMethod = "POST"
            request.httpBody = data
        
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    //Ping(text: error.localizedDescription, style: .danger).show()
                    print(error)
                }
            }.resume()
        
        } catch {
            print("Could not encode")
        }
    }
    
    //MARK: --READ(GET)
    //These functions will return a value from the database
    
    
    
    //MARK: --UPDATE(PUT)
    //These will edit an existing entry in the database
    
    //MARK: --Destroy(DELETE)
    //These will remove an entry from the database1
    
}
