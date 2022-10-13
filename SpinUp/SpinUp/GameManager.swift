//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import Foundation

protocol UIDelegate {
    func gameStateChanged(last: GameState, new: GameState)
}

class GameManager: NSObject {
    
    //MARK: - Propeties
    static let shared = GameManager() // 싱글톤 객체
    weak var gameScene: GameScene?
    var uiDelegate: UIDelegate?
    var lastState: GameState = .stop

    @Published var state: GameState = .stop {
        willSet {
            lastState = state
        }
        
        didSet {
            defer {
                uiDelegate?.gameStateChanged(last: lastState, new: state)
            }
            
            switch state {
            case .stop:
                print("DEBUG: 게임 정지")
                
            case .pause:
                print("DEBUG: 게임 일시 정지")
                if lastState == .running {
                    gameScene?.isPaused = true
                }
            case .running:
                print("DEBUG: 게임 실행")
                switch lastState {
                case .stop:
                    print("DEBUG: 정지상태 -> 게임 실행")
                case .pause:
                    print("DEBUG: 일시정지 후 게임 실행")
                case .running:
                    print("DEBUG: 이미 실행중입니다.")
                }
            }
        }
    }
    

    @Published var velocity: Double = 0
    
    //MARK: - Initializers
    private override init() {}

    //MARK: - Methods
}

enum GameState {
    case stop
    case running
    case pause
}
