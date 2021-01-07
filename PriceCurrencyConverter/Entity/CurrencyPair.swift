//
//  CurrencyPair.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import Foundation

class CurrencyPair {
	var pairFrom: String?
	var pairTo: String?
	var valueFrom: Double?
	var valuePerEach: Double?
	var valueTo: Double?
	
	init(pairFrom: String?, pairTo: String?, valueFrom: Double?, valuePerEach: Double?, valueTo: Double?) {
		self.pairFrom = pairFrom
		self.pairTo = pairTo
		self.valueFrom = valueFrom
		self.valuePerEach = valuePerEach
		self.valueTo = valueTo
	}
}
