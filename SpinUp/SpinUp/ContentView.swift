//
//  ContentView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/06/08.
//

import SwiftUI
import SpriteKit


enum ViewMode {                 // 기본 입력, 곱셈, 나누기 입력
    case main, play, result

}

enum viewState {
    case home, game, result
}

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

// play mode views
extension ContentView {
    @ViewBuilder
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
// main mode views

extension ContentView {
    @ViewBuilder
    var gameView: some View {
        let scene = GameScene()
        scene.scaleMode = .resizeFill

        scene.backgroundColor = .clear
        return SpriteView(scene: scene)
    }
    
    @ViewBuilder
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
    
    @ViewBuilder
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
    
    @ViewBuilder
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

// 게임중

//extension ContentView: UIDelegate {
//    func nextLevel(level: Int) {
//        // 다음 레벨 핸들ㄹ
//    }
//
//    func gameOver() {
//        // 게임 오버 핸들러
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    static var spinnerAccent: Color {
        Color("SpinnerGreen")
    }
    static var spinnerSecondary: Color {
        Color("SpinnerGreen")
    }
    static var background: Color {
        Color("BackgroundColor")
    }
    static var background2: Color {
        Color("BackgroundColor2")
    }
    static var spinnerLabel: Color {
        Color("SpinnerLabel")
    }
    static var spinnerLabel2: Color {
        Color("SpinnerLabel2")
    }
    static var spinnerLabel3: Color {
        Color("SpinnerLabel3")
    }
}


struct FidgetSpinner {
    var id: String
    var name: String
}

struct ContentView: View {
    @State var velocity: Double = 0
    @StateObject var gameManager = GameManager.shared
    
    var body: some View {
        ZStack {
            gameView
                .zIndex(1)
            
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
        }
    }
}

extension ContentView {
    @ViewBuilder
    var gameView: some View {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
//        scene.velocityDelegate = self
        return SpriteView(scene: scene)
    }
    
    @ViewBuilder
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
    
    @ViewBuilder
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
    
    @ViewBuilder
    var spinButton: some View {
        Button {
            //            GameManager.shared.state = .running
            
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
        self.velocity = velocity!
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
