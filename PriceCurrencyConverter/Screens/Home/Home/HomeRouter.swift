//
//  HomeRouter.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    // MARK: Static methods
	static func createModule() -> UIViewController {
		let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
		
		let viewController = HomeViewController()
		
		viewController.presenter = presenter
		viewController.presenter?.router = HomeRouter()
		viewController.presenter?.view = viewController
		viewController.presenter?.interactor = HomeInteractor()
		viewController.presenter?.interactor?.presenter = presenter
		
		let navigationController = UINavigationController(rootViewController: viewController)
		
		navigationController.navigationBar.prefersLargeTitles = false
		
		return navigationController
	}
	
}
