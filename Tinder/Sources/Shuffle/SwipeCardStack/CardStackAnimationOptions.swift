//
//  CardStackAnimationOptions.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation

public protocol CardStackAnimatableOptions {
  var resetDuration: TimeInterval? { get }
  var shiftDuration: TimeInterval { get }
  var swipeDuration: TimeInterval? { get }
  var undoDuration: TimeInterval? { get }
}

/// The animation options provided to the internal card stack animator.
public final class CardStackAnimationOptions: CardStackAnimatableOptions {

  /// The static default instance of `CardStackAnimationOptions`.
  static let `default` = CardStackAnimationOptions()

  /// The duration of the animation applied to the background cards after a canceled
  /// swipe has been recognized on the top card.
  ///
  /// If this value is `nil`, the animation will last exactly half the duration of
  /// `animationOptions.resetDuration` on the top card. This value must be greater than zero.
  /// Defaults to `nil`.
  public let resetDuration: TimeInterval?

  /// The duration of the card stack shift animation.
  ///
  /// This value must be greater than zero. Defaults to `0.1`.
  public let shiftDuration: TimeInterval

  /// The duration of the animation applied to the background cards after a swipe
  /// has been recognized on the top card.
  ///
  /// If this value is `nil`, the animation will last exactly half the duration of
  /// `animationOptions.totalSwipeDuration` on the top card. This value must be greater than zero.
  /// Defaults to `nil`.
  public let swipeDuration: TimeInterval?

  /// The duration of the animation applied to the background cards after an `undo`
  /// has been triggered.
  ///
  /// If this value is `nil`, the animation will last exactly half the duration of
  /// `animationOptions.totalReverseSwipeDuration` on the top card. This value must be greater than zero.
  /// Defaults to `nil`.
  public let undoDuration: TimeInterval?

  public init(resetDuration: TimeInterval? = nil,
              shiftDuration: TimeInterval = 0.1,
              swipeDuration: TimeInterval? = nil,
              undoDuration: TimeInterval? = nil) {
    if let resetDuration = resetDuration {
      self.resetDuration = max(0, resetDuration)
    } else {
      self.resetDuration = nil
    }

    self.shiftDuration = max(0, shiftDuration)
    if let swipeDuration = swipeDuration {
      self.swipeDuration = max(0, swipeDuration)
    } else {
      self.swipeDuration = nil
    }

    if let undoDuration = undoDuration {
      self.undoDuration = max(0, undoDuration)
    } else {
      self.undoDuration = nil
    }
  }
}
