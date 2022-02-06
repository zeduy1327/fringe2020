//
//  StringUtils.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//


import Foundation

//swiftlint:disable line_length
enum StringUtils {

  static func createInvalidUpdateErrorString(newCount: Int,
                                             oldCount: Int,
                                             insertedCount: Int = 0,
                                             deletedCount: Int = 0) -> String {
    return "Invalid update: invalid number of cards. The number of cards contained in the card stack after the update (\(newCount)) must be equal to the number of cards contained in the card stack before the update (\(oldCount)), plus or minus the number of cards inserted or deleted (\(insertedCount) inserted, \(deletedCount) deleted)"
  }
}
//swiftlint:enable line_length
