//
//  VideoListScreen.swift
//  BeginnerTableView
//
//  Created by Sean Allen on 5/19/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit
import SQLite3
import CoreData

class VideoListScreen: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var companies: [Company] = []
    var products: [Product] = []
    var invoices: [Invoice] = []
    var invoicesDto: [InvoiceDto] = []
    var searchInvoices: [InvoiceDto] = []
    var searching = false
    var text = ""
    var database: Database = Database()

    var nrOfCompanies: Int = 0
    var nrOfProducts: Int = 0
    var nrOfInvoices: Int = 0
    var createNewData: Bool = false
    
    
    
    var companiesCoreData : [NSManagedObject] = []
    
    
    func sorterAfterDueDate(this:InvoiceDto, that:InvoiceDto) -> Bool {
        return this.dates[0] < that.dates[0]
    }
    
    func sorterAfterPaidDate(this:InvoiceDto, that:InvoiceDto) -> Bool {
        return this.dates[1] < that.dates[1]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        
        print("Se delcaraaaaaaaa")
        if createNewData {
            print(nrOfCompanies)
            print(nrOfProducts)
            print(nrOfInvoices)
            print(createNewData)
        }
        
        
        let strings = createtringNames()
//        companies = createCompaniesArray(availableStrings: strings)
//        products = createProductsArray()
//        invoices = createInvoiceArray(companies: companies, products: products)
//        
        companies = database.getCompaniesFromCoreData()
        products = database.getProductsFromCoreData()
        invoices = database.getInvoiceFromCoreData()

        invoicesDto = createInvoiceDtoArray(invoices: invoices)
        
        let managedContext = database.managedContext
        
      
//        database.deleteAllData(entity: "CompanyCoreData")
//        database.deleteAllData(entity: "ProductCoreData")
//        database.deleteAllData(entity: "InvoiceCoreData")
//        database.deleteAllData(entity: "InvoiceProductCoreData")

//        database.addAllCompaniesInCoreData(companies: companies)
//        database.addAllProductInCoreData(products: products)
//        database.addAllInvoiceInCoreData(invoices: invoices)

        
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
        searchInvoices = invoicesDto
    }
}


extension VideoListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchInvoices.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        let invoiceDto = searchInvoices[indexPath.row]
        if searching {
            cell.setInvoiceDto2(invoiceDto: invoiceDto, searchText: text)
        } else {
            cell.setInvoiceDto(invoiceDto: invoiceDto)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let paid = paidAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [paid])
    }
    
    func paidAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let invoiceDto = searchInvoices[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "PAID") {
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
}


extension VideoListScreen: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        text = searchText
        if searchText.count > 2 {
        searchInvoices = getOrderedInvoicesDtoAfterText(invoicesDto: invoicesDto,searchText: searchText)
        searching = true
        tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchInvoices = invoicesDto
        tableView.reloadData()
    }
    
}


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

