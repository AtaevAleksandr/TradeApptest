//
//  CurrencyPair.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 21.05.2023.
//

import Foundation
import UIKit

struct CurrencyPair {
    var pair: String
}

extension CurrencyPair {
    static var currencyPairs: [CurrencyPair] = [CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR"),
                                                CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR"),
                                                CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR"),
                                                CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR"),
                                                CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR"),
                                                CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR"),
                                                CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR"),
                                                CurrencyPair(pair: "RUB / USD"), CurrencyPair(pair: "RUB / EUR")
    ]
}
