//
//  TableViewController.swift
//  Barman
//
//  Created by Israel Aguilar on 10/24/24.
//

import UIKit

class TableViewController: UITableViewController {

    var drinks = [Drinks]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drinks = DataManager.shared.todasLasBebidas()
        NotificationCenter.default.addObserver(self, selector: #selector(mostrarTabla), name: NSNotification.Name(rawValue: "BD_LISTA"), object: nil)
        
        // Notificación de nueva bebida
        NotificationCenter.default.addObserver(self, selector: #selector(mostrarTabla), name: NSNotification.Name("NewDrinkAdded"), object: nil)
    }
    
    @objc func mostrarTabla() {
        drinks = DataManager.shared.todasLasBebidas()
        //print ("Mostrando la tabla")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NewDrinkAdded"), object: nil)
    }
    
    
    /*override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }*/

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)

        let d = drinks[indexPath.row]
        cell.textLabel?.text = d.name

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let d = drinks[indexPath.row]
        performSegue(withIdentifier: "show", sender: d)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDrinkSegue" {
            if let destinationVC = segue.destination as? NewDrinkViewController {
                // Pasar datos a NewDrinkViewController
            }
        } else if segue.identifier == "show" {
            if let destino = segue.destination as? DetailViewController {
                destino.laBebida = sender as? Drinks
            }
        } else if segue.identifier == "showNewDrink" {
            if let destino = segue.destination as? DetailViewController {
                // Pasar los nuevos datos a DetailViewController
                destino.laBebida = sender as? Drinks
            }
        }
        
       
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
