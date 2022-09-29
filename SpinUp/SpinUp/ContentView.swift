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
        
    }
    
    func nextLevel(level: Int) {
        // 다음 레벨 핸들ㄹ
    }
    
    func gameOver() {
        // 게임 오버 핸들러
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
