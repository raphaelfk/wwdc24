//
//  File 2.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 01/02/24.
//

import Foundation
import SwiftUI

struct ThirdLvlCongratulationSheetView: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var sheetVisibility: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // header
            HStack(alignment: .top) {
                HStack(alignment: .top, spacing: 6) {
                    Text("Congratulations!")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                    
                    Image("sparkling-stars")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                        .foregroundStyle(Color(hex: "A861D4"))
                    
                }
                
                Spacer()
                
                Button(action: {
                    sheetVisibility = false
                    
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.gray.opacity(0.15))
                })
                .buttonStyle(.plain)
                
            }
            .padding(.bottom)
            
            // description
            Text("Your code was sent and helped Ribbo overcome this challenge and continue his successful mission on Party Planet.")
            
            Text("You have now mastered some of the core principles of programming, great job!")
            
            Text("Now you have access to all of the mission logs from Ribbo. If he goes on another adventure we'll surely let you know!")
            
            // Code blocks example
            HStack {
                // ribbo commands
                VStack(alignment: .leading) {
                    Text("Party Planet")
                        .foregroundStyle(Color(hex: "A861D4"))
                        .fontWeight(.semibold)
                    
                    // command blocks
                    HStack(alignment: .top) {
                        Text("Throughout its exploration of Grass Planet, Ribbo collected samples of the planet's most abundant natural formation: Grass. This planet’s highlights were, mainly, it's nature formations, such as rocks, rivers and mountains.\nEverything was well preserved and there was harmony between nature and its habitants.")
                            .lineLimit(3...3)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Image("grassSample")
                    }
                }
            }
            .padding()
            .background(.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1)) {
                    sheetVisibility = false
                    gameManager.playingThirdLevel = false
                }
                
            }, label: {
                Text("Go to Dashboard")
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        Color(hex: "A861D4")
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            })
            
            
            Spacer()
            
            // page watermarks
            HStack(alignment: .bottom) {
                Image("rsc-watermark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                
                Spacer()
                
                Image("starBorder")
                
            }
        }
        .padding(32)
    }
}
