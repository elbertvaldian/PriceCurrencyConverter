//
//  HomeNode.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import UIKit
import Foundation
import AsyncDisplayKit
import RxSwift

class HomeNode: ASDisplayNode {
	var onChangedValue: ((Double, CurrencyFrom) -> Void)?
	
	var currencyList: [CurrencyPair] = []
	var cartCount: Int = 0
	let tableNode: ASTableNode = ASTableNode(style: .plain)
	
	private let numberTextNode = ASEditableTextNode()
	private let currencyTextNode = ASEditableTextNode()
	private let pickerView = ToolbarPickerView()
	
	private var numberValue: Double = 0
	private var currencyValue: CurrencyFrom = .USD
	
	override init() {
		super.init()
		
		automaticallyManagesSubnodes = true
		
		backgroundColor = .white
		configureTextNode()

	}
	
	
	override func didLoad() {
		super.didLoad()
		configureTable()
		configurePickerView()
	}
	
	private func configureTable() {
		tableNode.style.flexGrow = 1.0
		
		tableNode.backgroundColor = .white
		tableNode.view.separatorStyle = .none
		tableNode.view.tableFooterView = UIView()
		tableNode.view.bounces = false
		tableNode.view.showsVerticalScrollIndicator = false
		tableNode.view.allowsSelection = false
		tableNode.dataSource = self
		tableNode.delegate = self
				
	}
	
	private func configurePickerView() {

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		configureSizing(constrainedSize: constrainedSize)
		
		let stackLayout = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .end, children: [setupNumberTextNodeView(), setupCurrencyTextNodeView(), tableNode])
		
		return stackLayout
	}
	
	private func configureTextNode() {
		numberTextNode.borderWidth = 1
		numberTextNode.attributedPlaceholderText = NSAttributedString(string: "Input your number here")
		numberTextNode.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
		numberTextNode.textView.tag = 0
		numberTextNode.textView.delegate = self
		numberTextNode.keyboardType = .numberPad
		
		currencyTextNode.borderWidth = 1
		currencyTextNode.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
		currencyTextNode.textView.text = CurrencyFrom.currencyFromList[0]
		currencyTextNode.textView.inputView = pickerView
		currencyTextNode.textView.inputAccessoryView = pickerView.toolbar
		currencyTextNode.textView.delegate = self
		currencyTextNode.textView.tintColor = UIColor.clear
		currencyTextNode.textView.tag = 1
		
	}
	
	private func configureSizing(constrainedSize: ASSizeRange) {
		numberTextNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 30)
		currencyTextNode.style.preferredSize = CGSize(width: 45, height: 30)
		
	}
	
	private func setupNumberTextNodeView() -> ASLayoutSpec {
		let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: numberTextNode)
		return inset
	}
	
	private func setupCurrencyTextNodeView() -> ASLayoutSpec {
		let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8), child: currencyTextNode)
		
		return inset
	}
	
}

extension HomeNode: ASTableDataSource, ASTableDelegate {
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		
		return currencyList.count
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
		return {
			
			let cellNode = ConvertedCurrencyCellNode(pair: self.currencyList[indexPath.row])
			
			let cell: ASCellNode
			cell = cellNode
			
			
			cell.selectionStyle = .none
			
			return cell
		}
	}
	
}

extension HomeNode: UIPickerViewDelegate, UIPickerViewDataSource, ToolbarPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return CurrencyFrom.currencyFromList.count
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func didTapDone() {
	
		let row = self.pickerView.selectedRow(inComponent: 0)
		let pickedCurrency = CurrencyFrom.currencyFromList[row]
		currencyValue = CurrencyFrom(rawValue: pickedCurrency) ?? .USD
		
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
		self.currencyTextNode.textView.text = pickedCurrency
        self.currencyTextNode.textView.resignFirstResponder()
		
		self.onChangedValue?(numberValue, currencyValue)
	}
	
	func didTapCancel() {
		self.currencyTextNode.textView.text = CurrencyFrom.currencyFromList[0]
        self.currencyTextNode.textView.resignFirstResponder()
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return CurrencyFrom.currencyFromList[row]
	}
}

extension HomeNode: UITextViewDelegate {
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		return true
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.tag == 0 {
			numberTextNode.attributedPlaceholderText = NSAttributedString(string: "")
		}
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if textView.tag == 0 {
			let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
			let compSepByCharInSet = text.components(separatedBy: aSet)
			let numberFiltered = compSepByCharInSet.joined(separator: "")
			return text == numberFiltered
		}
		
		return true
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		switch textView.tag {
		case 0:
			guard let numberValueinString = textView.text, let numberInDouble = Double(numberValueinString) else {
				return
			}
			self.numberValue = numberInDouble
			
			self.onChangedValue?(numberValue, currencyValue)
		default:
			
			break
		}
	}
}
