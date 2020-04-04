//
//  Database.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 04/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Database {
    
    var managedContext: NSManagedObjectContext
    
    
    init() {
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        self.managedContext =
              (appDelegate?.persistentContainer.viewContext)!
    }
    
    
    func addAllCompaniesInCoreData(companies: [Company]) {
        
        let entity =
          NSEntityDescription.entity(forEntityName: "CompanyCoreData",
                                     in: self.managedContext)!
        
        for company in companies {
            let companyDataCoreForInsert = NSManagedObject(entity: entity,
                                                           insertInto: self.managedContext)
            companyDataCoreForInsert.setValue(company.name, forKeyPath: "name")
            companyDataCoreForInsert.setValue(company.phoneNumber, forKeyPath: "phoneNumber")
        }
       
        do {
            try self.managedContext.save()
         // companiesCoreData.append(company)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func addAllProductInCoreData(products: [Product]) {
        
        let entity =
          NSEntityDescription.entity(forEntityName: "ProductCoreData",
                                     in: self.managedContext)!
        
        for product in products {
            let productDataCoreForInsert = NSManagedObject(entity: entity,
                                                           insertInto: self.managedContext)
            
            productDataCoreForInsert.setValue(product.productNumber, forKey: "productNumber")
            productDataCoreForInsert.setValue(product.name, forKey: "name")
            productDataCoreForInsert.setValue(product.price, forKey: "price")
        }
       
        do {
            try self.managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func addAllInvoiceInCoreData(invoices: [Invoice]) {
           
           let entity =
             NSEntityDescription.entity(forEntityName: "InvoiceCoreData",
                                        in: self.managedContext)!
           
           for invoice in invoices {
               let invoiceDataCoreForInsert = NSManagedObject(entity: entity,
                                                              insertInto: self.managedContext)
            
            invoiceDataCoreForInsert.setValue(invoice.invoiceNumber, forKey: "invoiceNumber")
            invoiceDataCoreForInsert.setValue(invoice.seller, forKey: "seller")
            invoiceDataCoreForInsert.setValue(invoice.total, forKey: "total")
            invoiceDataCoreForInsert.setValue(invoice.dueDate, forKey: "dueDate")
            invoiceDataCoreForInsert.setValue(invoice.payDate, forKey: "payDate")
            
           }
          
           do {
               try self.managedContext.save()
           } catch let error as NSError {
             print("Could not save. \(error), \(error.userInfo)")
           }
       }
    
    
    func deleteAllData(entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try self.managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
               // print("sterg chestii")
                self.managedContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
        
        do {
            try self.managedContext.save()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
    }
    
    
    func showAllProduct() {
        
        var productsCoreData : [NSManagedObject] = []
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "ProductCoreData")
        
        do {
            productsCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print("======================")
        for result in productsCoreData {
            let name = result.value(forKey: "name") as? String
            let price = result.value(forKey: "price") as? Double
            let productNumber = result.value(forKey: "productNumber") as? Int16
            print("Product Number: \(productNumber!) ; Name: \(name!); price : \(price!)")
        }
        
        print("======================")
    }
    
    
    func showInvoicesProduct() {
           
           var invoicesCoreData : [NSManagedObject] = []
           
           let fetchRequest =
             NSFetchRequest<NSManagedObject>(entityName: "InvoiceCoreData")
           
           do {
               invoicesCoreData = try managedContext.fetch(fetchRequest)
           } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
           }
           
           print("======================")
           for result in invoicesCoreData {
            let invoiceNumber = result.value(forKey: "invoiceNumber") as? Int16
            let seller = result.value(forKey: "seller") as? String
            let total = result.value(forKey: "total") as? Double
            let dueDate = result.value(forKey: "dueDate") as? Date
            let payDate = result.value(forKey: "payDate") as? Date
            
            print("Invoice Number: \(invoiceNumber!) ; Seller: \(seller!); total : \(total!) ; dueDate: \(dueDate!) " )
            
            if payDate != nil {
                print("payDate  \(payDate!)")
            }
           }
           
           print("======================")
       }
       
    
    
    
    
    
}

func getManagedContext() -> NSManagedObjectContext {
 
    let appDelegate =
      UIApplication.shared.delegate as? AppDelegate
    
    let managedContext =
        appDelegate?.persistentContainer.viewContext
    
    return managedContext!
    
}


