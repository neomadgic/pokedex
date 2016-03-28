//
//  Pokemon.swift
//  pokedex
//
//  Created by Vu Dang on 3/8/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    private var _nextEvolutionText: String!
    private var _pokemonUrl: String!
    
    var name: String
    {
        return _name
    }
    
    var pokedexId: Int
    {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int)
    {
        self._name = name
        self._pokedexId = pokedexId;
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    func downloadPokemonDetails(completed: DownloadComplete)
    {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON
            { (response: Response<AnyObject, NSError>) -> Void in
                if let dict = response.result.value as? Dictionary<String, AnyObject>
                {
                    if let weight = dict["weight"] as? String
                        {
                            self._weight = weight;
                        }
                    if let height = dict["height"] as? String
                        {
                            self._height = height;
                        }
                    if let attack = dict["attack"] as? Int
                        {
                            self._attack = "\(attack)";
                        }
                    if let defense = dict["defense"] as? Int
                        {
                            self._defense = "\(defense)";
                        }
                    
                    if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0
                        {
                            if let name = types[0]["name"]
                                {
                                    self._type = name.capitalizedString
                                }
                            if types.count > 1
                                {
                                    for var x = 1; x < types.count; x++
                                        {
                                            if let name = types[x]["name"]
                                            {
                                                self._type! += "/\(name.capitalizedString)"
                                            }
                                        }
                                }
                        }
                    else
                        {
                            self._type = "";
                        }
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0
                        {
                            if let url = descArr[0]["resource_uri"]
                                {
                                    let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                                    Alamofire.request(.GET, nsurl).responseJSON
                                        { (response: Response<AnyObject, NSError>) -> Void in
                                            
                                            if let descDict = response.result.value as? Dictionary<String, AnyObject>
                                                {
                                                    if let description = descDict["description"] as? String
                                                        {
                                                            self._description = description
                                                            print(self._description)
                                                        }
                                                }
                                            
                                            
                                        }
                                }
                        }
                    else
                        {
                            self._description = ""
                        }
                
                }
                
                
                print(self._weight);
                print(self._height);
                print(self._attack);
                print(self._defense);
                print(self._type);
            }
    }
    
    
    
    
    
}





