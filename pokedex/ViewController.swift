//
//  ViewController.swift
//  pokedex
//
//  Created by Vu Dang on 3/4/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var randMusic: AVAudioPlayer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
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

