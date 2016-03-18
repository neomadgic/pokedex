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
    var pokemon: Pokemon!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pokemonNameLbl.text = pokemon.name.capitalizedString
    }

    @IBAction func backBtnPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
