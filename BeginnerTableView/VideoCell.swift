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
    
//    func setVideo(video: Video) {
//    }
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
        
        prod1Name.text = invoiceDto.products[0]
        if(invoiceDto.products.count == 2 ){
            prod2Name.text = invoiceDto.products[1]
        }
        
        if(invoiceDto.products.count == 3 ){
            prod3Name.text = invoiceDto.products[2]
        }
        
        total.text = String(invoiceDto.total)
        
        if invoiceDto.duplicationFlag == true {
            duplicat.text = "duplicatttt"
        } else {
             duplicat.text = ""
        }
        
        
        
       }
    
}
