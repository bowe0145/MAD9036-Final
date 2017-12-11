//
//  DoorsOpen.swift
//  MAD9036 Final
//
//  Created by Ryan Bowes on 2017-12-10.
//  Copyright © 2017 Algonquin College. All rights reserved.
//

import Foundation

class DoorsOpen {
    var ApiUrl: URL = URL(string: "https://doors-open-ottawa.mybluemix.net/buildings")!
    var Buildings: [Building]? = []
    var delegate: sendBuildings?
    
    init () {
        loadBuildings()
    }
    
    
    
    func loadBuildings() {
        
        // Create the request object and pass in your url
        let myRequest: URLRequest = URLRequest(url: ApiUrl)
        
        // Create the URLSession object that will make the request
        let session: URLSession = URLSession.shared
        
        // The data task retrieves the data.
        let dataTask = session.dataTask(with: myRequest) {
            (data, response, error) -> Void in
            
            guard error == nil, let data = data else {
                print("ERROR")
                return
            }
            
            do {
                if let buildings = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
                    for building in buildings {
                        let tempBuilding: Building = Building(building: building)
                        self.Buildings?.append(tempBuilding)
                    }
                }
            } catch let jsonError {
                // An error occurred while trying to convert the data into a Swift dictionary.
                print("JSON error description: \(jsonError)")
            }
            
            // This callback is run on a secondary thread, so you must make any UI changes on the main thread by calling the DispatchQueue.main.async() method
            DispatchQueue.main.async() {
                
                guard let theBuildings = self.Buildings, self.Buildings?.count != nil else {
                    return
                }
                self.delegate?.sendBuildings(buildings: theBuildings)
            }
        }
        dataTask.resume()
    }
    
}
