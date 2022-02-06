//
//  Array+Extensions.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation

extension Array {

  mutating func shift(withDistance distance: Int = 1) {
    let offsetIndex = distance >= 0
      ? index(startIndex, offsetBy: distance, limitedBy: endIndex)
      : index(endIndex, offsetBy: distance, limitedBy: startIndex)
    guard let index = offsetIndex else { return }
    self = Array(self[index ..< endIndex] + self[startIndex ..< index])
  }
}
