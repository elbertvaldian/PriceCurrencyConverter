//
//  Constants.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import Foundation

enum CurrencyFrom: String , CaseIterable {
	case USD = "USD"
	case IDR = "IDR"
	case JPY = "JPY"
	case SGD = "SGD"
	
	static var currencyFromList: [String] {
		return CurrencyFrom.allCases.map { $0.rawValue }
	}
}

enum CurrencyTo: String , CaseIterable {
	case USD = "USD"
	case IDR = "IDR"
	case JPY = "JPY"
	case SGD = "SGD"
	case GBP = "GBP"
	case EUR = "EUR"
	
	static var currencyToList: [String] {
		return CurrencyTo.allCases.map { $0.rawValue }
	}
	
	static var toString: String {
		var string = ""
		var count = 0
		for item in currencyToList {
			let stringTemp = count == 0 ?"\(item)" : "\(item),\(string)"
			string = stringTemp
			count = count+1
		}
		
		return string
	}
}
