//
//  String+Extension.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation

extension String {
    func formatDate(from inputFormat: String, to outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func formatReviewDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = dateFormatter.date(from: self) {
            let currentDate = Date()
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: date, to: currentDate)
            
            if let month = components.month, month > 0 {
                dateFormatter.dateFormat = "dd MMM yy"
                return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "HH:mm"
                let timeSince = "\(components.hour ?? 0)h \(components.minute ?? 0)m ago"
                return "\(timeSince)"
            }
        } else {
            return "Invalid date format"
        }
    }
}
