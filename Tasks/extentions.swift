//
//  extentions.swift
//  LISUWithSwiftUI
//
//  Created by Shahrukh on 13/12/2021.
//  Copyright © 2021 Programmer Force. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
