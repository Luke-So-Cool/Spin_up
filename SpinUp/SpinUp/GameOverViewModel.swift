//
//  GameOverViewModel.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/11/03.
//

import Foundation

class GameOverViewModel: ObservableObject {
    @Published var score: Int = 25072
    @Published var bestScore: Int = 22725321
    @Published var time: Int = 26
    @Published var highSpeed: Int = 153
    
    var gameManager = GameManager.shared
    
}

