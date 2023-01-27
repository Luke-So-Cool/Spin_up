//
//  GameOverView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/10/13.
//

import SwiftUI

struct GameOverView: View {
    @StateObject private var vm = GameOverViewModel()
    @ObservedObject var contentViewModel: ContentViewModel
    
    
    var body: some View {
        ZStack {
            Color.backgroundBlack.opacity(0.95)
            
            VStack(spacing: 32) {
                
                Spacer()
                
                VStack(spacing: 8) {
                    Text("Score")
                        .font(.custom("WallPoet", size: 16))
                    
                    Text("\(GameManager.shared.currentScore)")
                        .font(.custom("WallPoet", size: 48))
                }
                
                VStack(spacing: 8) {
                    Text("Best")
                        .font(.custom("WallPoet", size: 16))
                        .foregroundColor(.white)
                    
                    Text("\(vm.bestScore)")
                        .font(.custom("WallPoet", size: 48))
                        .foregroundColor(.spinnerLabel3)
                }
                
                HStack {
                    VStack(spacing: 2) {
                        Text("TIME")
                            .font(.caption)
                            .foregroundColor(.spinnerLabel3)
                        
                        Text("\(vm.time) sec")
                            .font(.body.bold())
                            
                    }
                    
                    Divider()
                        .background(.white)
                        .frame(width: 20)
                        .padding(10)
                    
                    VStack(spacing: 2) {
                        Text("HIGH SPEED")
                            .font(.caption)
                            .foregroundColor(.spinnerLabel3)
                        
                        Text("\(vm.highSpeed)mph")
                            .font(.body.bold())
                    }
                }
                .padding(.horizontal, 44)
                .frame(height: 75)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.spinnerLabel2)
                )
                
                Spacer()
                
                ZStack {
                    
                    Capsule()
                        .stroke(lineWidth: 2)
                        .frame(height: 44)
                        .shadow(color: Color("SpinnerAd"), radius: 6)
                        .padding(.horizontal, 60)
                        
                    
                    VStack {
                        HStack {
                            
                            Image(systemName: "film")
                                .font(.subheadline.bold())
                            
                            Text("광고 보고")
                                .font(.subheadline.bold())
                            Text("이어하기")
                                .font(.subheadline.bold())
                            
                        }
                        .padding(.horizontal, 10)
                    }
                    .padding(10)
                }
                .foregroundColor(Color("SpinnerAd"))
                .onTapGesture {
                    resumeWithAD()
                }
                
                HStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 2)
                            .shadow(color: .spinnerLabel ,radius: 6)
                            
                            
                        Image(systemName: "house")
                            .font(.largeTitle)
                            
                            .onTapGesture {
                                goToHome()
                        }
                    }
                    .frame(width: 72, height: 72)
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 2)
                            .shadow(color: .spinnerLabel ,radius: 6)
                        
                        Image(systemName: "play")
                            .font(.largeTitle)
                    }
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        resume()
                    }
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 2)
                            .shadow(color: .spinnerLabel ,radius: 6)
                        
                        Image(systemName: "cart")
                            .font(.largeTitle)
                            .onTapGesture {
                                goToShop()
                        }
                    }
                    .frame(width: 72, height: 72)
                        
                }
                .padding(.bottom, 40)
            }
            .padding(20)
            
            .foregroundColor(.spinnerLabel)
            
        }
        .ignoresSafeArea()
        
    }
    
    //MARK: - Helpers
    
    func resumeWithAD() {
        
    }
    
    func goToHome() {
        contentViewModel.backHome()
    }
    
    func resume() {
        contentViewModel.viewState = .play
        GameManager.shared.startGame()
    }
    
    func goToShop() {
        
    }
}
