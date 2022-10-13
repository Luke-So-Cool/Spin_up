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
        }
        .padding(.horizontal, 20)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
