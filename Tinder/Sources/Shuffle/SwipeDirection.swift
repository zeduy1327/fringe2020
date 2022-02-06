//
//  SwipeDirection.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import UIKit

/// A type representing the direction of a physical drag.
@objc
public enum SwipeDirection: Int, CustomStringConvertible {
  // swiftlint:disable:next identifier_name
  case left, right, up, down

  /// A static array containing all `SwipeDirection`s.
  public static let allDirections: [SwipeDirection] = [left, up, right, down]

  /// The `SwipeDirection` represented as a unit vector.
  public var vector: CGVector {
    switch self {
    case .left:
      return CGVector(dx: -1, dy: 0)
    case .right:
      return CGVector(dx: 1, dy: 0)
    case .up:
      return CGVector(dx: 0, dy: -1)
    case .down:
      return CGVector(dx: 0, dy: 1)
    }
  }

  /// A textual representation of the `SwipeDirection`.
  public var description: String {
    switch self {
    case .left:
      return "left"
    case .right:
      return "right"
    case .up:
      return "up"
    case .down:
      return "down"
    }
  }
}
