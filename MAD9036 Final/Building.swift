//
//  Building.swift
//  MAD9036 Final
//
//  Created by Ryan Bowes on 2017-12-10.
//  Copyright © 2017 Algonquin College. All rights reserved.
//

import Foundation

// Allows searching the dictionary by key
extension Dictionary where Key == String {
    func findByKey (Key: String) -> Any? {
        var value: Any = ""
        for item in self {
            if item.key == Key {
                value = item.value as Any
            }
        }
        return value
    }
}

struct Building: Codable
{
    let id: String
    let buildingID: Int
    let nameEN: String
    let nameFR: String
    let descriptionEN: String
    let descriptionFR: String
    let categoryEN: String
    let categoryFR: String
    let categoryID: Int
    let longitude: Double
    let latitude: Double
    let postalCode: String
    let province: String
    let city: String
    let addressEN: String
    let addressFR: String
    let image: String
    var imageData: Data?
    let imageDescriptionEN: String
    let imageDescriptionFR: String
    let sundayClose: String?
    let sundayStart: String?
    let saturdayClose: String?
    let saturdayStart: String?
    let isNewBuilding: Bool
    let vIndex: Int?
    let updatedAt: String?
    let createdAt: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case buildingID = "buildingId"
        case nameEN
        case nameFR
        case descriptionEN
        case descriptionFR
        case categoryEN
        case categoryFR
        case categoryID = "categoryId"
        case longitude
        case latitude
        case postalCode
        case province
        case city
        case addressEN
        case addressFR
        case image
        case imageData
        case imageDescriptionEN
        case imageDescriptionFR
        case sundayClose
        case sundayStart
        case saturdayClose
        case saturdayStart
        case isNewBuilding
        case vIndex = "__v"
        case updatedAt
        case createdAt
    }
    
    init?(data: Data)
    {
        do
        {
            self = try JSONDecoder().decode(Building.self, from: data)
        }
        catch let error
        {
            print("Failed parsing JSON: \(error)")
            return nil
        }
    }
    
    func saveImage() {
        let ID = "Building-" + String(self.buildingID)
        let defaults = UserDefaults.standard
        
        defaults.set(self.imageData, forKey: ID)
    }
    
    mutating func loadImage(completion: (() -> Void)) {
        let defaults = UserDefaults.standard
        let data = defaults.data(forKey: "Building-" + String(self.buildingID))
        self.imageData = data
        completion()
    }
    
    func encode(with aCoder: NSCoder)
    {
        do {
            try JSONEncoder().encode(self)
        } catch let error {
            print ("Failed to encode JSON: \(error)")
        }
    }
}
