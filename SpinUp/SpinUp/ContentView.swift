//
//  ContentView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/06/08.
//

import SwiftUI
import SpriteKit


enum ViewMode {
    case main, play, result

}

//MARK: - ContentView
struct ContentView: View {

    @StateObject var gameManager = GameManager.shared
    @State var viewState: ViewMode = .main
    
    var body: some View {
        ZStack {
            gameView
                .zIndex(1)
            switch viewState {
            case .main:
                VStack(spacing: 0) {
                    Text("\(gameManager.state.rawValue)")
                        .font(.title.bold())
                        .foregroundColor(.black)
                    navigationBarView
                    bestScore
                    Spacer()
                    spinButton
                        .padding(.horizontal, 30)
                        .padding(.vertical)
                }
                .zIndex(2)
                
            case .play:
                
                VStack(spacing: 0) {
                    playScoreView
                    playSpeedView
                    Spacer()
                }
                .zIndex(2)

                
            case .result:
                VStack(spacing: 0) {
                    
                    Text("\(gameManager.state.rawValue)")
                        .font(.title.bold())
                        .foregroundColor(.black)
                    Spacer()
                }
                .zIndex(2)
            }
        }
    }
}

//MARK: - play mode views
extension ContentView {
    var playScoreView: some View {
        HStack {
            Text("SCORE")
            Text("345023")
        }
    }
    var playSpeedView: some View {
        HStack(alignment: .lastTextBaseline) {
            ZStack(alignment: .trailing) {
                Text("000")
                // 색을 연하게하고, 그걸 0을 추가하기
                Text("000")
            }
            Text("RPM")
        }
    }
}

extension ContentView {

    //MARK: - main mode views
    var gameView: some View {
        let scene = GameScene()
        scene.scaleMode = .resizeFill

        // scene.backgroundColor = .clear
        // return SpriteView(scene: scene)

        return SpriteView(scene: scene, options: [.allowsTransparency])
    }
    
    var navigationBarView: some View {
        HStack {
            Image("FidgemIcon")
            Text("+3,000")
                .font(.title3)
                .foregroundColor(.spinnerAccent)
            
            Spacer()
            
            Text("Shop")
                .font(.title3)
                .foregroundColor(.spinnerAccent)
            
        }
        .foregroundColor(.spinnerAccent)
        .padding(.horizontal, 24)
        .padding(.top, 30)
        .padding(.bottom, 60)
    }
    
    var bestScore: some View {
        HStack(spacing: 24) {
            Image("FidgemIcon")
            Color.spinnerLabel3
                .frame(width: 1, height: 32)
                .padding(.vertical, 22)
            
            
            VStack(alignment: .leading) {
                Text("Best Score")
                    .font(.footnote)
                    .foregroundColor(.spinnerLabel3)
                Text("30,000")
                    .font(.largeTitle)
                    .foregroundColor(.spinnerLabel)
            }
        }
        .padding(.horizontal, 24)
        .background(Color("BackgroundColor2"))
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }
    
    var spinButton: some View {
        Button {
            GameManager.shared.state = .running
            viewState = .play
        } label: {
            
            Text("SPIN")
                .foregroundColor(.spinnerAccent)
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    Capsule()
                        .stroke(Color.spinnerAccent, lineWidth: 1)
                        .shadow(color: Color.spinnerAccent, radius: 10)
                )
        }
    }
}

extension ContentView {
    func velocityChanged(velocity: Double?) {
        self.gameManager.velocity = velocity!
    }
}




struct FidgetSpinner {
    var id: String
    var name: String
}
