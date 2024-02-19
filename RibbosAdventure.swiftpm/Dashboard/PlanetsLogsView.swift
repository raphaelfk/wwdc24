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
    @State var showGrassPlanetLog = false
    
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
                        // grass planet log card
                        VStack(alignment: .center) {
                            Text("Grass Planet")
                                .font(.headline)
                                .foregroundStyle(Color("green"))
                                .padding(.top)
                            
                            Spacer()
                            
                            Image(colorScheme == .light ? "grassPlanetLight" : "grassPlanetDark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height / 3)
                            
                            Spacer()
                            
                            Button {
                                showGrassPlanetLog = true
                            } label: {
                                Text("Learn More...")
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 12)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("green").opacity(0.75))
                                    }
                            }
                            .buttonStyle(.plain)
                            .padding(.bottom, 8)

                        }
                        .frame(width: (geo.size.width - 32) / 3)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colorScheme == .light ? .white : Color(hex: "29292B"))
                        }
                        .onTapGesture {
                            showGrassPlanetLog = true
                        }
                        .padding(.top, 8)
                        .padding(.bottom)
                        .sheet(isPresented: $showGrassPlanetLog) {
                            GrassPlanetLogView(sheetVisibility: $showGrassPlanetLog)
                        }
                        
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
