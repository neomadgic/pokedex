//
//  ViewController.swift
//  pokedex
//
//  Created by Vu Dang on 3/4/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        parsePokemonCSV()
    }
    
    func parsePokemonCSV()
    {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do
            {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for rows in rows
                {
                    let pokeId = Int(rows["id"]!)!
                    let name = rows["identifier"]!
                    
                    let poke = Pokemon(name: name, pokedexId: pokeId)
                    pokemon.append(poke)
                }
            }
        catch let err as NSError
            {
                print(err.debugDescription)
            }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if let cell = collection.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell
            {
                let poke = pokemon[indexPath.row]
                cell.configureCell(poke)
                
                return cell
            }
        else
            {
                return UICollectionViewCell()
            }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(105, 105)
    }
    
}

