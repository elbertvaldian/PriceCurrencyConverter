//
//  HomeContract.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol {
	func reloadTable(data: [CurrencyPair])
	func showError(data: Error)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol {
    
    var view: PresenterToViewHomeProtocol? { get set }
	var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
	
	func fetchData(value: Double, currency: CurrencyFrom)
	
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol: class {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
	
	func fetchData(value: Double, currency: CurrencyFrom) 
	
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol {
	func reloadTable(data: CurrencyListResponse)
	func showError(data: Error)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol {
    
}
