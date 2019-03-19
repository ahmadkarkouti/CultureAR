//
//  Models.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import Foundation
import UIKit

struct User {
    let id: String
    let name: String
    let email: String
    let image: String
    
    init(id: String, dictionary: [String:String]) {
        self.id = id
        self.name = dictionary["Name"].unwrap
        self.email = dictionary["Email"].unwrap
        self.image = dictionary["Image"].unwrap
    }
}

enum Interest: String {
    case Technology = "Technology"
    case History = "History"
    case Arts = "Arts"
}

struct Event {
    let id: String
    let eventName: String
    let eventDescription: String
    let eventImage: String
    let imageHeight: Float
    
    init(id: String, dictionary: [String:Any]) {
        self.id = id
        self.eventName = (dictionary["Name"] as? String).unwrap
        self.eventDescription = (dictionary["Description"] as? String).unwrap
        self.eventImage = (dictionary["Image"] as? String).unwrap
        self.imageHeight = (dictionary["ImageHeight"] as? Float).unwrap
    }
}

struct Organisation: Decodable {
    let organisationID: String
    let organisationName: String
    let organisationInterest: Interest.RawValue
}


extension Optional where Wrapped == String {
    var unwrap: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Float {
    var unwrap: Float {
        return self ?? 0
    }
}
