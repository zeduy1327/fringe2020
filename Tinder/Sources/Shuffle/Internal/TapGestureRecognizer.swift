//
//  TapGestureRecognizer.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//
import UIKit

/// A testable `UITapGestureRecognizer`
class TapGestureRecognizer: UITapGestureRecognizer {

  private weak var testTarget: AnyObject?
  private var testAction: Selector?

  private var testLocation: CGPoint?

  override init(target: Any?, action: Selector?) {
    testTarget = target as AnyObject
    testAction = action
    super.init(target: target, action: action)
  }

  override func location(in view: UIView?) -> CGPoint {
    return testLocation ?? super.location(in: view)
  }

  func performTap(withLocation location: CGPoint?) {
    testLocation = location
    if let action = testAction {
      testTarget?.performSelector(onMainThread: action,
                                  with: self,
                                  waitUntilDone: true)
    }
  }
}
