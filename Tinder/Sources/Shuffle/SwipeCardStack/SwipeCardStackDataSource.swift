//
//  SwipeCardStackDataSource.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation

public protocol SwipeCardStackDataSource: AnyObject {
  func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard
  func numberOfCards(in cardStack: SwipeCardStack) -> Int
}
