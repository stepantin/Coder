//
//  SectionModel.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import Foundation

struct SectionModel {
    
    // MARK: - Properties
    let yearSection: String
    var sectionEmployees: [Employee]
    
    // MARK: - Private Properties
    private var nextBirthdayYearList = [Employee]()
    private var currentBirthdayYearList = [Employee]()
    private let currentDate = CoderDateFormatter()
        
    // MARK: - Initializers
    init(yearSection: String, sectionEmployees: [Employee]) {
        self.yearSection = yearSection
        self.sectionEmployees = sectionEmployees
    }

    // MARK: - Mutating Methods
    mutating func getCurrentBirthdayYear() -> [Employee] {
        guard let currentYear = Int(currentDate.year!) else { return [] }
        
        self.currentBirthdayYearList = sectionEmployees.filter { employee in
            let birthday = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: "yyyy-MM-dd", outputDayFormat: .d, outputMonthFormat: .MM, outputYearFormat: .yyyy)
            
            guard let nextBirthdayYear = birthday.nextBirthdayYear else { return false }
                                                
            return nextBirthdayYear == currentYear
        }
        sortedList(&self.currentBirthdayYearList)
        
        return self.currentBirthdayYearList
    }
    
    mutating func getNextBirthdayYearList() -> [Employee] {
        guard let currentYear = Int(currentDate.year!) else { return [] }
        
        self.nextBirthdayYearList = sectionEmployees.filter { employee in
            let birthday = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: "yyyy-MM-dd", outputDayFormat: .d, outputMonthFormat: .MM, outputYearFormat: .yyyy)
            
            guard let nextBirthdayYear = birthday.nextBirthdayYear
            else { return false }
            
            return nextBirthdayYear > currentYear
        }
        
        sortedList(&self.nextBirthdayYearList)

       
        return self.nextBirthdayYearList
    }
    
    // MARK: - Methods
    func sortedList(_ employeeList: inout [Employee]) {
        employeeList = employeeList.sorted {
            let firstBirthday = CoderDateFormatter(dateString: $0.birthday, inputDateFormat: "yyyy-MM-dd", outputDayFormat: .dd, outputMonthFormat: .MM, outputYearFormat: .yyyy)
            let secondBirthday = CoderDateFormatter(dateString: $1.birthday, inputDateFormat: "yyyy-MM-dd", outputDayFormat: .dd, outputMonthFormat: .MM, outputYearFormat: .yyyy)
            
            if firstBirthday.month! == secondBirthday.month! {
                return firstBirthday.day! < secondBirthday.day!
            }
            
            return firstBirthday.month! < secondBirthday.month!
        }
    }
}


