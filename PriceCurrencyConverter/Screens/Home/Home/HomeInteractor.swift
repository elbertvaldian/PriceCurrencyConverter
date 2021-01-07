//
//  HomeInteractor.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class HomeInteractor: PresenterToInteractorHomeProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterHomeProtocol?
	
	func fetchData(value: Double, currency: CurrencyFrom) {
		let URL = "http://api.currencylayer.com/api/live?access_key=a371affc1320100c274821397a007895&currencies=\(CurrencyTo.toString)&source=\(currency.rawValue)&format=1"
		
		AF.request(URL).responseString { [weak self] response in
			guard let responseString = response.value,
				let respond = Mapper<CurrencyListResponse>().map(JSONString: responseString)
			else {
				return
			}
			
			if respond.success == true {
				self?.presenter?.reloadTable(data: respond)
			} else {
				guard let errorData = respond.error else {
					return
				}
				self?.presenter?.showError(data: errorData)
			}
		}
	}
}
