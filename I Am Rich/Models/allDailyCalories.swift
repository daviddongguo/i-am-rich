//
//  allDailyCalories.swift
//  I Am Rich
//
//  Created by david on 2023-08-11.
//

import DGCharts
import Foundation


struct DateTimeCalorie {
    var dateTime: Date
    var calorie: Double
    
    static func days() -> [String] {
        return self.dataEntries(self.allDailyCalorie).map { entry in
            if let formattedDay = dayOfYearToString(Int(entry.x)) {
//                return formattedDay
                return "Jun 1"
            } else {
//                return "Invalid day"
                return "JUn 1"
            }
        }
    }
    
    static func dataEntries(_ dateTimeCalories: [DateTimeCalorie]) -> [BarChartDataEntry] {
        var aggregatedData: [String: Double] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for dateTimeCalorie in dateTimeCalories {

            let dateString = dateFormatter.string(from: dateTimeCalorie.dateTime)
            
            if let existingCalorie = aggregatedData[dateString] {
                aggregatedData[dateString] = existingCalorie + dateTimeCalorie.calorie
            } else {
                aggregatedData[dateString] = dateTimeCalorie.calorie
            }
        }
        
        let calendar = Calendar.current
        return aggregatedData.map { BarChartDataEntry(x: Double(calendar.ordinality(of: .day, in: .year, for: dateFormatter.date(from: $0.key)!) ?? 1), y: $0.value) }
//        return aggregatedData.map { BarChartDataEntry(x: Double(calendar.component(.day, from: dateFormatter.date(from: $0.key)!)), y: $0.value) }
//        return aggregatedData.map { BarChartDataEntry(x: $0.key.toTimeInterval(),  y: $0.value) }
    }
    
    static var allDailyCalorie: [DateTimeCalorie] {
        [
            
            DateTimeCalorie(dateTime: parseDate("2023-08-3 07:30"), calorie: 1200.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-4 07:30"), calorie: 1200.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-5 07:30"), calorie: 1600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-6 07:30"), calorie: 2600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-7 07:30"), calorie: 1600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-8 07:30"), calorie: 1600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-9 07:30"), calorie: 600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-10 07:30"), calorie: 600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-10 13:30"), calorie: 600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-10 18:30"), calorie: 400.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-11 07:30"), calorie: 600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-11 13:30"), calorie: 600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-11 18:30"), calorie: 300.0),
        ]
    }
    
    static func parseDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return Date()
    }
    
    static func dayOfYearToString(_ dayOfYear: Int) -> String? {
        guard dayOfYear >= 1 && dayOfYear <= 366 else {
            return nil
        }
        
        let dateComponents = DateComponents(year: Calendar.current.component(.year, from: Date()), day: dayOfYear)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        if let date = Calendar.current.date(from: dateComponents) {
            let dayFormatter = NumberFormatter()
            dayFormatter.numberStyle = .ordinal
            if let day = dayFormatter.string(from: dayOfYear as NSNumber) {
                return dateFormatter.string(from: date) + " " + day
            }
        }
        
        return nil
    }

}

extension String {
    func toTimeInterval() -> TimeInterval {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date.timeIntervalSince1970
        }
        return 0
    }
}

