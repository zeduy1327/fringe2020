//
//  CardStackLayoutProvider.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import UIKit

protocol CardStackLayoutProvidable {
  func createCardContainerFrame(for cardStack: SwipeCardStack) -> CGRect
  func createCardFrame(for cardStack: SwipeCardStack) -> CGRect
}

class CardStackLayoutProvider: CardStackLayoutProvidable {

  static let shared = CardStackLayoutProvider()

  func createCardContainerFrame(for cardStack: SwipeCardStack) -> CGRect {
    let insets = cardStack.cardStackInsets
    let width = cardStack.bounds.width - (insets.left + insets.right)
    let height = cardStack.bounds.height - (insets.top + insets.bottom)
    return CGRect(x: insets.left, y: insets.top, width: width, height: height)
  }

  func createCardFrame(for cardStack: SwipeCardStack) -> CGRect {
    let containerSize = createCardContainerFrame(for: cardStack).size
    return CGRect(origin: .zero, size: containerSize)
  }
}
