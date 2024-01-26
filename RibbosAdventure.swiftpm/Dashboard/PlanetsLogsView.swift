//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 25/01/24.
//

import SwiftUI

struct PlanetsLogsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "doc.on.clipboard.fill")
                Text("Planet Logs")
            }
            .fontWeight(.bold)
            .fontDesign(.monospaced)
            .foregroundStyle( Color(hex: colorScheme == .light ? "505050" : "C9C9C9"))
            
            
            ZStack {
                VStack {
                    Spacer()
                    
                    // star border detail
                    HStack {
                        Spacer()
                        
                        Image("starBorder")
                    }
                }
                
                // log cards
                GeometryReader { geo in
                    if gameManager.firstLevelComplete {
                        VStack(alignment: .center) {
                            Text("Grass Planet")
                                .font(.headline)
                                .foregroundStyle(Color(red: 0.65, green: 0.76, blue: 0.29))
                                .padding(.top)
                            
                            Image("grassSample")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height / 2)
                            
                            Spacer()
                        }
                        .frame(width: (geo.size.width - 32) / 3)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.white)
                        }
                        .padding(.top, 8)
                        .padding(.bottom)
                        
                    } else {
                        Text("You still have no logs. Try completing a mission to get your first one.")
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.gray)
                    }
                }
            }
            
        }
        .padding()
        .background(.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    PlanetsLogsView()
}
