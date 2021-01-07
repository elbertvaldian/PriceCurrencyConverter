//
//  CurrencyListResponse.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import ObjectMapper

class CurrencyListResponse: Mappable {
    var success: Bool?
	var source: String?
	var quotes: [String: Double]?
	var error: Error?
    
	required init?(map: Map){

	}
    
    func mapping(map: Map) {
        success <- map["success"]
		source <- map["source"]
        quotes <- map["quotes"]
		error <- map["error"]
    }
}

class Error: Mappable {
    var code: Int?
	var info: String?
    
	required init?(map: Map){

	}
    
    func mapping(map: Map) {
        code <- map["code"]
        info <- map["info"]
    }
}
