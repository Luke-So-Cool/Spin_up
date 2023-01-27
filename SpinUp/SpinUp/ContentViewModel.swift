//
//  ContentViewModel.swift
//  SpinUp
//
//  Created by 송시원 on 2023/01/27.
//

import Combine
import SwiftUI

enum ViewMode {
    case main, play, result
}

class ContentViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()

    @Published var viewState: ViewMode = .main
    @Published var isShowingShopView: Bool = false
    
    @Published var bestScore: Int = 30000
    @Published var gemPoint: Int = 3000

    @State var gameManager = GameManager.shared
    //어떤 역할로 쓸까? -> 일단 가져가서 사용되어야할텐데...
    func didTabSpinButton() {
        viewState = .play
        gameManager.startGame()

    }
    
    init() {
        gameManager.$state
            .removeDuplicates()
            .sink { newState in
                if newState == .stop && self.gameManager.lastState == .running {
                    self.viewState = .result
                }
            }
            .store(in: &cancellables)
    }
    func backHome() {
        viewState = .main
    }
    
    func didTabShopbutton() {
        isShowingShopView.toggle()
    }

}
extension ContentViewModel {

}


