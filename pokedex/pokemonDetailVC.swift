//
//  pokemonDetailVC.swift
//  pokedex
//
//  Created by Vu Dang on 3/17/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit

class pokemonDetailVC: UIViewController
{
    
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    
    var pokemon: Pokemon!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pokemonNameLbl.text = pokemon.name.capitalizedString
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails
        { () -> () in
            //this will be called after download is done
        }
    }

    @IBAction func backBtnPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
