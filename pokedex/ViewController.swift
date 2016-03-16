//
//  ViewController.swift
//  pokedex
//
//  Created by Vu Dang on 3/4/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate
{

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var randMusic: AVAudioPlayer!
    var inSearchMode = false
    var filteredPokemon = [Pokemon]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        initAudio()
        randomizeMusic()
        
        parsePokemonCSV()
    }
    
    func randomizeMusic()
    {
        let randNum = Int(arc4random_uniform(4)) + 1
        let path = NSBundle.mainBundle().pathForResource("music\(randNum)", ofType: "mp3")!
        
        do
        {
            randMusic = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            randMusic.prepareToPlay()
            randMusic.numberOfLoops = -1
        }
        catch let err as NSError
        {
            print(err.debugDescription);
        }
    }
    
    func initAudio()
    {
        let path = NSBundle.mainBundle().pathForResource("music1", ofType: "mp3")!
        
        do
            {
                musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
                musicPlayer.prepareToPlay()
                musicPlayer.numberOfLoops = -1
                musicPlayer.play()
            }
        catch let err as NSError
            {
                print(err.debugDescription);
            }
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
                let poke: Pokemon!
                
                if inSearchMode
                    {
                        poke = filteredPokemon[indexPath.row]
                    }
                else
                    {
                        poke = pokemon[indexPath.row]
                    }
                
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
        if inSearchMode
            {
                return filteredPokemon.count
            }
        
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
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == ""
            {
                inSearchMode = false;
                view.endEditing(true)
                collection.reloadData()
            }
        else
            {
                inSearchMode = true;
                let lower = searchBar.text!.lowercaseString
                filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
                collection.reloadData()
                
            }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        view.endEditing(true)
    }

    
    @IBAction func musicBtnPressed(sender: UIButton!)
    {
        if musicPlayer.playing
            {
                musicPlayer.stop()
                sender.alpha = 0.5;
                randomizeMusic()
                musicPlayer = randMusic;
            }
        else
            {
                musicPlayer.play()
                sender.alpha = 1.0;
            }
    }
}

