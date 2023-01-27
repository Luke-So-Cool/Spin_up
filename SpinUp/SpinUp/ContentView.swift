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
    @StateObject var vm = ContentViewModel()

    @StateObject var gameManager = GameManager.shared
    @State var viewState: ViewMode = .main
    
    var body: some View {
        ZStack {
            gameView
                .zIndex(1)

            switch viewState {
            case .main:
                VStack(spacing: 0) {
                    navigationBarView
                    bestScore
                    Spacer()
                    spinButton
                        .padding(.horizontal, 30)
                        .padding(.vertical)
                }
                .zIndex(2)
                
            case .play:
                
                VStack(alignment: .leading ,spacing: 0) {
                    Text("\(gameManager.state.rawValue)")
                        .font(.title.bold())
                        .foregroundColor(.black)
                    playScoreView
                    playSpeedView
                    Spacer()
                }
                .padding(.horizontal, 24)
                .zIndex(2)
            case .result:
                VStack(spacing: 0) {
                    // TODO: 루크의 게임 오버뷰 연결하기.
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
//MARK: - main mode views
extension ContentView {

    var gameView: some View {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return SpriteView(scene: scene)
    }
    
    var navigationBarView: some View {
        HStack {
            Image("FidgemIcon")
            Text(String(vm.gemPoint))
                .font(.custom("WallPoet", size: 20, relativeTo: .title3))
                .foregroundColor(.spinnerAccent)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Shop")
                    .font(.custom("WallPoet", size: 20, relativeTo: .title3))
                    .foregroundColor(.spinnerAccent)
            }
            
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
                Text(String(vm.bestScore))
                    .font(.custom("WallPoet", size: 32, relativeTo: .largeTitle))
                    .foregroundColor(.spinnerLabel)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color("BackgroundColor2"))
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .padding(.horizontal, 48)
    }
    
    var spinButton: some View {
        Button {
            GameManager.shared.state = .running
            viewState = .play
        } label: {
            
            Text("SPIN")
                .foregroundColor(.spinnerAccent)
                .font(.custom("WallPoet", size: 20, relativeTo: .title3))
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    Capsule()
                        .stroke(Color.spinnerAccent, lineWidth: 1)
                        .shadow(color: Color.spinnerAccent, radius: 20)
                )
        }
    }
}

//MARK: - play mode views
extension ContentView {
    var playScoreView: some View {
        HStack {
            Text("SCORE")
                .fontWeight(.thin)
                .foregroundColor(.spinnerLabel3)
            Text("345023")
                .fontWeight(.bold)
                .foregroundColor(.spinnerLabel)
            Spacer()
        }
    }
    var playSpeedView: some View {
        HStack(alignment: .lastTextBaseline) {
            ZStack(alignment: .trailing) {
                Text("000")
                    .font(.custom("WallPoet", size: 96))
                    .foregroundColor(.spinnerSecondary)
                    .multilineTextAlignment(.trailing)

                Text("0")
                    .font(.custom("WallPoet", size: 96))
                    .foregroundColor(.spinnerAccent)
                    .multilineTextAlignment(.trailing)


            }
            Text("RPM")
                .font(.custom("WallPoet", size: 17, relativeTo: .body))
                .foregroundColor(.spinnerAccent)

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
