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
        print("old data")
        createNewData = false
        performSegue(withIdentifier: "segueNewData", sender: self)
    }
    
    
    
    @IBAction func usingNewData(_ sender: Any) {
        createNewData = true
        performSegue(withIdentifier: "segueNewData", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberOfCompanies.delegate = self
        self.numberOfProducts.delegate = self
        self.numberOfInvoices.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if createNewData {
            let receveiceVC = segue.destination as! VideoListScreen
            receveiceVC.createNewData = true
            receveiceVC.nrOfCompanies = Int(numberOfCompanies.text!)!
            receveiceVC.nrOfProducts = Int(numberOfProducts.text!)!
            receveiceVC.nrOfInvoices = Int(numberOfInvoices.text!)!
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
      let allowedCharacters = CharacterSet.decimalDigits
      let characterSet = CharacterSet(charactersIn: string)
      return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    
    
    
}