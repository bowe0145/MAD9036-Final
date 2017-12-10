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
    func findByKey (Key: String) -> Any {
        var value: Any = ""
        for item in self {
            if item.key == Key {
                value = item.value as Any
            }
        }
        return value
    }
}

// Translated string allows for french and english
struct TranslateableString {
    var EN: String
    var FR: String
    
    init (EN: String, FR: String) {
        self.EN = EN
        self.FR = FR
    }
    init (building: Dictionary<String, Any>) {
        self.EN = building.findByKey(Key: "nameEN") as! String
        self.FR = building.findByKey(Key: "nameFR") as! String
    }
}

struct Location {
    var Address: TranslateableString
    var City: String
    var Province: String
    var PostalCode: String
    var Longitude: Double
    var Latitude: Double
    
    init(building: Dictionary<String, Any>) {
        self.Address = TranslateableString(
            EN: building.findByKey(Key: "addressEN") as! String,
            FR: building.findByKey(Key: "addressFR") as! String
        )
        self.City = building.findByKey(Key: "city") as! String
        self.Province = building.findByKey(Key: "province") as! String
        self.PostalCode = building.findByKey(Key: "postalCode") as! String
        self.Longitude = building.findByKey(Key: "longitude") as! Double
        self.Latitude = building.findByKey(Key: "latitude") as! Double
    }
}

struct BuildingImage {
    let Image: String
    let Description: TranslateableString
    
    init (building: Dictionary<String, Any>) {
        self.Image = building.findByKey(Key: "image") as! String
        self.Description = TranslateableString(
            EN: building.findByKey(Key: "imageDescriptionEN") as! String,
            FR: building.findByKey(Key: "imageDescriptionFR") as! String
        )
    }
}

struct BuildingCategory {
    let ID: Int
    let Name: TranslateableString
    
    init (building: Dictionary<String, Any>) {
        self.ID = building.findByKey(Key: "buildingID") as! Int
        self.Name = TranslateableString(
            EN: building.findByKey(Key: "nameEN") as! String,
            FR: building.findByKey(Key: "nameFR") as! String
        )
    }
}

class Building {
    var ID: String?
    var buildingID: Int?
    var name: TranslateableString?
    var category: BuildingCategory?
    var location: Location?
    var image: BuildingImage?
    var updatedAt: Date?
    var createdAt: Date?
    var sundayClose: String?
    var sundayStart: String?
    var saturdayClose: String?
    var saturdayStart: String?
    var isNewBuilding: Bool?
    
    public init() {
        
    }
    
    // Convenience init for a single building
    convenience init(building: Dictionary<String, Any>) {
        self.init()
        self.location = Location(building: building)
        self.name = TranslateableString(building: building)
        self.category = BuildingCategory(building: building)
        self.image = BuildingImage(building: building)
    }
}

/*
"__v": 0,
"buildingId": 166,
"updatedAt": "2017-10-19T18:43:03.632Z",
"createdAt": "2017-10-19T18:43:03.632Z",
"nameEN": "hurdleg",
"_id": "59e8f2372d5e3e0f386247c7",
"categoryFR": "Autres",
"categoryId": 10,
"longitude": -75.75615920000001,
"latitude": 45.3497531,
"postalCode": "K2G 1V8",
"province": "ON",
"city": "Ottawa",
"imageDescriptionFR": "Home of the Mobile Application Design & Development (MAD&D) program at Algonquin College in Ottawa, Ontario, Canada",
"imageDescriptionEN": "Home of the Mobile Application Design & Development (MAD&D) program at Algonquin College in Ottawa, Ontario, Canada",
"image": "images/noimagefound.jpg",
"sundayClose": "2017-06-04 16:00",
"sundayStart": "2017-06-04 10:00",
"saturdayClose": "2017-06-03 16:00",
"saturdayStart": "2017-06-03 10:00",
"categoryEN": "Other",
"addressFR": "1385, avenue Woodroffe",
"addressEN": "1385 Woodroffe Ave.",
"isNewBuilding": false,
"nameFR": "MAD&D Lab, Algnoquin College (Woodroffe Campus)"
*/
