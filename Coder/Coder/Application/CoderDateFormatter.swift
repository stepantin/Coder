//
//  CoderDateFormatter.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import Foundation

// MARK: - Enums
enum DayFormat: String {
    case d = "d"
    case dd = "dd"
}

enum MonthFormat: String {
    case MM = "MM"
    case MMM = "MMM"
    case MMMM = "MMMM"
}

enum YearFormat: String {
    case yy = "yy"
    case yyyy = "yyyy"
}

// MARK: - CoderDateFormatter
final class CoderDateFormatter {
    
    // MARK: - Properties
    var year: String?
    var month: String?
    var day: String?
    var nextBirthdayYear: Int?
    
    // MARK: - Private Properties
    private let currentDayFormatter = DateFormatter()
    private let currentMonthFormatter = DateFormatter()
    private let currentYearFormatter = DateFormatter()
    
    // MARK: - Initializers
    init() {
        getCurrentDate()
    }
    
    init(dateString: String, inputDateFormat: String, outputDayFormat: DayFormat, outputMonthFormat: MonthFormat, outputYearFormat: YearFormat) {
        let dateFormatterGet = DateFormatter()
        let dayFormatterSet = DateFormatter()
        let monthFormatterSet = DateFormatter()
        let yearFormatterSet = DateFormatter()
        
        dateFormatterGet.dateFormat = inputDateFormat

        dayFormatterSet.setLocalizedDateFormatFromTemplate(outputDayFormat.rawValue)
        monthFormatterSet.setLocalizedDateFormatFromTemplate("MM")
        yearFormatterSet.setLocalizedDateFormatFromTemplate(outputYearFormat.rawValue)
        
        let date: Date? = dateFormatterGet.date(from: dateString)
        
        if let date = date {
            
            self.day = dayFormatterSet.string(from: date)
            
            var month = String()
            switch monthFormatterSet.string(from: date) {
            case "01": month = "января"
            case "02": month = "февраля"
            case "03": month = "марта"
            case "04": month = "апреля"
            case "05": month = "мая"
            case "06": month = "июня"
            case "07": month = "июля"
            case "08": month = "августа"
            case "09": month = "сентября"
            case "10": month = "октября"
            case "11": month = "ноября"
            case "12": month = "декабря"
            default: break
            }
            
            switch outputMonthFormat {
            case .MM: self.month = monthFormatterSet.string(from: date)
            case .MMM: self.month = shorten(valueString: month, to: 3)
            case .MMMM: self.month = month
            }
            self.year = yearFormatterSet.string(from: date)
            
            calculateNextBirthdayYear()
        }
    }
    
    // MARK: - Methods
    func configureWith(dateElement: [String]) -> String {
        dateElement.joined(separator: " ")
    }
    
    func calculateAge() -> String {
        setLocalizedDateFormatsFromTemplate()

        let currentDay = currentDayFormatter.string(from: Date())
        let currentMonth = currentMonthFormatter.string(from: Date())
        let currentYear = currentYearFormatter.string(from: Date())
        
        guard let day = Int(self.day!),
              let month = Int(self.month!),
              let year = Int(self.year!),
              let currentDay = Int(currentDay),
              let currentMonth = Int(currentMonth),
              let currentYear = Int(currentYear)
        else { return "" }

        var age = currentYear - year
        
        if currentMonth == month {
            if currentDay < day {
                age -= 1
            }
        }
        
        if currentMonth < month {
            age -= 1
        }
        
        var stringAge = String()
        
        switch (age, String(age).last) {
        case (10, _): stringAge = "\(age) лет"
        case (11, _): stringAge = "\(age) лет"
        case (12, _): stringAge = "\(age) лет"
        case (13, _): stringAge = "\(age) лет"
        case (14, _): stringAge = "\(age) лет"
        case (15, _): stringAge = "\(age) лет"
        case (16, _): stringAge = "\(age) лет"
        case (17, _): stringAge = "\(age) лет"
        case (18, _): stringAge = "\(age) лет"
        case (19, _): stringAge = "\(age) лет"
        case (_, "1"): stringAge = "\(age) год"
        case (_, "2"): stringAge = "\(age) года"
        case (_, "3"): stringAge = "\(age) года"
        case (_, "4"): stringAge = "\(age) года"
        case (_, "5"): stringAge = "\(age) лет"
        case (_, "6"): stringAge = "\(age) лет"
        case (_, "7"): stringAge = "\(age) лет"
        case (_, "8"): stringAge = "\(age) лет"
        case (_, "9"): stringAge = "\(age) лет"
        case (_, "0"): stringAge = "\(age) лет"
        default: break
        }
    
        return stringAge
    }
    
    // MARK: - Private Methods
    private func setLocalizedDateFormatsFromTemplate() {
        currentDayFormatter.setLocalizedDateFormatFromTemplate("dd")
        currentMonthFormatter.setLocalizedDateFormatFromTemplate("MM")
        currentYearFormatter.setLocalizedDateFormatFromTemplate("YYYY")
    }
    
    private func calculateNextBirthdayYear() {
        setLocalizedDateFormatsFromTemplate()

        let currentDay = currentDayFormatter.string(from: Date())
        let currentMonth = currentMonthFormatter.string(from: Date())
        let currentYear = currentYearFormatter.string(from: Date())
        
        guard let day = Int(self.day!),
              let month = Int(self.month!),
              let currentDay = Int(currentDay),
              let currentMonth = Int(currentMonth),
              let currentYear = Int(currentYear)
        else { return }

        self.nextBirthdayYear = currentYear
        
        if currentMonth == month {
            if currentDay > day {
                self.nextBirthdayYear! += 1
            }
        }
        
        if currentMonth > month {
            self.nextBirthdayYear! += 1
        }
    }
    
    private func shorten(valueString: String, to charCount: Int) -> String {
        guard !valueString.isEmpty && valueString.count >= charCount else { return "" }
        
        var value = valueString
    
        while value.count > 3 {
            value.removeLast()
        }
        
        return value
    }
    
    private func getCurrentDate() {
        setLocalizedDateFormatsFromTemplate()
        
        self.day = currentDayFormatter.string(from: Date())
        self.month = currentMonthFormatter.string(from: Date())
        self.year = currentYearFormatter.string(from: Date())
    }
}

