//
//  ProtocolPairSelected.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 21.05.2023.
//

import Foundation

protocol CurrencyPairSelectionDelegate: AnyObject {
    func didSelectCurrencySymbol(_ currencyPairSymbol: String)
}
