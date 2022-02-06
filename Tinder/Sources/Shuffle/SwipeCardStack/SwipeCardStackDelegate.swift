//
//  SwipeCardStackDelegate.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation

@objc public protocol SwipeCardStackDelegate: AnyObject {

  @objc
  optional func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int)

  @objc
  optional func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection)

  @objc
  optional func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection)

  @objc
  optional func didSwipeAllCards(_ cardStack: SwipeCardStack)
}
