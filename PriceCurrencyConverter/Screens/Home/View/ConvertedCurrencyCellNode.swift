//
//  ConvertedCurrencyCellNode.swift
//  PriceCurrencyConverter
//
//  Created by Elbert Valdian Hardika on 06/01/21.
//  Copyright © 2021 Elbert Valdian Hardika. All rights reserved.
//

import UIKit
import Foundation
import AsyncDisplayKit

class ConvertedCurrencyCellNode: ASCellNode {

	private let firstLineTextNode = ASTextNode()
	private let secondLineTextNode = ASTextNode()
	private var pair: CurrencyPair
	
	init(pair: CurrencyPair) {
		self.pair = pair
		super.init()
		
		automaticallyManagesSubnodes = true
		
		backgroundColor = .white
		configureTextNode()

	}
	
	
	override func didLoad() {
		super.didLoad()
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		configureSizing(constrainedSize: constrainedSize)
	
		let stackLayout = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .end, children: [firstLineTextNode, secondLineTextNode])
		let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: stackLayout)
		
		return inset
	}
	
	private func configureTextNode() {
		guard let pairFrom = pair.pairFrom,
			let pairTo = pair.pairTo,
			let valuePerEach = pair.valuePerEach,
			let valueFrom = pair.valueFrom,
			let valueTo = pair.valueTo else {
				return
		}
		
		let firstLineAttrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-medium", size: 18.0)]
		let firstLineString = NSAttributedString(string: "\(valueFrom) \(pairFrom) = \(valueTo) \(pairTo)", attributes: firstLineAttrs)

		firstLineTextNode.attributedText = firstLineString
		
		let secondLineAttrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-medium", size: 14.0)]
		let secondLineString = NSAttributedString(string: "Value per each \(pairFrom) is \(valuePerEach) \(pairTo)", attributes: secondLineAttrs)

		secondLineTextNode.attributedText = secondLineString
		
	}
	
	private func configureSizing(constrainedSize: ASSizeRange) {
		firstLineTextNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 20)
		secondLineTextNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 15)

	}
	
}

