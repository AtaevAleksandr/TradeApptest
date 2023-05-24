//
//  CurrencyPair.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 21.05.2023.
//

import Foundation
import UIKit

struct CurrencyPair {
    var name: String
    var symbol: String
}

extension CurrencyPair {
    static var currencyPairs: [CurrencyPair] = [
        CurrencyPair(name: "EUR / USD", symbol: "FX:EURUSD"),
        CurrencyPair(name: "GPB / USD", symbol: "FX:GBPUSD"),
        CurrencyPair(name: "USD / JPY", symbol: "FX:USDJPY"),
        CurrencyPair(name: "GBP / JPY", symbol: "FX:GBPJPY"),
        CurrencyPair(name: "AUD / USD", symbol: "FX:AUDUSD"),
        CurrencyPair(name: "USD / CAD", symbol: "FX:USDCAD"),
        CurrencyPair(name: "EUR / JPY", symbol: "FX:EURJPY"),
        CurrencyPair(name: "USD / CHF", symbol: "FX:USDCHF"),
        CurrencyPair(name: "NZD / USD", symbol: "FX:NZDUSD"),
        CurrencyPair(name: "AUD / JPY", symbol: "FX:AUDJPY"),
        CurrencyPair(name: "EUR / GBP", symbol: "FX:EURGBP"),
        CurrencyPair(name: "EUR / AUD", symbol: "FX:EURAUD"),
        CurrencyPair(name: "CAD / JPY", symbol: "FX:CADJPY"),
        CurrencyPair(name: "GBP / AUD", symbol: "FX:GBPAUD")
    ]
}
