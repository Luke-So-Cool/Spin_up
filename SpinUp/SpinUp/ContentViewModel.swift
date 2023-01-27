//
//  ContentViewModel.swift
//  SpinUp
//
//  Created by 송시원 on 2023/01/27.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var bestScore: Int = 30000
    @Published var gemPoint: Int = 3000
}

