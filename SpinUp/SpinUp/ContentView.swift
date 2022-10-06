//
//  ContentView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/06/08.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var velocity: Double = 0
    
    init() {
        GameManager.shared.uiDelegate = self
    }

    var body: some View {
        ZStack {
            gameView
                .zIndex(1)
            VStack {
                Text("\(velocity)")
                    .font(.title.bold())
                    .foregroundColor(.black)
                Spacer()
            }
            .zIndex(2)
        }
    }
}

extension ContentView {
    var gameView: some View {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        scene.velocityDelegate = self
        return SpriteView(scene: scene)
    }
}

extension ContentView {
    func velocityChanged(velocity: Double?) {
        self.velocity = velocity!
    }
}

extension ContentView: UIDelegate {
    func gameStateChanged(last: GameState, new: GameState) {
        // 게임 상태 변환 시 호출되는 메서드
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
