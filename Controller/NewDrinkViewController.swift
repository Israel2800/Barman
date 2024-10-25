//
//  NewDrinkViewController.swift
//  Barman
//
//  Created by Israel Aguilar on 10/25/24.
//

import UIKit

class NewDrinkViewController: UIViewController {

    @IBOutlet weak var nameTyped: UITextField!
    
    @IBOutlet weak var ingredientsTyped: UITextField!
    
    @IBOutlet weak var directionsTyped: UITextField!
    
    @IBOutlet weak var addImgBtn: UIButton!
    
    @IBAction func saveNewDrinkBtn(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
