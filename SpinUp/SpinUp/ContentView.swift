//
//  ContentView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/06/08.
//

import SwiftUI
import SpriteKit



//MARK: - ContentView
struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        ZStack {
            gameView
                .zIndex(1)
                .background(Color.backgroundBlack)

            switch vm.viewState {
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
                    Text("\(vm.gameManager.state.rawValue)")
                        .font(.title.bold())
                        .foregroundColor(.black)
                    playScoreView
                    playSpeedView
                    Spacer()
                }
                .padding(.horizontal, 24)
                .zIndex(2)
            case .result:
                VStack(alignment: .leading ,spacing: 0) {
                    Text("\(vm.gameManager.state.rawValue)")
                        .font(.title.bold())
                        .foregroundColor(.black)
                    playScoreView
                    playSpeedView
                    Spacer()
                }
                .padding(.horizontal, 24)
                .zIndex(2)

                GameOverView()
                    .zIndex(3)
            }
        }
        .fullScreenCover(isPresented: $vm.isShowingShopView) {
            ShopView()
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
                vm.isShowingShopView.toggle()
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
            vm.didTabSpinButton()
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
        self.vm.gameManager.velocity = velocity!
    }
}




struct FidgetSpinner {
    var id: String
    var name: String
}


let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
