//
//  Color.swift
//  UberSwiftUI
//
//  Created by wizz on 5/7/23.
//

import SwiftUI


extension Color {
    static let theme = ColorTheme()
}
struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let seconaryBackgroundColor = Color("SecondaryBackgroundColor")
    let textColor = Color("PrimaryTextColor")
}
