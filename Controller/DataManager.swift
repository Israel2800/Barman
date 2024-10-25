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
        } catch { print ("¡Error en el Query 1!") }
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
        } catch { print("¡Error en el query 2!") }
        return nil
    }
    
    func guardaBebidas(_ arregloJSON:[[String: Any]]) {
        guard let entidadDesc = NSEntityDescription.entity(forEntityName: "Drinks", in: persistentContainer.viewContext)
        else { return }
        for dict in arregloJSON {
            // 1. Crear un objeto Drinks
            let d = NSManagedObject(entity: entidadDesc, insertInto: persistentContainer.viewContext) as! Drinks
            // 2. Setear las properties del objeto, con los datos del dict
            d.inicializaCon(dict)
        }
        // 3. Guardar el objeto
        saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Barman")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
