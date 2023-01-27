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
                
                VStack(alignment: .leading ,spacing: 0) {
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

//MARK: - play mode views
extension ContentView {
    var playScoreView: some View {
        HStack {
            Text("SCORE")
                .fontWeight(.thin)
                .foregroundColor(.spinnerLabel3)
            Text("345023")
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
    }
    var playSpeedView: some View {
        HStack(alignment: .lastTextBaseline) {
            ZStack(alignment: .trailing) {
                Text("000")
                    .foregroundColor(.spinnerSecondary)
                    .font(.system(size: 96))
                // 색을 연하게하고, 그걸 0을 추가하기
                Text("000")
                    .foregroundColor(.spinnerAccent)
                    .font(.system(size: 96))

            }
            Text("RPM")
                .foregroundColor(.spinnerAccent)

        }
    }
}

extension ContentView {

    //MARK: - main mode views
    var gameView: some View {
        let scene = GameScene()
        scene.scaleMode = .resizeFill

        scene.backgroundColor = .clear
        return SpriteView(scene: scene)
    }
    
    var navigationBarView: some View {
        HStack {
            Image("FidgemIcon")
            Text("+3,000")
                .font(.custom("WallPoet", size: 20, relativeTo: .title3))
                .foregroundColor(.spinnerAccent)
            
            Spacer()
            
            Text("Shop")
                .font(.custom("WallPoet", size: 20, relativeTo: .title3))
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
                    .font(.custom("WallPoet", size: 32, relativeTo: .largeTitle))
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
                .font(.custom("WallPoet", size: 20, relativeTo: .title3))
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
