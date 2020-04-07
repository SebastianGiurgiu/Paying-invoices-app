//
//  InvoiceListScreem.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 06/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//


import UIKit
import SQLite3
import CoreData

class InvoiceListScreen: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var companies: [Company] = []
    var products: [Product] = []
    var invoices: [Invoice] = []
    var invoicesDto: [InvoiceDto] = []
    var searchInvoices: [InvoiceDto] = []
    var searching = false
    var seacrhingText = ""
    var database: Database = Database()

    var nrOfCompanies: Int = 0
    var nrOfProducts: Int = 0
    var nrOfInvoices: Int = 0
    var createNewData: Bool = false
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.showsCancelButton = true
        self.searchBar.delegate = self
        
        if self.createNewData {
            self.createNewDataAndSaveInCoreData(nrOfCompanies: nrOfCompanies,nrOfProducts: nrOfProducts,nrOfInvoices: nrOfInvoices)
        } else {
            self.continueWithOldDataFromCoreData()
        }
        
       setUpInvoicesDto()
        self.searchInvoices = invoicesDto
    }
    
    // Pending invoices should appear first, ordered by due date, pending invoices are followed by the paid invoices, ordered by paid date
    func setUpInvoicesDto() {
        self.invoicesDto = createInvoiceDtoArray(invoices: invoices)
               
               var unpaidInvoicesDto =  invoicesDto.filter({ (invoiceDto) in invoiceDto.dates.count == 1 })
               unpaidInvoicesDto.sort(by: sorterAfterDueDate)

               var paidInvoicesDto = invoicesDto.filter({ (invoiceDto) in invoiceDto.dates.count == 2 })
               paidInvoicesDto.sort(by: sorterAfterPaidDate)
            
               invoicesDto = []
               invoicesDto += unpaidInvoicesDto
               invoicesDto += paidInvoicesDto
               
               for index in 0..<invoicesDto.count{
                   let nrOfElements =  invoicesDto.filter{$0 == invoicesDto[index] }.count
                   if nrOfElements > 1 {
                       invoicesDto[index].duplicationFlag = true
                   }
               }
    }
    
    
    func createNewDataAndSaveInCoreData(nrOfCompanies: Int,nrOfProducts: Int,nrOfInvoices: Int) {
        
        
        if nrOfCompanies > nrOfInvoices {
            self.continueWithOldDataFromCoreData()
            return;
        }
        
        self.database.deleteAllData(entity: "CompanyCoreData")
        self.database.deleteAllData(entity: "ProductCoreData")
        self.database.deleteAllData(entity: "InvoiceCoreData")
        self.database.deleteAllData(entity: "InvoiceProductCoreData")
        
        let strings = createtringNames()
        self.companies = createCompaniesArray(availableStrings: strings, nrOfCompanies: nrOfCompanies)
        self.products = createProductsArray(nrOfProducts: nrOfProducts)
        self.invoices = createInvoiceArray(companies: companies, products: products, nrOfInvoices: nrOfInvoices)
        
        self.database.addAllCompaniesInCoreData(companies: companies)
        self.database.addAllProductInCoreData(products: products)
        self.database.addAllInvoiceInCoreData(invoices: invoices)
        
    }

    func continueWithOldDataFromCoreData() {
        
        self.companies = database.getCompaniesFromCoreData()
        self.products = database.getProductsFromCoreData()
        self.invoices = database.getInvoiceFromCoreData()
        
    }
}


extension InvoiceListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchInvoices.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
        let invoiceDto = searchInvoices[indexPath.row]
        if searching {
            cell.setInvoiceDtoAfterSeachingText(invoiceDto: invoiceDto, searchText: seacrhingText)
        } else {
            cell.setInvoiceDto(invoiceDto: invoiceDto)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let paid = paidAction(at: indexPath)
        let duplicate = duplicatedAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [paid,duplicate])
    }
    
    func paidAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let invoiceDto = searchInvoices[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Paid") {
            (action, view, completion ) in
                print(invoiceDto)
            self.searchInvoices[indexPath.row].dates.append(Date())
            paidInvoice(invoices: &self.invoices, invoiceNumber: self.searchInvoices[indexPath.row].invoiceNumber)
            self.database.paidInvoiceCoreData(invoiceNumber: self.searchInvoices[indexPath.row].invoiceNumber)
            self.tableView.reloadData()
        }
        
         action.backgroundColor = .red
        
        return action
        
    }
    
    
    func duplicatedAction(at indexPath: IndexPath) -> UIContextualAction {
          
        let invoiceDto = searchInvoices[indexPath.row]
          let action = UIContextualAction(style: .normal, title: "Duplicate") {
              (action, view, completion ) in
                  print(invoiceDto)
              duplicateInvoice(invoices: &self.invoices, invoiceNumber: self.searchInvoices[indexPath.row].invoiceNumber)
              self.database.addAnInvoiceInCoreData(invoices: self.invoices)
              self.setUpInvoicesDto()
              self.tableView.reloadData()
          }
          
           action.backgroundColor = .blue
          
          return action
      }
}


extension InvoiceListScreen: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar.showsCancelButton = true
        self.seacrhingText = searchText
        if searchText.count > 2 {
        self.searchInvoices = getOrderedInvoicesDtoAfterText(invoicesDto: invoicesDto,searchText: searchText)
        self.searching = true
        self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false
        self.searchBar.text = ""
        self.searchBar.showsCancelButton = false
        self.searchInvoices = invoicesDto
        self.tableView.reloadData()
    }
    
}

// List of results should contain 10 items or less.
func getOrderedInvoicesDtoAfterText(invoicesDto: [InvoiceDto],searchText: String) -> [InvoiceDto] {
    
  var filteredInvoicesDto: [InvoiceDto] = []
    var nr = 0
    
    let invoicesFirstWordSeller = invoicesDto.filter{
        let seller = $0.seller.split(separator: " ")
        if seller[0].contains(searchText) {
            return true
        }
        return false
    }
        
    filteredInvoicesDto.append(contentsOf: invoicesFirstWordSeller)
    nr = filteredInvoicesDto.count
        
    if nr < 10 {
        let invoicesSecondWordSeller = invoicesDto.filter{
            let seller = $0.seller.split(separator: " ")
            if seller[1].contains(searchText) {
                return true
                }
            return false
            }
        filteredInvoicesDto.append(contentsOf: invoicesSecondWordSeller)
        nr = filteredInvoicesDto.count
    }


    if nr < 10 {
        let invoicesAnyMatchSeller = invoicesDto.filter{
            let seller = $0.seller
            if seller.contains(searchText) && !filteredInvoicesDto.contains($0) {
                return true
            }
            return false
        }
        filteredInvoicesDto.append(contentsOf: invoicesAnyMatchSeller)
        nr = filteredInvoicesDto.count
    }

    if nr < 10 {
        let invoicesAnyMatchProduct = invoicesDto.filter{
            let products = $0.products
            for prod in products {
                if prod.contains(searchText) && !filteredInvoicesDto.contains($0) {
                    return true
            }
        }
        return false
    }
        filteredInvoicesDto.append(contentsOf: invoicesAnyMatchProduct)
        nr = filteredInvoicesDto.count
    }

    while nr > 10 {
        filteredInvoicesDto.removeLast()
        nr -= 1
    }
      
  return filteredInvoicesDto
}

