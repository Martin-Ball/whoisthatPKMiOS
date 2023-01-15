//
//  PokemonManager.swift
//  who is that pokemon
//
//  Created by Martin Ballester on 14/01/2023.
//

import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel])
    func didFailWithError(error: Error)
}

struct PokemonManager {
    let pokemonURL: String = "https://pokeapi.co/api/v2/pokemon?limit=898"
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemonApi(){
        performRequest(url: pokemonURL)
    }
    
    private func performRequest(url urlString: String){
        //Step for consume a url
        //1. Create/get URL
        if let url = URL(string: urlString){
            //2. Create the URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url){ data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data{
                    if let pokemon = self.parseJSON(pokemonData: safeData){
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    private func parseJSON(pokemonData: Data) -> [PokemonModel]?{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map{
                PokemonModel(name: $0.name ?? "", imageURL: $0.url ?? "")
            }
            
            return pokemon
        }catch{
            return nil
        }
    }
}
