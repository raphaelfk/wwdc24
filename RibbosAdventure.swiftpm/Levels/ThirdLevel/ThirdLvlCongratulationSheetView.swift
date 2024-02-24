//
//  File 2.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 01/02/24.
//

import Foundation
import SwiftUI

struct ThirdLvlCongratulationSheetView: View {
    @Environment (\.colorScheme) var colorScheme
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
                        .foregroundStyle(Color("purple"))
                    
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
            Text("Your code was sent and helped Ribbo overcome this challenge and continue his mission on Party Planet.")
            
            Text("You have now mastered some of the core principles of programming. Great Job!")
            
            Text("Now you have access to all of the mission logs. If Ribbo goes on another adventure we'll surely let you know!")
            
            // image
            HStack {
                Spacer()
                
                Image(colorScheme == .light ? "partyPlanetSketchLight" : "partyPlanetSketchDark")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 64)
            }
            
            Spacer()
            
            // page watermarks
            ZStack {
                HStack {
                    Spacer()
                    
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
                                Color("purple")
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    })
                    .padding()
                    
                    Spacer()
                }
                
                HStack(alignment: .bottom) {
                    Image("rsc-watermark")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                    
                    Spacer()
                    
                    Image("starBorder")
                    
                }
                
            }
            
        }
        .padding(32)
    }
}
