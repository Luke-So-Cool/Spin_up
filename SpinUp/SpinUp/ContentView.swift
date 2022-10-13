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
    @StateObject var gameManager = GameManager.shared
    
    var body: some View {
        ZStack {
            gameView
                .zIndex(1)
            
            VStack {
                Text("\(gameManager.state.rawValue)")
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
//        scene.velocityDelegate = self
        return SpriteView(scene: scene, options: [.allowsTransparency])
    }
}

extension ContentView {
    func velocityChanged(velocity: Double?) {
        self.velocity = velocity!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
