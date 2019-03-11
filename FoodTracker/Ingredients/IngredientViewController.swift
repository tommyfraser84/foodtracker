//
//  IngredientViewController.swift
//  FoodTracker
//
//  Created by Tom Fraser on 07/03/2019.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class IngredientViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleText: UINavigationItem!
    var ingredient: Ingredient?
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        // Do any additional setup after loading the view.
        
        // Set up views if editing an existing Meal.
        if let ingredient = ingredient {
            nameTextField.text = ingredient.name
            titleText.title = ingredient.name
        }
        
        //Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print ("prep")
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        
        ingredient = Ingredient(name: name)
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}
