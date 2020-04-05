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
           
           let invoiceEntity =
             NSEntityDescription.entity(forEntityName: "InvoiceCoreData",
                                        in: self.managedContext)!
        
            let invoiceProductEntity =
                 NSEntityDescription.entity(forEntityName: "InvoiceProductCoreData",
                                            in: self.managedContext)!
            
           
           for invoice in invoices {
               let invoiceDataCoreForInsert = NSManagedObject(entity: invoiceEntity,
                                                              insertInto: self.managedContext)
            
                invoiceDataCoreForInsert.setValue(invoice.invoiceNumber, forKey: "invoiceNumber")
                invoiceDataCoreForInsert.setValue(invoice.seller, forKey: "seller")
                invoiceDataCoreForInsert.setValue(invoice.total, forKey: "total")
                invoiceDataCoreForInsert.setValue(invoice.dueDate, forKey: "dueDate")
                invoiceDataCoreForInsert.setValue(invoice.payDate, forKey: "payDate")
                
                for prod in invoice.products {
                    
                    let invoiceProductDataCoreForInsert = NSManagedObject(entity: invoiceProductEntity,
                    insertInto: self.managedContext)
                    
                    invoiceProductDataCoreForInsert.setValue(invoice.invoiceNumber, forKey: "invoiceNumber")
                    invoiceProductDataCoreForInsert.setValue(prod.productNumber, forKey: "productNumber")
                }
                
            
            
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
    
    func showAllCompanies() {
        
        var companiesCoreData : [NSManagedObject] = []
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "CompanyCoreData")
        
        do {
            companiesCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print("======================")
        for result in companiesCoreData {
            let name = result.value(forKey: "name") as? String
            let phoneNumber = result.value(forKey: "phoneNumber") as? String
            print("Name: \(name!) ; Phone Number: \(phoneNumber!)")
        }
        
        print("======================")
    }
    
    
    func getCompaniesFromCoreData() -> [Company] {
        var companies : [Company] = []
        var companiesCoreData : [NSManagedObject] = []
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "CompanyCoreData")
        
        do {
            companiesCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for result in companiesCoreData {
            let name = result.value(forKey: "name") as? String
            let phoneNumber = result.value(forKey: "phoneNumber") as? String
            let c = Company(name: name!, phoneNumber: phoneNumber!)
            companies.append(c)
        }
        return companies
    }
    
    
    func getProductsFromCoreData() -> [Product] {
        var products : [Product] = []
        var productsCoreData : [NSManagedObject] = []
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "ProductCoreData")
        
        do {
            productsCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for result in productsCoreData {
            let name = result.value(forKey: "name") as? String
            let price = result.value(forKey: "price") as? Double
            let productNumber = result.value(forKey: "productNumber") as? Int16
            let p = Product(productNumber: Int(productNumber!), name: name!, price: price!)
            products.append(p)
        }
        
        return products
    }
    
    
    func getProductFromCoreDataAfterProductNumber(productNumber: Int16) -> Product {
        
        var productsCoreData : [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCoreData")
        var p = Product(productNumber: Int(productNumber), name: "", price: 0)
//        let predicate = NSPredicate(format: "productNumber = %@", productNumber)
//        fetchRequest.predicate = predicate
               
        do {
            productsCoreData = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            }
               
        for result in productsCoreData {
            let pN = result.value(forKey: "productNumber") as? Int16
            
            if productNumber == pN {
                let name = result.value(forKey: "name") as? String
                let price = result.value(forKey: "price") as? Double
                p.name = name!
                p.price = price!
            }
        }
        
        return p
        
    }
    
    
    func getProductsForAnInvoice(invoiceNumber: Int16) -> [Product] {
        
        var products : [Product] = []
        var invoicesProductCoreData : [NSManagedObject] = []
               
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InvoiceProductCoreData")
        // let predicate = NSPredicate(format: "invoiceNumber == %@", invoiceNumber)
        // fetchRequest.predicate = predicate
        
        do {
            invoicesProductCoreData = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
           
        for result in invoicesProductCoreData {
            
            let iN = result.value(forKey: "invoiceNumber") as? Int16
            if invoiceNumber == iN {
                let productNumber = result.value(forKey: "productNumber") as? Int16
                let p = getProductFromCoreDataAfterProductNumber(productNumber: productNumber!)
                products.append(p)
            }
        }
        
        return products
    }
    
    
    func getInvoiceFromCoreData() -> [Invoice] {
        var invoices : [Invoice] = []
        var invoicesCoreData : [NSManagedObject] = []
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "InvoiceCoreData")
        
        do {
            invoicesCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for result in invoicesCoreData {
            
            let invoiceNumber = result.value(forKey: "invoiceNumber") as? Int16
            let seller = result.value(forKey: "seller") as? String
            let total = result.value(forKey: "total") as? Double
            let dueDate = result.value(forKey: "dueDate") as? Date
            let payDate = result.value(forKey: "payDate") as? Date
            let products = getProductsForAnInvoice(invoiceNumber: invoiceNumber!)
            
            if payDate != nil {
             let i = Invoice(invoiceNumber: Int(invoiceNumber!), seller: seller!, products: products, total: total!, dueDate: dueDate!, payDate: payDate!)
            invoices.append(i)
            } else {
                let i = Invoice(invoiceNumber: Int(invoiceNumber!), seller: seller!, products: products, total: total!, dueDate: dueDate!)
                invoices.append(i)
            }
            
        }
        return invoices
    }
    
    
    
    
    
    
    func showAllProducts() {
        
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
    
    
    func showAllInvoices() {
           
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
       
    func showAllInvoicesProductBinds() {
        
        var invoicesProductCoreData : [NSManagedObject] = []
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "InvoiceProductCoreData")
        
        do {
            invoicesProductCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print("======================")
        for result in invoicesProductCoreData {
         let invoiceNumber = result.value(forKey: "invoiceNumber") as? Int16
         let productNumber = result.value(forKey: "productNumber") as? Int16
         
         print("Invoice Number: \(invoiceNumber!) ; Product Number: \(productNumber!)" )
         
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


