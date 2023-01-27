//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import Foundation

class GameManager: ObservableObject {
    
    //MARK: - Propeties
    static let shared = GameManager() // 싱글톤 객체
    weak var gameScene: GameScene?
    private(set) var lastState: GameState = .stop

    @Published private(set) var state: GameState = .stop {
        willSet {
            lastState = state
        }
        
        didSet {
            didStateChange(last: lastState, new: state)
        }
    }
    
    @Published var currentSpinner: Spinner = Spinner(id: 0)
    @Published var velocity: Double = 0
    

    //MARK: - Initializers
    private init() {}

    //MARK: - Methods
    
    func didStateChange(last: GameState, new: GameState) {
        print("DEBUG: 게임 상태 변경 \(last) -> \(new)")
        //여기서 실행되어야하는게, 뷰상태 변경해야하네!
    }
    
    func startGame() { state = .running }
    func stopGame() { state = .stop }
}

enum GameState: String {
    case stop
    case running
}
