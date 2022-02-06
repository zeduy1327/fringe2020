//
//  CGPoint+Extensions.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import CoreGraphics

extension CGPoint {

  init(_ vector: CGVector) {
    self = CGPoint(x: vector.dx, y: vector.dy)
  }
}
