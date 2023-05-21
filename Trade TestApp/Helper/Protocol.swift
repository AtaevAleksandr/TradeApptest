//
//  Protocol.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 21.05.2023.
//

import Foundation

protocol LabelTransferDelegate: AnyObject {
    func transferLabel(withText text: String)
}
