//
//  SwipeCardDelegate.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation

protocol SwipeCardDelegate: AnyObject {
  func card(didBeginSwipe card: SwipeCard)
  func card(didCancelSwipe card: SwipeCard)
  func card(didContinueSwipe card: SwipeCard)
  func card(didSwipe card: SwipeCard, with direction: SwipeDirection)
  func card(didTap card: SwipeCard)
}
