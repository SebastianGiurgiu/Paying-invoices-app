//
//  Invoice.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 01/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//


import UIKit


struct Invoice{
    var invoiceNumber: Int
    var seller: String
    var products: [Product]
    var total: Double
    var dueDate: Date
    var payDate: Date?
}


// Generate an invoice
func generateNewInvoice(company: Company, products: [Product]) -> Invoice{
    
    var invoice = Invoice(invoiceNumber: 0, seller: "", products: [], total: 0, dueDate: Date())
    
    invoice.seller = company.name
    
    let numberOfProd = Int.random(in: 1..<4)
    var randomNumbers = Set<Int>()
    while (randomNumbers.count < numberOfProd) {
        randomNumbers.update(with: Int.random(in: 0..<products.count))
    }
    let randomIndex = Array(randomNumbers)
    
    for indexFromProductArray in randomIndex {
        let p = products[indexFromProductArray]
        invoice.products.append(p)
     }
    
    for prod in invoice.products {
        invoice.total += prod.price
    }
    
    let today = Date()
    
    let nrDaysForDueDate = Int.random(in: 1...5)
    let dueDate = Calendar.current.date(byAdding: .day, value: nrDaysForDueDate, to: today)!
    invoice.dueDate = dueDate
    
    
    let existPayDate = Int.random(in: 0...1)
    if existPayDate == 1 {
        let nrDaysForPayDate = Int.random(in: 0...5)
        let payDate = Calendar.current.date(byAdding: .day, value: -nrDaysForPayDate, to: today)!
        invoice.payDate = payDate
    }
    
    
    
    return invoice
}

// Create an array with invoices
func createInvoiceArray(companies: [Company], products: [Product], nrOfInvoices: Int) -> [Invoice] {
    
  var invoices: [Invoice] = []
   
    var uniqueId = 1
    for company in companies {
        var invoice = generateNewInvoice(company: company, products: products)
        invoice.invoiceNumber = uniqueId
        uniqueId += 1
        invoices.append(invoice)
    }
    
    let nrOfOther = nrOfInvoices - companies.count
    
    for _ in 0...nrOfOther {
        let x = Int.random(in: 0..<companies.count)
        var invoice = generateNewInvoice(company: companies[x], products: products)
        invoice.invoiceNumber = uniqueId
        uniqueId += 1
        invoices.append(invoice)
        }

    
  return invoices
}


func paidInvoice(invoices: inout [Invoice], invoiceNumber: Int) {
    
    for index in 0..<invoices.count{
        if invoices[index].invoiceNumber == invoiceNumber {
            invoices[index].payDate = Date()
        }
    }
    
}


func duplicateInvoice(invoices: inout [Invoice], invoiceNumber: Int) {
    
    let newInvoiceNumber = invoices[invoices.count - 1].invoiceNumber + 1
    
    for index in 1..<invoices.count{
        if invoices[index].invoiceNumber == invoiceNumber {
            var newInvoice = invoices[index]
            newInvoice.invoiceNumber = newInvoiceNumber
            invoices.append(newInvoice)
        }
    }
    

    
}







