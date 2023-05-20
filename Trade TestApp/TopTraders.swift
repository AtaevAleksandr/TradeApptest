//
//  TopTraders.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 20.05.2023.
//

import Foundation
import UIKit

struct Trader {
    var number: Int
    var country: String
    var name: String
    var deposit: Int
    var profit: Int
}

extension Trader {
    static var traders: [Trader] = [Trader(number: 0, country: "", name: "", deposit: 0, profit: 0),
                                    Trader(number: 1, country: "🇷🇺", name: "Aleksandr", deposit: 4395, profit: 334548),
                                    Trader(number: 2, country: "🇨🇦", name: "John", deposit: 4004, profit: 153874),
                                    Trader(number: 3, country: "🇧🇷", name: "Hugo", deposit: 3698, profit: 113458),
                                    Trader(number: 4, country: "🇺🇸", name: "Brian", deposit: 3240, profit: 45652),
                                    Trader(number: 5, country: "🇩🇪", name: "Timo", deposit: 2895, profit: 20156),
                                    Trader(number: 6, country: "🇰🇷", name: "Jacob", deposit: 2185, profit: 12567),
                                    Trader(number: 7, country: "🇫🇷", name: "George", deposit: 1608, profit: 11121),
                                    Trader(number: 8, country: "🇪🇸", name: "William", deposit: 1120, profit: 9987),
                                    Trader(number: 9, country: "🇮🇹", name: "James", deposit: 995, profit: 8624),
                                    Trader(number: 10, country: "🇬🇧", name: "Tom", deposit: 556, profit: 4516)]
}
