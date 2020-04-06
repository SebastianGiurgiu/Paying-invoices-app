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


func createtringNames() -> [String] {
      
      return ["Romanian","International","European","Food"
          ,"Electricity","Incorporated","Drink","Gas"]
      
  }



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

func generatePhoneNumber() -> String {
    
    var phoneNumber = ""
    
    for _ in 1...14 {
        let x = Int.random(in: 0...9)
        phoneNumber.append(String(x))
    }
    
    return phoneNumber
}
  

func createCompaniesArray( availableStrings: [String], nrOfCompanies : Int) -> [Company] {
    
  var companies: [Company] = []
   
    var nrOfCompaniesAtLeast3Words = 1
    while nrOfCompaniesAtLeast3Words <= 3 {
        let c = generateNewCompany(numberOfWords: 3, availableStrings: availableStrings)
        if !companies.contains(c) {
            companies.append(c)
            nrOfCompaniesAtLeast3Words += 1
        }
    }
    
    var nrOfOtherCompanies = 1
    while nrOfOtherCompanies <= nrOfCompanies {
        let numberOfWords = Int.random(in: 2..<4)
        let c = generateNewCompany(numberOfWords: numberOfWords, availableStrings: availableStrings)
        if !companies.contains(c) {
                companies.append(c)
                nrOfOtherCompanies += 1
            }
        }
  return companies
  
}







