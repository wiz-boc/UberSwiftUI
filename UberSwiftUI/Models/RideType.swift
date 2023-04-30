//
//  RideType.swift
//  UberSwiftUI
//
//  Created by wizz on 4/30/23.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
            case .uberX:
                return "UberX"
            case .black:
                return "UberBlack"
            case .uberXL:
                return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
            case .uberX:
                return "sedan"
            case .black:
                return "suv"
            case .uberXL:
                return "van"
        }
    }
}
