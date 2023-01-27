//
//  Spinner.swift
//  SpinUp
//
//  Created by GOngTAE on 2023/01/27.
//

import Foundation
import SwiftUI

struct Spinner: Identifiable {
    var id: Int
    
    var name: String {
        switch id {
        case 0:
            return "ORIGIN"
        case 1:
            return "CYAN"
        case 2:
            return "HULK"
        case 3:
            return "FLASH"
        default:
            return "default"
        }
    }
    var primaryColor: Color {
        switch id {
        case 0:
            return Color("SpinnerLabel")
        case 1:
            return Color("SpinnerCyan")
        case 2:
            return Color("SpinnerGreen")
        case 3:
            return Color("SpinnerOrange")
        default:
            return Color("SpinnerCyan")
        }
    }
    var secondaryColor: Color {
        switch id {
        case 0:
            return Color("SpinnerCyan2")
        case 1:
            return Color("SpinnerCyan2")
        case 2:
            return Color("SpinnerGreen2")
        case 3:
            return Color("SpinnerOrange2")
        default:
            return Color("SpinnerCyan2")
        }
    }
    
    var speed: CGFloat {
        switch id {
        case 0:
            return 0.2
        case 1:
            return 0.5
        case 2:
            return 0.6
        case 3:
            return 0.8
        default:
            return 5
        }
    }
    
    var power: CGFloat {
        switch id {
        case 0:
            return 0.2
        case 1:
            return 0.5
        case 2:
            return 0.8
        case 3:
            return 0.8
        default:
            return 0.2
        }
    }
    
    var mass: CGFloat {
        switch id {
        case 0:
            return 0.2
        case 1:
            return 0.5
        case 2:
            return 0.8
        case 3:
            return 0.6
        default:
            return 5
        }
    }
    
    var assetString: String {
        return "SPN\(id)"
    }
    
    var decelerationRatio: CGFloat {
        switch id {
        case 0:
            return 0.20
        case 1:
            return 0.16
        case 2:
            return 0.06
        case 3:
            return 0.10
        default:
            return 0.10
        }
    }

}
