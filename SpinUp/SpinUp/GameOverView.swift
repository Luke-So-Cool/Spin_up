//
//  GameOverView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/10/13.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        VStack(spacing: 32) {
            
            Spacer()
            
            
            VStack(spacing: 17) {
                Text("Score")
                
                Text("25,072")
                    .font(.system(size: 48, weight: .bold))
            }
            
            VStack(spacing: 17) {
                Text("Best")
                
                Text("22,725,321")
                    .font(.system(size: 48, weight: .bold))
            }
            
            
            HStack {
                VStack {
                    Text("TIME")
                    
                    Text("26 sec")
                        
                }
                
                Divider()
                    .background(.black)
                    .frame(width: 20)
                    .padding(10)
                    
                
                VStack {
                    Text("HIGH SPEED")
                    
                    Text("153mph")
                        
                }
            }
            .padding(.horizontal, 44)
            .frame(height: 75)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
            )
            
            Spacer()
            
            VStack {
                HStack {
                    Image(systemName: "")
                    
                    Text("광고 보고")
                    Text("이어하기")
                        .font(.body.bold())
                }
            }
            .padding(10)
            .overlay(
                Capsule()
                    .stroke(lineWidth: 1)
                    .shadow(radius: 4)
            )
            .onTapGesture {
                resumeWithAD()
            }
            
            HStack(spacing: 24) {
                Image(systemName: "house")
                    .font(.largeTitle)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                            .shadow(radius: 4)
                    )
                    .onTapGesture {
                        goToHome()
                    }
                
                Image(systemName: "play")
                    .font(.largeTitle)
                    .frame(width: 100, height: 100)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                            .shadow(radius: 4)
                    )
                    .onTapGesture {
                        resume()
                    }
                
                Image(systemName: "cart")
                    .font(.largeTitle)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                            .shadow(radius: 4)
                    )
                    .onTapGesture {
                        goToShop()
                    }
                    
            }
        }
        .padding(.horizontal, 20)
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
