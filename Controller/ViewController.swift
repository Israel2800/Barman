//
//  DataManager.swift
//  Barman
//
//  Created by Israel Aguilar on 10/23/24.
//

import UIKit

class ViewController: UIViewController {

    var laBebida : Drinks!
    var detalle : DetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detalle = DetailView(frame:view.bounds.insetBy(dx: 40, dy: 40))
        view.addSubview(detalle)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let info = 
        "Name: \(laBebida.name ?? "")\n" +
        "img: \(laBebida.img ?? "")\n" +
        "ingredients: \(laBebida.ingredients ?? "")\n" +
        "directions: \(laBebida.directions ?? "")\n"
        
        detalle.tv.text = info
        
    }


}

