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
    var state: GameState = .start {
        willSet {
            lastState = state
        }
        
        didSet {
            didStateChange(last: lastState, new: state)
        }
    }
    
    
    //MARK: - Initializers
    private override init() {}

    //MARK: - Methods
    
    func didStateChange(last: GameState, new: GameState) {
        defer {
            uiDelegate?.gameStateChanged(last: lastState, new: state)
        }
        print("DEBUG: 게임 상태 전환 \(last.rawValue) -> \(new.rawValue) ")
        switch last {
        case .stop:
            switch new {
                
            case .start:
                print("DEBUG: 게임 시작")
            default:
                fatalError("ERROR: 유효하지 않은 게임 상태 전환")
            }
        case .running:
            switch new {
                
            case .stop:
                print("DEBUG: 게임이 종료되었습니다.")
            case .pause:
                print("DEBUG: 게임이 일시중지되었습니다.")
            default:
                fatalError("ERROR: 유효하지 않은 게임 상태 전환")
            }
        case .start:
            switch new {
                
            case .stop:
                print("DEBUG: 게임을 종료합니다.")
            case .running:
                print("DEBUG: 스피너가 돌아가기 시작했습니다.")
            default:
                fatalError("ERROR: 유효하지 않은 게임 상태 전환")
            }
        case .pause:
            switch new {
                
            case .stop:
                print("DEBUG: 일시정지 -> 게임종료")
            case .running:
                print("DEBUG: 게임 resuem")
            case .start:
                print("DEBUG: 일시정지 -> 게임 리셋")
            default:
                fatalError("ERROR: 유효하지 않은 게임 상태 전환 \(last.rawValue) -> \(new.rawValue)")
            }
        }
    }
}

enum GameState: String {
    case stop
    case running
    case start
    case pause
}
