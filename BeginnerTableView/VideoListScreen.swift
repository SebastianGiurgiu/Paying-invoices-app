//
//  VideoListScreen.swift
//  BeginnerTableView
//
//  Created by Sean Allen on 5/19/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit

class VideoListScreen: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var companies: [Company] = []
    var products: [Product] = []
    var invoices: [Invoice] = []
    var invoicesDto: [InvoiceDto] = []
    
    
    func sorterAfterDueDate(this:InvoiceDto, that:InvoiceDto) -> Bool {
        return this.dates[0] < that.dates[0]
    }
    
    func sorterAfterPaidDate(this:InvoiceDto, that:InvoiceDto) -> Bool {
        return this.dates[1] < that.dates[1]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let strings = createtringNames()
        companies = createCompaniesArray(availableStrings: strings)
        products = createProductsArray()
        invoices = createInvoiceArray(companies: companies, products: products)
        invoicesDto = createInvoiceDtoArray(invoices: invoices)
        
        var unpaidInvoicesDto =  invoicesDto.filter({ (invoiceDto) in invoiceDto.dates.count == 1 })
        unpaidInvoicesDto.sort(by: sorterAfterDueDate)
        print(unpaidInvoicesDto.count)
        
        var paidInvoicesDto = invoicesDto.filter({ (invoiceDto) in invoiceDto.dates.count == 2 })
        paidInvoicesDto.sort(by: sorterAfterPaidDate)
        print(paidInvoicesDto.count)
        
        invoicesDto = []
        invoicesDto += unpaidInvoicesDto
        invoicesDto += paidInvoicesDto
        
    
        for index in 0..<invoicesDto.count{
            let nrOfElements =  invoicesDto.filter{$0 == invoicesDto[index] }.count
            if nrOfElements > 1 {
                print(invoicesDto[index])
                invoicesDto[index].duplicationFlag = true
            }
        }
          
        
        
       // print(companies)
      //  print(products)
      //  print(invoicesDto)
    }
  
    
}


extension VideoListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return videos.count
        return invoicesDto.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let video = videos[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
//        cell.setVideo(video: video)
        
        let invoiceDto = invoicesDto[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        cell.setInvoiceDto(invoiceDto: invoiceDto)
        return cell
    }
}





