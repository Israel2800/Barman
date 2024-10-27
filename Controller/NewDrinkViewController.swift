//
//  NewDrinkViewController.swift
//  Barman
//
//  Created by Israel Aguilar on 10/25/24.
//

import UIKit

class NewDrinkViewController: UIViewController {
    
    //@IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameTyped: UITextField!
    @IBOutlet weak var ingredientsTyped: UITextField!
    @IBOutlet weak var directionsTyped: UITextField!
    @IBOutlet weak var addImg: UITextField!

    @IBAction func saveNewDrinkBtn(_ sender: UIButton) {
        guard let name = nameTyped.text, !name.isEmpty,
              let ingredients = ingredientsTyped.text, !ingredients.isEmpty,
              let directions = directionsTyped.text, !directions.isEmpty else {
            let alert = UIAlertController(
                title: "Campos Vacíos",
                message: "Por favor, completa todos los campos",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let img = addImg.text?.isEmpty == false ? addImg.text! : "drinks"
        
        let newDrink = Drinks(context: DataManager.shared.persistentContainer.viewContext)
        newDrink.name = name
        newDrink.ingredients = ingredients
        newDrink.directions = directions
        newDrink.img = img

        DataManager.shared.saveContext()
        NotificationCenter.default.post(name: NSNotification.Name("NewDrinkAdded"), object: nil)
        
        let successAlert = UIAlertController(
            title: "New Drink Added",
            message: "The new drink has been successfully saved",
            preferredStyle: .alert
        )
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(successAlert, animated: true)

        nameTyped.text = ""
        ingredientsTyped.text = ""
        directionsTyped.text = ""
        addImg.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // Configurar ancho del contentView para evitar desplazamiento horizontal
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: 1).isActive = true

        // Bloquear desplazamiento horizontal
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceHorizontal = false
         */
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            scrollView.contentInset.bottom = keyboardFrame.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
