//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 18/01/24.
//

import SwiftUI

struct DashboardView: View {
    @State private var animateGradient = false
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var gameManager: GameManager
    @State var showStars1 = true
    @State var showStars2 = false
    @State var showStars3 = false
    
    var body: some View {
        VStack {
            // header
            HStack {
                Text("Dashboard")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            // page content
            HStack(alignment: .top, spacing: 16) {
                VStack(spacing: 16){
                    // first level card
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            gameManager.playingFirstLevel = true
                            gameManager.playingSecondLevel = false
                            gameManager.playingThirdLevel = false
                        }
                        
                    } label: {
                        ZStack {
                            // background image
                            HStack {
                                Spacer()
                                
                                ZStack(alignment: .center) {
                                    Image("firstCardOrbits")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    if !gameManager.firstLevelComplete {
                                        if showStars3 {
                                            Image("cardStars1")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        
                                        if showStars2 {
                                            Image("cardStars2")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        
                                        if showStars1 {
                                            Image("cardStars3")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                }
                                
                            }
                            
                            // card content
                            VStack(alignment: .leading) {
                                Text("First Mission")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .fontDesign(.monospaced)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "command")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    
                                    Text("Commands")
                                }
                                
                                Text("Grass Planet")
                                
                                Spacer()
                                
                                HStack(spacing: 8) {
                                    Spacer()
                                    
                                    if gameManager.firstLevelComplete {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 12)
                                            .background {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.25))
                                            }
                                    }
                                    
                                    // first level play button
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            gameManager.playingFirstLevel = true
                                            gameManager.playingSecondLevel = false
                                            gameManager.playingThirdLevel = false
                                        }
                                        
                                    } label: {
                                        HStack {
                                            Image(systemName: "play.fill")
                                            Text(gameManager.firstLevelComplete ? "Replay" : "Play")
                                        }
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 12)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(.gray.opacity(0.25))
                                        }
                                    }
                                }
                            }
                            .foregroundStyle(.white)
                            .padding(.vertical, 20)
                            .padding(.leading, 20)
                            .padding(.trailing, 16)
                        }
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.65, green: 0.76, blue: 0.29), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.67, green: 0.93, blue: 0.79), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 0),
                                endPoint: UnitPoint(x: 1, y: 1)
                            )
                            .hueRotation(.degrees(animateGradient ? 45 : 0))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                                animateGradient.toggle()
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    
                    
                    // second level card
                    Button {
                        withAnimation(.easeInOut(duration: 2)) {
                            gameManager.playingFirstLevel = false
                            gameManager.playingSecondLevel = true
                            gameManager.playingThirdLevel = false
                        }
                    } label: {
                        ZStack {
                            // background image
                            HStack {
                                Spacer()
                                if gameManager.secondLevelAvailable {
                                    ZStack {
                                        Image("secondCardOrbits")
                                            .resizable()
                                            .scaledToFit()
                                        
                                        if !gameManager.secondLevelComplete {
                                            if showStars1 {
                                                Image("cardStars1")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                            
                                            if showStars2 {
                                                Image("cardStars2")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                            
                                            if showStars3 {
                                                Image("cardStars3")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                        }
                                        
                                        
                                    }
                                }
                            }
                            
                            // card content
                            VStack(alignment: .leading) {
                                Text("Second Mission")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .fontDesign(.monospaced)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    
                                    Text("For Loops")
                                }
                                
                                Text("Castle Planet")
                                
                                Spacer()
                                
                                HStack(spacing: 8) {
                                    Spacer()
                                    
                                    if gameManager.secondLevelComplete {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 12)
                                            .background {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.25))
                                            }
                                    }
                                    
                                    if gameManager.secondLevelAvailable {
                                        // second level play button
                                        Button {
                                            withAnimation(.easeInOut(duration: 2)) {
                                                gameManager.playingFirstLevel = false
                                                gameManager.playingSecondLevel = true
                                                gameManager.playingThirdLevel = false
                                            }
                                        } label: {
                                            HStack {
                                                Image(systemName: "play.fill")
                                                Text(gameManager.secondLevelComplete ? "Replay" : "Play")
                                            }
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 12)
                                            .background {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.25))
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            .foregroundStyle(.white)
                            .padding(.vertical, 20)
                            .padding(.leading, 20)
                            .padding(.trailing, 16)
                            
                            // locked cover
                            if !gameManager.secondLevelAvailable {
                                Color(.gray.opacity(0.65))
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                        }, label: {
                                            HStack {
                                                Image(systemName: "lock.fill")
                                                Text("Locked")
                                            }
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 12)
                                            .background {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.25))
                                            }
                                            
                                        })
                                    }
                                }
                                .padding()
                            }
                            
                            
                        }
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.27, green: 0.67, blue: 0.79),
                                    Color(red: 0.54, green: 0.65, blue: 0.96),
                                ],
                                startPoint: UnitPoint(x: 0, y: 0),
                                endPoint: UnitPoint(x: 1, y: 1)
                            )
                            .hueRotation(.degrees(animateGradient ? 45 : 0))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
                    }
                    .buttonStyle(.plain)

                    
                    // third level card
                    Button {
                        withAnimation(.easeInOut(duration: 2)) {
                            gameManager.playingFirstLevel = false
                            gameManager.playingSecondLevel = false
                            gameManager.playingThirdLevel = true
                        }
                    } label: {
                        ZStack {
                            // background image
                            HStack {
                                Spacer()
                                
                                if gameManager.thirdLevelAvailable {
                                    ZStack {
                                        Image("thirdCardOrbits")
                                            .resizable()
                                            .scaledToFit()
                                        
                                        if showStars3 {
                                            Image("cardStars1")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        
                                        if showStars1 {
                                            Image("cardStars2")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        
                                        if showStars2 {
                                            Image("cardStars3")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                }
                            }
                            
                            // card content
                            VStack(alignment: .leading) {
                                Text("Third Mission")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .fontDesign(.monospaced)
                                
                                HStack {
                                    Image(systemName: "arrow.triangle.branch")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    
                                    Text("If Statements")
                                }
                                
                                Text("Party Planet")
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    if gameManager.thirdLevelComplete {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 12)
                                            .background {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.25))
                                            }
                                    }
                                    
                                    if gameManager.thirdLevelAvailable {
                                        Button(action: {
                                            withAnimation(.easeInOut(duration: 2)) {
                                                gameManager.playingFirstLevel = false
                                                gameManager.playingSecondLevel = false
                                                gameManager.playingThirdLevel = true
                                            }
                                        }, label: {
                                            HStack {
                                                Image(systemName: "play.fill")
                                                Text(gameManager.thirdLevelComplete ? "Replay" : "Play")
                                            }
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 12)
                                            .background {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.25))
                                            }
                                            
                                        })
                                    }
                                }
                            }
                            .foregroundStyle(.white)
                            .padding(.vertical, 20)
                            .padding(.leading, 20)
                            .padding(.trailing, 16)
                            
                            if !gameManager.thirdLevelAvailable {
                                Color(.gray.opacity(0.65))
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                        }, label: {
                                            HStack {
                                                Image(systemName: "lock.fill")
                                                Text("Locked")
                                            }
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 12)
                                            .background {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.25))
                                            }
                                            
                                        })
                                    }
                                }
                                .padding()
                            }
                        }
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.74, green: 0.3, blue: 0.81), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.96, green: 0.72, blue: 0.54), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 0),
                                endPoint: UnitPoint(x: 1, y: 1)
                            )
                            .hueRotation(.degrees(animateGradient ? 45 : 0))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
                    }
                    .buttonStyle(.plain)  
                }
                .onAppear {
                    // setup for the cards' stars animations
                    withAnimation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true)) {
                        showStars1.toggle()
                    }
                    
                    withAnimation(.easeInOut(duration: 1.25).repeatForever(autoreverses: true)) {
                        showStars2.toggle()
                    }
                    
                    withAnimation(.easeInOut(duration: 1.75).repeatForever(autoreverses: true)) {
                        showStars3.toggle()
                    }
                }
                
                VStack {
                    // mission control terminal
                    MissionControlTerminalView()
                    
                    // planet logs
                    PlanetsLogsView()
                }
                
            }
        }
        .padding()
        .navigationTitle("Mission Dashboard")
    }
}

#Preview {
    DashboardView()
        .environmentObject(GameManager())
}
