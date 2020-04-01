//
//  InvoiceDto.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 01/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import Foundation

struct InvoiceDto: Hashable {
    var invoiceNumber: Int
    var seller: String
    var dates: [Date]
    var products: [String]
    var total: Double
    var duplicationFlag: Bool
}

func ==(lhs: InvoiceDto, rhs: InvoiceDto) -> Bool {
    if lhs.products == rhs.products {
        print("Aceleasi produse")
    }
    return lhs.products == rhs.products
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
    
    
//    var counts: [InvoiceDto: Int] = [:]
//    for item in invoicesDto {
//        counts[item] = (counts[item] ?? 0) + 1
//    }
//    
//    
//    for index in 1..<invoicesDto.count{
//        if counts[invoicesDto[index]]! > 1 {
//            invoicesDto[index].duplicationFlag = true
//        }
//    }
      
 // print(counts)
  print("___________________")
    
  return invoicesDto
}
