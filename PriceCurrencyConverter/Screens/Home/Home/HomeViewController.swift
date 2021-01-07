//
//  HomeViewController.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import AsyncDisplayKit

class HomeViewController: ASViewController<ASDisplayNode> {
	
	// MARK: - Properties
	var presenter: ViewToPresenterHomeProtocol?
	
	var mainNode: HomeNode
	
	init() {
		mainNode = HomeNode()
		super.init(node: mainNode)
		
		configureMainNode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Currency Calculator"
		navigationController?.navigationBar.barTintColor = UIColor.white
		edgesForExtendedLayout = []
		
	}
	
	private func configureMainNode() {
		mainNode.onChangedValue = { [weak self] (value: Double, pair: CurrencyFrom) in
			self?.presenter?.fetchData(value: value, currency: pair)
		}
	}
	
}

extension HomeViewController: PresenterToViewHomeProtocol{
    // TODO: Implement View Output Methods
	func reloadTable(data: [CurrencyPair]) {
		mainNode.currencyList = data
		mainNode.tableNode.reloadData()
	}
	
	func showError(data: Error) {
		let alert = UIAlertView()
		alert.title = "\(data.code ?? 0)"
		alert.message = data.info ?? ""
		alert.addButton(withTitle: "OK")
		alert.show()
	}
}
