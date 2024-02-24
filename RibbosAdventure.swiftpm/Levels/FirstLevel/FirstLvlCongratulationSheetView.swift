//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 26/01/24.
//

import SwiftUI

struct FirstLvlCongratulationSheetView: View {
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
                        .foregroundStyle(Color(hex: "A8D47B"))
                        
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
            Text("Your code was sent and helped Ribbo overcome this challenge and continue his successful mission on Grass Planet.")
            
            Text("It’s by building code blocks like this that scientists send actual robots to explore other planets in our universe!")
            
            Text("You can now take a look at the Grass Planet Mission log on your dashboard and try to complete other missions!")
            
            // image
            HStack {
                Spacer()
                
                Image(colorScheme == .light ? "grassPlanetSketchLight" : "grassPlanetSketchDark")
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
                            gameManager.playingFirstLevel = false
                        }
                        
                    }, label: {
                        Text("Go to Dashboard")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background {
                                Color(hex: "A8D47B")
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

//#Preview {
//    CongratulationSheetView()
//}
