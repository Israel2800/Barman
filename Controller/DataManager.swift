//
//  DataManager.swift
//  Barman
//
//  Created by Israel Aguilar on 10/23/24.
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    static let shared = DataManager()
    
    private override init() {
        super.init()
    }
    
    func todasLasBebidas() -> [Drinks] {
        var arreglo = [Drinks]()
        let elQuery = Drinks.fetchRequest()
        do {
            arreglo = try persistentContainer.viewContext.fetch(elQuery)
        } catch { print ("¡Error en el Query!") }
        return arreglo
    }
    
    func llenaBD() {
        let ud = UserDefaults.standard
        if ud.integer(forKey: "BD-OK") != 1 { // La base de datos no se ha descargado
            if InternetMonitor.shared.hayConexion {
                if let laURL = URL(string: "http://janzelaznog.com/DDAM/iOS/drinks.json") {
                    let sesion = URLSession(configuration: .default)
                    let tarea = sesion.dataTask(with: URLRequest(url: laURL)) { data, response, error in
                        if error != nil {
                            print("No se pudo descargar el feed de bebidas\(error?.localizedDescription ?? "")")
                            return
                        }
                        // Llenar la base de datos
                        do {
                            let tmp = try JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
                            self.guardaBebidas (tmp)
                        } catch { print ("No se obtuvo un JSON en la respuesta.") }
                        ud.set(1, forKey: "BD-OK")
                    }
                    tarea.resume()
                }
            }
            
        }
    }
    
    func buscaBebidaConNombre(_ nombreB: String) -> Drinks? {
        let elQuery = NSFetchRequest<NSFetchRequestResult>(entityName: "Drinks")
        let elFiltro = NSPredicate (format: "name == %d", nombreB)
        elQuery.predicate = elFiltro
        do {
            let tmp = try persistentContainer.viewContext.fetch(elQuery) as! [Drinks]
            return tmp.first
        } catch { print("¡Error en el query!") }
        return nil
    }
    
}
