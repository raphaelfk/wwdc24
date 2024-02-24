//
//  File.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 01/02/24.
//

import Foundation
import SwiftUI

struct SecondLvlCongratulationSheetView: View {
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
                        .foregroundStyle(Color("blue"))
                    
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
            Text("Ribbo's mission on Castle Planet was a success, thanks to you!")
            
            Text("You've learned even more concepts about algorithm building and how to harness the power of For Loops!")
            
            Text("The Castle Planet Mission log was added your dashboard.")
            
            // image
            HStack {
                Spacer()
                
                Image(colorScheme == .light ? "castlePlanetSketchLight" : "castlePlanetSketchDark")
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
            
            // page watermarks
            ZStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) {
                            sheetVisibility = false
                            gameManager.playingSecondLevel = false
                        }
                        
                    }, label: {
                        Text("Go to Dashboard")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background {
                                Color("blue")
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
