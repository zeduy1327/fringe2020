//
//  CardStackStateManager.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//
import Foundation

struct Swipe: Equatable {
  var index: Int
  var direction: SwipeDirection
}

protocol CardStackStateManagable {
  var remainingIndices: [Int] { get }
  var swipes: [Swipe] { get }
  var totalIndexCount: Int { get }

  func insert(_ index: Int, at position: Int)
  func delete(_ index: Int)
  func delete(indexAtPosition position: Int)

  func swipe(_ direction: SwipeDirection)
  func undoSwipe() -> Swipe?
  func shift(withDistance distance: Int)
  func reset(withNumberOfCards numberOfCards: Int)
}

/// An internal class to manage the current state of the card stack.
class CardStackStateManager: CardStackStateManagable {

  /// The indices of the data source which have yet to be swiped.
  ///
  /// This array reflects the current order of the card stack, with the first element equal
  /// to the index of the top card in the data source. The order of this array accounts
  /// for both swiped and shifted cards in the stack.
  var remainingIndices: [Int] = []

  /// An array containing the swipe history of the card stack.
  var swipes: [Swipe] = []

  var totalIndexCount: Int {
    return remainingIndices.count + swipes.count
  }

  func insert(_ index: Int, at position: Int) {
    precondition(index >= 0, "Attempt to insert card at index \(index)")
    //swiftlint:disable:next line_length
    precondition(index <= totalIndexCount, "Attempt to insert card at index \(index), but there are only \(totalIndexCount + 1) cards after the update")
    precondition(position >= 0, "Attempt to insert card at position \(position)")
    //swiftlint:disable:next line_length
    precondition(position <= remainingIndices.count, "Attempt to insert card at position \(position), but there are only \(remainingIndices.count + 1) cards remaining in the stack after the update")

    // Increment all stored indices greater than or equal to index by 1
    remainingIndices = remainingIndices.map { $0 >= index ? $0 + 1 : $0 }
    swipes = swipes.map { $0.index >= index ? Swipe(index: $0.index + 1, direction: $0.direction) : $0 }

    remainingIndices.insert(index, at: position)
  }

  func delete(_ index: Int) {
    precondition(index >= 0, "Attempt to delete card at index \(index)")
    //swiftlint:disable:next line_length
    precondition(index < totalIndexCount, "Attempt to delete card at index \(index), but there are only \(totalIndexCount) cards before the update")

    swipes.removeAll { return $0.index == index }

    if let position = remainingIndices.firstIndex(of: index) {
      remainingIndices.remove(at: position)
    }

    // Decrement all stored indices greater than or equal to index by 1
    remainingIndices = remainingIndices.map { $0 >= index ? $0 - 1 : $0 }
    swipes = swipes.map { $0.index >= index ? Swipe(index: $0.index - 1, direction: $0.direction) : $0 }
  }

  func delete(indexAtPosition position: Int) {
    precondition(position >= 0, "Attempt to delete card at position \(position)")
    //swiftlint:disable:next line_length
    precondition(position < remainingIndices.count, "Attempt to delete card at position \(position), but there are only \(remainingIndices.count) cards remaining in the stack before the update")

    // Decrement all stored indices greater than or equal to index by 1
    let index = remainingIndices.remove(at: position)
    remainingIndices = remainingIndices.map { $0 >= index ? $0 - 1 : $0 }
  }

  func swipe(_ direction: SwipeDirection) {
    if remainingIndices.isEmpty { return }
    let firstIndex = remainingIndices.removeFirst()
    let swipe = Swipe(index: firstIndex, direction: direction)
    swipes.append(swipe)
  }

  func undoSwipe() -> Swipe? {
    if swipes.isEmpty { return nil }
    let lastSwipe = swipes.removeLast()
    remainingIndices.insert(lastSwipe.index, at: 0)
    return lastSwipe
  }

  func shift(withDistance distance: Int) {
    remainingIndices.shift(withDistance: distance)
  }

  func reset(withNumberOfCards numberOfCards: Int) {
    self.remainingIndices = Array(0..<numberOfCards)
    self.swipes = []
  }
}
