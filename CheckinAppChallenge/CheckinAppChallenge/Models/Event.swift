//
//  Event.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

struct Event {
    var id: String
    var title: String
    var price: Double
    var latitude: Double?
    var longitude: Double?
    var image: String
    var description: String
    var date: Int
    var people: [People]?
}

enum EventKeys: String, CodingKey {
    case id
    case title
    case price
    case latitude
    case longitude
    case image
    case description
    case date
    case people
}

extension Event: Decodable {
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: EventKeys.self)
       
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.price = try container.decode(Double.self, forKey: .price)
        
        let doubleLatitude = try? container.decode(Double.self, forKey: .latitude)
        let stringLatitude = try? container.decode(String.self, forKey: .latitude)
        self.latitude = doubleLatitude ?? Double(stringLatitude ?? "0.0")
        
        let doubleLongitude = try? container.decode(Double.self, forKey: .longitude)
        let stringLongitude = try? container.decode(String.self, forKey: .longitude)
        self.longitude = doubleLongitude ?? Double(stringLongitude ?? "0.0")
        
        self.image = try container.decode(String.self, forKey: .image)
        self.description = try container.decode(String.self, forKey: .description)
        self.date = try container.decode(Int.self, forKey: .date)
        self.people = try container.decode([People].self, forKey: .people)
    }
}



