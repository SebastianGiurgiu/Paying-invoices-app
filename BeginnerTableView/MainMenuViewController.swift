//
//  MainMenuViewController.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 05/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var numberOfCompanies: UITextField!
    @IBOutlet weak var numberOfProducts: UITextField!
    @IBOutlet weak var numberOfInvoices: UITextField!
    
    var createNewData : Bool = false
    
    
    @IBAction func usingOldData(_ sender: Any) {
        createNewData = false
        performSegue(withIdentifier: "segueData", sender: self)
    }
    
    
    
    @IBAction func usingNewData(_ sender: Any) {
        createNewData = true
        performSegue(withIdentifier: "segueData", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberOfCompanies.delegate = self
        self.numberOfProducts.delegate = self
        self.numberOfInvoices.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if createNewData {
            let invoiceListScreen = segue.destination as! InvoiceListScreen
            invoiceListScreen.createNewData = true
            invoiceListScreen.nrOfCompanies = Int(numberOfCompanies.text!)!
            invoiceListScreen.nrOfProducts = Int(numberOfProducts.text!)!
            invoiceListScreen.nrOfInvoices = Int(numberOfInvoices.text!)!
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
      let allowedCharacters = CharacterSet.decimalDigits
      let characterSet = CharacterSet(charactersIn: string)
      return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    
    
    
}
