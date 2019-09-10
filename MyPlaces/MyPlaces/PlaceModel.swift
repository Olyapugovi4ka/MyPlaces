//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by MacBook on 10/09/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

struct Place {
    var name: String
    var location: String
    var type: String
    var image: String
    
    static let restaurants = ["Ollis", "Zenit", "Dodo Pizza"]
    static func getPlaces() -> [Place] {
        var places = [Place]()
        for place in restaurants {
            places.append(Place(name: place, location: "Spb", type: "Restaurant", image: place))
        }
        
        return places
    }
}
