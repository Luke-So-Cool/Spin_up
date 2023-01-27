//
//  ShopViewModel.swift
//  SpinUp
//
//  Created by GOngTAE on 2023/01/27.
//

import Combine
import SwiftUI

class ShopViewModel: ObservableObject {
    @State var gameManager = GameManager.shared
    
    @Published var activePageIndex: Int = 0
    @Published var speed: CGFloat = 0 
    @Published var power: CGFloat = 0
    @Published var mass: CGFloat = 0
    @Published var currentSpinner = Spinner(id: 0)
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        //MARK: - 현재 HGRID 인덱스에 따라 스피너 종류 변경
        $activePageIndex
            .removeDuplicates()
            .map { index in
                Spinner(id: index)
            }
            .assign(to: \.currentSpinner, on: self)
            .store(in: &cancellables)
        
        //MARK: - 스피너 종류가 변경되면, 게임매니저, 스피드, 파워, 매스 값 변경
        $currentSpinner
            .sink { receivedValue in
                self.gameManager.currentSpinner = receivedValue
            }
            .store(in: &cancellables)
        
        $currentSpinner
            .map { spinner in
                spinner.speed
            }
            .assign(to: \.speed, on: self)
            .store(in: &cancellables)
        
        $currentSpinner
            .map { spinner in
                spinner.power
            }
            .assign(to: \.power, on: self)
            .store(in: &cancellables)
        
        $currentSpinner
            .map { spinner in
                spinner.mass
            }
            .assign(to: \.mass, on: self)
            .store(in: &cancellables)
    }
}
