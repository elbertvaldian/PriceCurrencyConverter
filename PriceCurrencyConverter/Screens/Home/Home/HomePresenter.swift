//
//  HomePresenter.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
	
	private var value: Double = 0.0
	
	func fetchData(value: Double, currency: CurrencyFrom) {
		self.value = value
		interactor?.fetchData(value: value, currency: currency)
	}
	
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
	func reloadTable(data: CurrencyListResponse) {
		let processedData = processData(data: data)
		view?.reloadTable(data: processedData)
	}
	
	func showError(data: Error) {
		view?.showError(data: data)
	}
	
	func processData(data: CurrencyListResponse) -> [CurrencyPair] {
		guard let source = data.source, let list = data.quotes else {
			return []
		}
		
		var processedData: [CurrencyPair] = []
		
		for item in list {
			let pair = item.key
			let currency = pair.replacingOccurrences(of: source, with: "")
			let processedValue = value*item.value
			
			let currencyPairObject = CurrencyPair(pairFrom: source, pairTo: currency, valueFrom: self.value, valuePerEach: item.value, valueTo: processedValue)
			processedData.append(currencyPairObject)
		}
		
		return processedData
		
	}
}
