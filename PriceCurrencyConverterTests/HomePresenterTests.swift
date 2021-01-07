//
//  HomePresenterTests.swift
//  PriceCurrencyConverterTests
//
//  Created by Elbert Valdian Hardika on 07/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable
import PriceCurrencyConverter

class HomePresenterTests: QuickSpec {

	override func spec() {
		var presenter: HomePresenter!
		
		beforeEach {
			presenter = HomePresenter()
		}
		
		describe("have a correct processed data to UI") {
			context("get correct return") {
				it("should return expected value") {
					let JSON = "{\"success\":true,\"terms\":\"https://currencylayer.com/terms\",\"privacy\":\"https://currencylayer.com/privacy\",\"timestamp\":1609902426,\"source\":\"USD\",\"quotes\":{\"USDEUR\":0.813875,\"USDGBP\":0.735215,\"USDCAD\":1.268805,\"USDPLN\":3.688075}}"
					let data = CurrencyListResponse(JSONString: JSON)
					let processedData = presenter.processData(data: data!)
					
					expect(processedData.count).to(equal(4))
				}
				
				it("should return empty array value") {
					let JSON = "{\"success\":true,\"terms\":\"https://currencylayer.com/terms\",\"privacy\":\"https://currencylayer.com/privacy\",\"timestamp\":1609902426,\"source\":\"USD\"}"
					let data = CurrencyListResponse(JSONString: JSON)
					let processedData = presenter.processData(data: data!)
					
					expect(processedData.count).to(equal(0))
				}
			}
		}
	}
}
