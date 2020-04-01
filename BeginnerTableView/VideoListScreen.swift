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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let strings = createtringNames()
        companies = createCompaniesArray(availableStrings: strings)
        products = createProductsArray()
        invoices = createInvoiceArray(companies: companies, products: products)
        invoicesDto = createInvoiceDtoArray(invoices: invoices)
       // print(companies)
      //  print(products)
        print(invoicesDto)
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





