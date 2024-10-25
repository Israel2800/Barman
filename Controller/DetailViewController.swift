//
//  DataManager.swift
//  Barman
//
//  Created by Israel Aguilar on 10/23/24.
//

import UIKit

class DetailViewController: UIViewController {

    var laBebida : Drinks!
    
    @IBOutlet weak var DrinkName: UITextView!
    
    @IBOutlet weak var ImageDrink: UIImageView!
    
    @IBOutlet weak var IngredientsDrink: UITextView!
    
    @IBOutlet weak var DirectionsDrink: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIWithViewController()
    }
    
    // Función para actualizar los elementos
    func updateUIWithViewController() {
        DrinkName.text = laBebida.name ?? ""
        
        // Cargar img
        
        IngredientsDrink.text = laBebida.ingredients ?? ""
        DirectionsDrink.text = laBebida.directions ?? ""
    }

    
    
    /* override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let info = 
        "Name: \(laBebida.name ?? "")\n" +
        "img: \(laBebida.img ?? "")\n" +
        "ingredients: \(laBebida.ingredients ?? "")\n" +
        "directions: \(laBebida.directions ?? "")\n"
        
        detalle.tv.text = info
        
    } */


}

