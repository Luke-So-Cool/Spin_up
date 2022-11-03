//
//  GameOverView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/10/13.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        ZStack {
            Color.background.opacity(0.95)
            
            VStack(spacing: 32) {
                
                Spacer()
                
                VStack(spacing: 6) {
                    Text("Score")
                        .font(.body.bold())
                    
                    Text("25,072")
                        .font(.system(size: 48, weight: .bold))
                }
                
                VStack(spacing: 6) {
                    Text("Best")
                        .font(.body.bold())
                        .foregroundColor(.white)
                    
                    Text("22,725,321")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                }
                
                HStack {
                    VStack(spacing: 2) {
                        Text("TIME")
                            .font(.caption)
                            .foregroundColor(.spinnerLabel3)
                        
                        Text("26 sec")
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
                        
                        Text("153mph")
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
                        .stroke(lineWidth: 1)
                        .frame(height: 44)
                        .shadow(color: Color("SpinnerAd"), radius: 4)
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
                            .shadow(color: .spinnerLabel ,radius: 4)
                            
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
                            .shadow(color: .spinnerLabel ,radius: 4)
                        
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
                            .shadow(color: .spinnerLabel ,radius: 4)
                        
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
        
    }
    
    func resume() {
        
    }
    
    func goToShop() {
        
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
