//
//  Int+Extension.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

extension Int {
    func toString() -> String {
        return String(self)
    }
    
    func minutesToHoursMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        if hours == 0 {
            return "\(minutes)m"
        } else if minutes == 0 {
            return "\(hours)h"
        } else {
            return "\(hours)h \(minutes)m"
        }
    }
}
