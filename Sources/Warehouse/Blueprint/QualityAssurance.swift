//
//  QualityAssurance.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation

protocol QualityAssurance {
    func tailorGoods(_ goods: inout [Goods]) throws
}
