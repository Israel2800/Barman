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
                
        IngredientsDrink.text = laBebida.ingredients ?? ""
        DirectionsDrink.text = laBebida.directions ?? ""
        
        DrinkName.isEditable = false
        IngredientsDrink.isEditable = false
        DirectionsDrink.isEditable = false
        
        // Cargar img
        if let imageName = laBebida.img {
            loadImage(named: imageName)
        }
        
    }
    
    private func loadImage(named imageName: String) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageFileURL = documentsURL.appendingPathComponent(imageName)
        
        if fileManager.fileExists(atPath: imageFileURL.path) {
            // Si ya existe la imagen se carga desde Documents
            ImageDrink.image = UIImage(contentsOfFile: imageFileURL.path)
        } else {
            // Si no existe la imagen, se descargará usando la URL
            let fullImageURL = "http://janzelaznog.com/DDAM/iOS/drinksimages/\(imageName)"
            downloadAndSaveImage(from: fullImageURL, to: imageFileURL)
        }
    }
    
    private func downloadAndSaveImage(from urlString: String, to localURL: URL) {
        guard let imageURL = URL(string: urlString) else {
            print("URL de imagen no válida")
            return
        }
        
        let session = URLSession(configuration: .default)
        let downloadTask = session.dataTask(with: imageURL) { [weak self] data, responde, error in
            if let error = error {
                print("Error al descargar la imagen: \(error.localizedDescription)")
                return
            }
            
            guard let imageData = data, let downloadImage = UIImage(data: imageData) else {
                print("Error al procesar los datos de imagen.")
                return
            }
            
            // Guardar imagen en Documentos
            do {
                try imageData.write(to: localURL)
                DispatchQueue.main.async {
                    // Mostrar imagen descargada
                    self?.ImageDrink.image = downloadImage
                }
            } catch {
                print("Error al guardar la imagen: \(error.localizedDescription)")
            }
            
        }
        downloadTask.resume()
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

