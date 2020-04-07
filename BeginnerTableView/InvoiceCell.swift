//
//  VideoCell.swift
//  BeginnerTableView
//
//  Created by Sean Allen on 5/19/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit

class InvoiceCell: UITableViewCell {


    @IBOutlet weak var sellerName: UILabel!
    
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var paidDate: UILabel!
    @IBOutlet weak var prod1Name: UILabel!
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var prod3Name: UILabel!
    @IBOutlet weak var prod2Name: UILabel!
    
    
    
   func setUp(invoiceDto: InvoiceDto) {
        sellerName.text = invoiceDto.seller
        sellerName.textAlignment = .center
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
               
        let dueDateString = df.string(from: invoiceDto.dates[0])
        dueDate.text = dueDateString
               
        if invoiceDto.dates.count > 1 {
           let paidDateString = df.string(from: invoiceDto.dates[1])
            paidDate.text = "Paid on \(paidDateString)"
            paidDate.font = UIFont.boldSystemFont(ofSize: 16.0)
            } else {
                let diff = daysBetween(start: Date(), end: invoiceDto.dates[0])
                paidDate.text = "There are \(diff) days left"
            }
        
        let myDouble = invoiceDto.total
        let doubleStr = String(format: "%.2f", myDouble)
        total.text = String(doubleStr)
               
        if invoiceDto.duplicationFlag == true {
            self.backgroundColor = UIColor.yellow
        } else {
            self.backgroundColor = UIColor.white
        }
        
    }
    
    
    func setInvoiceDto(invoiceDto: InvoiceDto) {
        
        self.setUp(invoiceDto: invoiceDto)
        sellerName.textColor = UIColor.black
        
        if(invoiceDto.products.count == 1 ){
           prod1Name.text = invoiceDto.products[0]
           prod2Name.text = ""
           prod3Name.text = ""
        }
        
        
        if(invoiceDto.products.count == 2 ){
            prod1Name.text = invoiceDto.products[0]
            prod2Name.text = invoiceDto.products[1]
            prod3Name.text = ""
        }
        
        
        if(invoiceDto.products.count == 3 ){
            prod1Name.text = invoiceDto.products[0]
            prod2Name.text = invoiceDto.products[1]
            prod3Name.text = invoiceDto.products[2]
        }
        
        prod1Name.textColor = UIColor.black
        prod2Name.textColor = UIColor.black
        prod3Name.textColor = UIColor.black
        sellerName.textColor = UIColor.black
        
       }
    

    func setInvoiceDtoAfterSeachingText(invoiceDto: InvoiceDto, searchText: String) {
           
        self.setUp(invoiceDto: invoiceDto)
        colorLabel(label: sellerName,searchText: searchText)
        
        if(invoiceDto.products.count == 1 ){
            prod1Name.text = invoiceDto.products[0]
            colorLabel(label: prod1Name,searchText: searchText)
            prod2Name.text = ""
            prod3Name.text = ""
        }
                    
        if(invoiceDto.products.count == 2 ){
            prod1Name.text = invoiceDto.products[0]
            colorLabel(label: prod1Name,searchText: searchText)
            prod2Name.text = invoiceDto.products[1]
            colorLabel(label: prod2Name,searchText: searchText)
            prod3Name.text = ""
        }
            
        if(invoiceDto.products.count == 3 ){
            prod1Name.text = invoiceDto.products[0]
            colorLabel(label: prod1Name,searchText: searchText)
            prod2Name.text = invoiceDto.products[1]
            colorLabel(label: prod2Name,searchText: searchText)
            prod3Name.text = invoiceDto.products[2]
            colorLabel(label: prod3Name,searchText: searchText)
        }
    }
}

func colorLabel(label: UILabel, searchText: String) {
        
    let strNumber: NSString = label.text! as NSString // you must set your
    let range = (strNumber).range(of: searchText )
    let attribute = NSMutableAttributedString.init(string: strNumber as String)
    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
    label.attributedText = attribute
    
}

func daysBetween(start: Date, end: Date) -> Int {
    return Calendar.current.dateComponents([.day], from: start, to: end).day!
}


