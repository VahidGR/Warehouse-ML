//
//  File.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation


extension Date {
    static var valid: Date = Date().addingTimeInterval(10_000)
}

extension Date {
    static var expired: Date = Date().addingTimeInterval(-5_000)
}
