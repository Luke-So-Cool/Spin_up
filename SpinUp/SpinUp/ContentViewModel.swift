//
//  ContentViewModel.swift
//  SpinUp
//
//  Created by 송시원 on 2023/01/27.
//

import SwiftUI

enum ViewMode {
    case main, play, result
}

class ContentViewModel: ObservableObject {

    @Published var viewState: ViewMode = .main
    @Published var isShowingShopView: Bool = false
    
    @Published var bestScore: Int = 30000
    @Published var gemPoint: Int = 3000

    @Published var gameManager = GameManager.shared
    //어떤 역할로 쓸까? -> 일단 가져가서 사용되어야할텐데...
    func didTabSpinButton() {
        viewState = .play
        GameManager.shared.state = .running

    }

}
extension ContentViewModel {

}


