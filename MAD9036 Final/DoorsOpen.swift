//
//  DoorsOpen.swift
//  MAD9036 Final
//
//  Created by Ryan Bowes on 2017-12-10.
//  Copyright © 2017 Algonquin College. All rights reserved.
//

import Foundation

class DoorsOpen {
    var ApiUrl: String =  "https://doors-open-ottawa.mybluemix.net/"
    var Buildings: [Building]? = []
    var instance: DoorsOpen!
    
    init () {
        instance = self
    }
    
    func prepareRequest( URLString: String, extra: Any?, completion: ((Data, Any?) -> Void)? ) {
        let fullString = ApiUrl + URLString
        let tempUrl = fullString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url: URL! = URL(string: tempUrl!)
        
        let request: URLRequest = URLRequest(url: url)
        
        let session: URLSession = URLSession.shared
        
        // Make the specific task from the session by passing in your request
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                guard responseError == nil else {
                    return
                }
                
                guard let jsonData = responseData else {
                    _ = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    return
                }
                
                completion?(jsonData, extra)
            }
        }
        
        // Tell the task to run
        task.resume()
    }
}
