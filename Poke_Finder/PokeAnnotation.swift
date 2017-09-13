//
//  PokeAnnotation.swift
//  Poke_Finder
//
//  Created by Raivis on 13/09/2017.
//  Copyright © 2017 Raivis. All rights reserved.
//

import Foundation
import MapKit

let pokemon = ["test1","test2"]

class PokeAnnotation: NSObject,MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var pokemonNumber: Int
    var pokemonName: String
    var title: String?
    
    init (coordinate: CLLocationCoordinate2D, pokemonNumber: Int) {
        self.coordinate = coordinate
        self.pokemonNumber = pokemonNumber
        self.pokemonName = pokemon[pokemonNumber - 1].capitalized
        self.title = self.pokemonName
    }
    
}
