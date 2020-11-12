//
//  Array+Only.swift
//  Memorize
//
//  Created by Sergio Rodríguez Rama on 12/11/2020.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
