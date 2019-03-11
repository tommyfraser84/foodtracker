//
//  IngredientsTableViewController.swift
//  FoodTracker
//
//  Created by Tom Fraser on 07/03/2019.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class IngredientTableViewController: UITableViewController {

    //MARK: Properties
    
    var meal: Meal? {
        didSet {
            print("\(meal?.name) has \(meal?.ingredients?.count) ingredients")
        }
    }
    
    @IBOutlet weak var backButton: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        //backButton.delegate =
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

        
        return meal?.ingredients?.count ?? 0
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: IngredientTableViewCell.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.") }

        // Configure the cell...
        
        guard let ingredient = meal?.ingredients?[indexPath.row] else {
            fatalError("Cannot get ing")
        }
        
        //print(ingredient)
        cell.nameLabel.text = ingredient.name

        return cell
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
            
            guard let selectedIngredient = meal?.ingredients?[indexPath.row] else {
                fatalError("Cannot get ing")
            }
            ingredientDetailViewController.ingredient = selectedIngredient
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
        
        //prep for sending ingredient class item to ingredient vc
        
        //prep for sending ingredient array to meal vc
        
    }
   
    
    @IBAction func unwindToIngredientList(sender: UIStoryboardSegue) {
        //print("unwind")
        if let sourceViewController = sender.source as? IngredientViewController, let ingredient = sourceViewController.ingredient {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                //meal?.ingredients += [ingredient]
                
                meal?.ingredients = [ingredient]
                
                
                if let currentIngredients = meal?.ingredients {
                    let newIngredients = currentIngredients + [ingredient]
                    meal?.ingredients = newIngredients
                }
                else {
                    meal?.ingredients = [ingredient]
                }
            }
            else {
                // Add a new meal.
                var indexCount = 0
//                if ingredients != nil {
//                    indexCount = ingredients.count
//                    print("indexCount is \(indexCount)")
//                } else {
//                    print("indexCount is \(indexCount)")
//                    ingredients? = [ingredient]
//                }
                
                if meal?.ingredients == nil {
                   meal?.ingredients = []
                }
                
                meal?.ingredients?.append(ingredient)
                tableView.reloadData()
                
                
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
    
            }
        }
    }
    
}
