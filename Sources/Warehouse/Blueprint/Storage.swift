//
//  File.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation

protocol Storage {
    func store<T: Goods>(_ goods: T) throws
}
