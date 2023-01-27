//
//  ShopViewModel.swift
//  SpinUp
//
//  Created by GOngTAE on 2023/01/27.
//

import Combine
import Foundation

class ShopViewModel: ObservableObject {
    
    @Published var activePageIndex: Int = 0
    @Published var speed: CGFloat = 0 
    @Published var power: CGFloat = 0
    @Published var mass: CGFloat = 0
    @Published var currentSpinner = Spinner(id: 0)
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $activePageIndex
            .removeDuplicates()
            .map { index in
                let spinner = Spinner(id: index)
                
                return spinner.speed
            }
            .assign(to: \.speed, on: self)
            .store(in: &cancellables)
        
        $activePageIndex
            .removeDuplicates()
            .map { index in
                let spinner = Spinner(id: index)
                return spinner.power
            }
            .assign(to: \.power, on: self)
            .store(in: &cancellables)

        
        $activePageIndex
            .removeDuplicates()
            .map { index in
                let spinner = Spinner(id: index)
                return spinner.speed
            }
            .assign(to: \.mass, on: self)
            .store(in: &cancellables)
        
        $activePageIndex
            .removeDuplicates()
            .map { index in
                Spinner(id: index)
            }
            .assign(to: \.currentSpinner, on: self)
            .store(in: &cancellables)
    }
}
