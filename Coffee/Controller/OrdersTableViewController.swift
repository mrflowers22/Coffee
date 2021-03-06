//
//  OrdersTableViewController.swift
//  Coffee
//
//  Created by Michael Flowers on 11/13/21.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    var newOrderListViewModel = NewOrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    private func populateOrders() {
//        guard let coffeeOrdersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
//            fatalError("URL was incorrect")
//        }
//        print("this was the url: \(coffeeOrdersURL)")
        guard let islandURL = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("IslandURL was incorrect sucka")
        }
        print("this was the Islandurl: \(islandURL)")

        let resource = Resource<[NewOrder]>(url:islandURL)
        Webservice().load(resource: resource) { [weak self ] result in
            switch result {
            case .success(let orders):
                print("these are the orders: \(orders)")
                self?.newOrderListViewModel.newOrdersViewModel = orders.map (NewOrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error with the webservice: \(error.localizedDescription)")
            }
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newOrderListViewModel.newOrdersViewModel.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewOrderCell", for: indexPath)
        let newOrder = self.newOrderListViewModel.newOrderViewModel(at: indexPath.row)
        
        cell.textLabel?.text = newOrder.coffeeName
        cell.detailTextLabel?.text = newOrder.size
        
        // Configure the cell...

        return cell
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
