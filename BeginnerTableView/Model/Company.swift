//
//  Company.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 01/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//


struct Company: Equatable {
    var name: String
    var phoneNumber: String
    
}


func ==(lhs: Company, rhs: Company) -> Bool {
    return lhs.name == rhs.name
   }

// Define a set of 8 strings that will be used later to represent first names of the companies.
func createtringNames() -> [String] {
      
      return ["Romanian","International","European","Food"
          ,"Electricity","Incorporated","Drink","Gas"]
      
  }


// Generate a new company
func generateNewCompany(numberOfWords: Int, availableStrings: [String]) -> Company {
      
      var c = Company(name: "", phoneNumber: "")
      
      var randomNumbers = Set<Int>()
      while (randomNumbers.count < numberOfWords) {
          randomNumbers.update(with: Int.random(in: 0..<8))
      }

      let randomIndex = Array(randomNumbers)
                    
      for indexFromAvailableStrings in randomIndex {
          c.name += availableStrings[indexFromAvailableStrings]
          c.name += " "
       }
      
      c.name.removeLast()
      let phoneNumber = generatePhoneNumber()
      c.phoneNumber = phoneNumber
      
      return c
  }

// Generate a new phone number
func generatePhoneNumber() -> String {
    
    var phoneNumber = ""
    
    for _ in 1...14 {
        let x = Int.random(in: 0...9)
        phoneNumber.append(String(x))
    }
    
    return phoneNumber
}
  
// Create an array with companies
func createCompaniesArray( availableStrings: [String], nrOfCompanies : Int) -> [Company] {
    
  var companies: [Company] = []
    
   // create 3 companies with 3 strings in their name
    var nrOfC = 1
    while nrOfC <= 3 {
        let c = generateNewCompany(numberOfWords: 3, availableStrings: availableStrings)
        if !companies.contains(c) {
            companies.append(c)
            nrOfC += 1
        }
    }
    
    // create companies with 2 or 3 strings in their name
    while nrOfC <= nrOfCompanies {
        let numberOfWords = Int.random(in: 2...3)
        let c = generateNewCompany(numberOfWords: numberOfWords, availableStrings: availableStrings)
        if !companies.contains(c) {
                companies.append(c)
                nrOfC += 1
            }
        }
  return companies
  
}







