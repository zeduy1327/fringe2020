//
//  PanGestureRecognizer.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import UIKit

/// A testable `UIPanGestureRecognizer`
class PanGestureRecognizer: UIPanGestureRecognizer {

  private weak var testTarget: AnyObject?
  private var testAction: Selector?

  private var testLocation: CGPoint?
  private var testTranslation: CGPoint?
  private var testVelocity: CGPoint?
  private var testState: UIGestureRecognizer.State?

  override var state: UIGestureRecognizer.State {
    get {
      return testState ?? super.state
    }
    set {
      super.state = newValue
    }
  }

  override init(target: Any?, action: Selector?) {
    testTarget = target as AnyObject
    testAction = action
    super.init(target: target, action: action)
  }

  override func location(in view: UIView?) -> CGPoint {
    return testLocation ?? super.location(in: view)
  }

  override func translation(in view: UIView?) -> CGPoint {
    return testTranslation ?? super.translation(in: view)
  }

  override func velocity(in view: UIView?) -> CGPoint {
    return testVelocity ?? super.velocity(in: view)
  }

  func performPan(withLocation location: CGPoint?,
                  translation: CGPoint?,
                  velocity: CGPoint?,
                  state: UIPanGestureRecognizer.State? = nil) {
    testLocation = location
    testTranslation = translation
    testVelocity = velocity
    testState = state
    if let action = testAction {
      testTarget?.performSelector(onMainThread: action,
                                  with: self,
                                  waitUntilDone: true)
    }
  }
}
