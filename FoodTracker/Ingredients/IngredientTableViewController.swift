//
//  IngredientsTableViewController.swift
//  FoodTracker
//
//  Created by Tom Fraser on 07/03/2019.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import os.log

protocol IngredientsDelegate: class {
    func didFinish(with ingredients: [Ingredient])
}

class IngredientTableViewController: UITableViewController {

    //MARK: Properties
    var ingredients = [Ingredient]()
  /*  var meal: Meal? {
        didSet {
            print("\(meal?.name) has \(meal?.ingredients?.count) ingredients")
        }
    }*/
    
    @IBOutlet weak var backButton: UINavigationItem!
    
    weak var delegate: IngredientsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //self.tableView.delegate
        //backButton.delegate =
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
        delegate?.didFinish(with:ingredients)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if meal != nil {
//            ingredients = meal?.ingredients
//            print(ingredients?.count)
//        }
//            return ingredients!.count
        
//        if let ingredients = meal?.ingredients {
//            return ingredients.count
//        }
//        return 0

        
        return ingredients.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: IngredientTableViewCell.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.") }

        // Configure the cell...
        
        let ingredient = ingredients[indexPath.row]

        //print(ingredient)
        cell.nameLabel.text = ingredient.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destination.
        //let name =
        // Pass the selected object to the new view controller.
        //let selectedIngredient = ingredients[indexPath.row]
        switch(segue.identifier ?? "") {
            
        case "addIngredient":
            os_log("Adding a new ingredient.", log: OSLog.default, type: .debug)
            
        case "showIngredient":
            guard let ingredientDetailViewController = segue.destination as? IngredientViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedIngredientCell = sender as? IngredientTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedIngredientCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            /*
            guard let selectedIngredient = ingredients[indexPath.row] else {
                fatalError("Cannot get ing")
            }     */
            ingredientDetailViewController.ingredient = ingredients[indexPath.row]
 
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
        
        //prep for sending ingredient class item to ingredient vc
        
        //prep for sending ingredient array to meal vc
        
    }
   
    
    @IBAction func unwindToIngredientList(sender: UIStoryboardSegue) {
        //print("unwind")
        if let sourceViewController = sender.source as? IngredientViewController, let ingredient = sourceViewController.ingredient {
            ingredients.append(ingredient)
            tableView.reloadData()
            /*
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
         

            }
            else {

                fatalError("unwind not as expected")
     
    
            }*/
        }
    }
    
}
