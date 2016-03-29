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
    @IBOutlet weak var typeLbl: TypeLabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    
    var pokemon: Pokemon!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        pokemonNameLbl.text = pokemon.name.capitalizedString
        mainImg.image = img
        currentEvoImg.image = img
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails
        { () -> () in
            //this will be called after download is done
            self.updateData()
        }
    }
    
    func updateData()
    {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        typeLbl.changeColor();
        heightLbl.text = pokemon.height
        attackLbl.text = pokemon.attack
        weightLbl.text = pokemon.weight
        defenseLbl.text = pokemon.defense
        
        if pokemon.nextEvolutionText == ""
            {
                evoLbl.text = "NO NEXT EVOLUTION"
                nextEvoImg.hidden = true
            }
        else
            {
                nextEvoImg.image = UIImage(named: "\(pokemon.nextEvolutionId)")
                nextEvoImg.hidden = false
                evoLbl.text = "Next evolution: \(pokemon.nextEvolutionText) (\(pokemon.nextEvolutionLvl))"
            }
    }

    @IBAction func backBtnPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
