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
    
    //@IBOutlet weak var addImgBtn: UIButton!

    @IBOutlet weak var addImg: UITextField!
    
    @IBAction func saveNewDrinkBtn(_ sender: UIButton) {
        guard let name = nameTyped.text, !name.isEmpty,
              let ingredients = ingredientsTyped.text, !ingredients.isEmpty,
              let directions = directionsTyped.text, !directions.isEmpty,
              let img = addImg.text, !img.isEmpty else {
            // Mostrar mensaje de error si algún campo está vacío
            let alert = UIAlertController(
                title: "Campos Vacíos",
                message: "Por favor, completa todos los campos.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Crear un nuevo objeto Drinks y guardar en Core Data
        let newDrink = Drinks(context: DataManager.shared.persistentContainer.viewContext)
        newDrink.name = name
        newDrink.ingredients = ingredients
        newDrink.directions = directions
        newDrink.img = img // Configurar
        
        // Guardar cambios en Core Data
        DataManager.shared.saveContext()
        
        // Enviar notificación para actualizar el TableViewController
        NotificationCenter.default.post(name: NSNotification.Name("NewDrinkAdded"), object: nil)
        
        // Mostrar mensaje de éxito
        let successAlert = UIAlertController(
            title: "New Drink Added",
            message: "The new drink has been successfully saved",
            preferredStyle: .alert
        )
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(successAlert, animated: true)
        
        // Limpiar los campos de entrada
        nameTyped.text = ""
        ingredientsTyped.text = ""
        directionsTyped.text = ""
        addImg.text = ""
        
        
        // Cerrar vista de New Drink
        //dismiss(animated: true)
        
        
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
