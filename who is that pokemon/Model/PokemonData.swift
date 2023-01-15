//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by Martin Ballester on 14/01/2023.
//

import Foundation

struct PokemonData: Codable {
    let results: [Result]?
}

struct Result: Codable {
    let name: String?
    let url: String?
}
