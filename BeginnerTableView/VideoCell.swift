//
//  VideoCell.swift
//  BeginnerTableView
//
//  Created by Sean Allen on 5/19/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var prod1Name: UILabel!
    @IBOutlet weak var prod2Name: UILabel!
    @IBOutlet weak var prod3Name: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var paidDate: UILabel!
    @IBOutlet weak var duplicat: UILabel!

    
    func setInvoiceDto(invoiceDto: InvoiceDto) {
        sellerName.text = invoiceDto.seller
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let dueDateString = df.string(from: invoiceDto.dates[0])
        dueDate.text = dueDateString
        
        if invoiceDto.dates.count > 1 {
            let paidDateString = df.string(from: invoiceDto.dates[1])
            paidDate.text = paidDateString
        }
        
        if(invoiceDto.products.count == 1 ){
           prod1Name.text = invoiceDto.products[0]
           prod2Name.text = "p2"
           prod3Name.text = "p3"
        }
        
        
        if(invoiceDto.products.count == 2 ){
            prod1Name.text = invoiceDto.products[0]
            prod2Name.text = invoiceDto.products[1]
            prod3Name.text = "p3"
        }
        
        
        if(invoiceDto.products.count == 3 ){
            prod1Name.text = invoiceDto.products[0]
            prod2Name.text = invoiceDto.products[1]
            prod3Name.text = invoiceDto.products[2]
        }
        
        total.text = String(invoiceDto.total)
        
        if invoiceDto.duplicationFlag == true {
            duplicat.text = "duplicatttt"
        } else {
             duplicat.text = ""
        }
        
       }
    

    func setInvoiceDto2(invoiceDto: InvoiceDto, searchText: String) {
            sellerName.text = invoiceDto.seller
            
            colorLabel(label: sellerName,searchText: searchText)
        
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            
            let dueDateString = df.string(from: invoiceDto.dates[0])
            dueDate.text = dueDateString
            
            if invoiceDto.dates.count > 1 {
                let paidDateString = df.string(from: invoiceDto.dates[1])
                paidDate.text = paidDateString
            }
            
            if(invoiceDto.products.count == 1 ){
               prod1Name.text = invoiceDto.products[0]
               colorLabel(label: prod1Name,searchText: searchText)
               prod2Name.text = "p2"
               prod3Name.text = "p3"
            }
            
            
            if(invoiceDto.products.count == 2 ){
                prod1Name.text = invoiceDto.products[0]
                colorLabel(label: prod1Name,searchText: searchText)
                prod2Name.text = invoiceDto.products[1]
                colorLabel(label: prod2Name,searchText: searchText)
                prod3Name.text = "p3"
            }
            
            
            if(invoiceDto.products.count == 3 ){
                prod1Name.text = invoiceDto.products[0]
                colorLabel(label: prod1Name,searchText: searchText)
                prod2Name.text = invoiceDto.products[1]
                colorLabel(label: prod2Name,searchText: searchText)
                prod3Name.text = invoiceDto.products[2]
                colorLabel(label: prod3Name,searchText: searchText)
            }
            
            total.text = String(invoiceDto.total)
            
            if invoiceDto.duplicationFlag == true {
                duplicat.text = "duplicatttt"
            } else {
                 duplicat.text = ""
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
