//
//  Building.swift
//  MAD9036 Final
//
//  Created by Ryan Bowes on 2017-12-10.
//  Copyright © 2017 Algonquin College. All rights reserved.
//

import Foundation

struct TranslatedString {
    let EN: String?
    let FR: String?
}

struct Location {
    let Address: String?
    let City: String?
    let Province: String?
    let PostalCode: String?
    let Longitude: String?
    let Latitude: String?
}

struct ImageData {
    let Image: String?
    let Description: TranslatedString?
}

struct BuildingCategory {
    let ID: Int?
    let Name: TranslatedString?
}

class Building {
    var ID: String?
    var buildingID: Int?
    var name: TranslatedString?
    var category: BuildingCategory?
    var location: Location?
    var image: ImageData?
    var updatedAt: Date?
    var createdAt: Date?
    var sundayClose: String?
    var sundayStart: String?
    var saturdayClose: String?
    var saturdayStart: String?
    var isNewBuilding: Bool?
    
    public init() {
        
    }
    convenience init(building: [[String: Any]]) {
        self.init()
        
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
