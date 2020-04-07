//
//  InvoiceDto.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 01/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import Foundation

struct InvoiceDto: Equatable {
    var invoiceNumber: Int
    var seller: String
    var dates: [Date]
    var products: [String]
    var total: Double
    var duplicationFlag: Bool
}

// Create for check duplication
func ==(lhs: InvoiceDto, rhs: InvoiceDto) -> Bool {
    
    if lhs.seller != rhs.seller {
        return false
    }
    
    for prod in lhs.products {
        if !rhs.products.contains(prod){
            return false
        }
    }
    
    for prod in rhs.products {
        if !lhs.products.contains(prod) {
            return false;
        }
    }
    
    return true;
}


func createInvoiceDtoArray(invoices: [Invoice] ) -> [InvoiceDto] {
    
  var invoicesDto: [InvoiceDto] = []
   
    for invoice in invoices {
        
        var newInvoiceDto = InvoiceDto(invoiceNumber: 0, seller: "", dates: [], products: [], total: 0, duplicationFlag: false)
        
        newInvoiceDto.invoiceNumber = invoice.invoiceNumber
        newInvoiceDto.seller = invoice.seller
        
        
        for prod in invoice.products {
            newInvoiceDto.products.append(prod.name)
        }
        
        newInvoiceDto.dates.append(invoice.dueDate)
        if invoice.payDate != nil {
            newInvoiceDto.dates.append(invoice.payDate!)
        }
        
        newInvoiceDto.total = invoice.total
        
        invoicesDto.append(newInvoiceDto)
        
        
    }
      
    
  return invoicesDto
}

func sorterAfterDueDate(this:InvoiceDto, that:InvoiceDto) -> Bool {
    return this.dates[0] < that.dates[0]
}
   
func sorterAfterPaidDate(this:InvoiceDto, that:InvoiceDto) -> Bool {
    return this.dates[1] > that.dates[1]
}
   
