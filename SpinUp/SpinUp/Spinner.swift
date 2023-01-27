//
//  Spinner.swift
//  SpinUp
//
//  Created by GOngTAE on 2023/01/27.
//

import Foundation

struct Spinner: Identifiable {
    var id: Int
    
    var name: String {
        switch id {
        case 0:
            return "default"
        case 1:
            return "blue"
        case 2:
            return "green"
        case 3:
            return "orange"
        default:
            return "default"
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
            return 5
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
}
