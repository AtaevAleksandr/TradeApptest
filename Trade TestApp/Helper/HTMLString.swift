//
//  HTMLString.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 21.05.2023.
//

import Foundation

struct HTMLUrl {

    static var pair = CurrencyPair.currencyPairs.first
    static var htmlString = """
                <html>
                <head>
                <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
                </head>
                <div class="tradingview-widget-container">
                    <div id="tradingview_a9d18"></div>
                    <script type="text/javascript">
                    new TradingView.widget(
                {
                "autosize": true,
                "symbol": "\(pair?.symbol ?? "Error")",
                "interval": "D",
                "timezone": "Etc/UTC",
                "theme": "light",
                "style": "1",
                "locale": "en",
                "toolbar_bg": "#f1f3f6",
                "enable_publishing": false,
                "allow_symbol_change": true,
                "container_id": "tradingview_80ff7"
                }
                    );
                    </script>
                </div>
                </html>
                """
}
