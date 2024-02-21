//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 25/01/24.
//

import SwiftUI

struct MissionControlTerminalView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var currentMissionControlMessage = ""
    @EnvironmentObject var gameManager: GameManager
    @State var liveBlinking = true
    @State var showLiveBadge = false
    @State var missionControlMessage = ""
    @State var showStars1 = true
    @State var showStars2 = false
    @State var showStars3 = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "apple.terminal.fill")
                    Text("Mission Control Terminal")
                }
                .fontWeight(.bold)
                .fontDesign(.monospaced)
                .foregroundStyle( Color(hex: colorScheme == .light ? "505050" : "C9C9C9"))
                
                Spacer()
                
                // live badge
                if showLiveBadge {
                    HStack(spacing: 4) {
                        
                        Text("LIVE")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "circle.circle.fill")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .padding(.leading, 8)
                    .padding(.trailing, 4)
                    .padding(.vertical, 4)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(hex: "F76F5F").opacity(liveBlinking ? 0.35 : 1))
                    }
                    .foregroundStyle( Color(hex: colorScheme == .light ? "505050" : "C9C9C9"))
                }

                
            }
            
            Text(currentMissionControlMessage)
                .font(.subheadline)
                .fontDesign(.monospaced)
                .foregroundStyle(.gray)
                .onAppear {
                    // if the person is in the first level
                    if !gameManager.secondLevelAvailable {
                        
                        // check if the message was already typewritten
                        if gameManager.animateFirstLevelMessage {
                            // message setup
                            gameManager.animateFirstLevelMessage = false
                            missionControlMessage = gameManager.firstLevelMissionControlMessage
                            typeWriter()
                            
                        } else {
                            missionControlMessage = gameManager.firstLevelMissionControlMessage
                            currentMissionControlMessage = gameManager.firstLevelMissionControlMessage
                        }
                    
                    // if the person is in the second level
                    } else if gameManager.secondLevelAvailable && (!gameManager.thirdLevelAvailable) {
                        
                        // check if the message was already typewritten
                        if gameManager.animateSecondLevelMessage {
                            gameManager.animateSecondLevelMessage = false
                            missionControlMessage = gameManager.secondLevelMissionControlMessage
                            typeWriter()
                            
                        } else {
                            missionControlMessage = gameManager.secondLevelMissionControlMessage
                            currentMissionControlMessage = gameManager.secondLevelMissionControlMessage
                        }
                        
                    } else if gameManager.thirdLevelAvailable && !gameManager.allLevelsComplete {
                        // check if the message was already typewritten
                        if gameManager.animateThirdLevelMessage {
                            gameManager.animateThirdLevelMessage = false
                            missionControlMessage = gameManager.thirdLevelMissionControlMessage
                            typeWriter()
                            
                        } else {
                            missionControlMessage = gameManager.thirdLevelMissionControlMessage
                            currentMissionControlMessage = gameManager.thirdLevelMissionControlMessage
                        }

                    } else if gameManager.allLevelsComplete {
                        // check if the message was already typewritten
                        if gameManager.animateFinalMessage {
                            gameManager.animateFinalMessage = false
                            missionControlMessage = gameManager.allLevelsCompleteMissionControlMessage
                            typeWriter()
                            
                        } else {
                            missionControlMessage = gameManager.allLevelsCompleteMissionControlMessage
                            currentMissionControlMessage = gameManager.allLevelsCompleteMissionControlMessage
                        }
                    }
                }
            
            if gameManager.allLevelsComplete && !showLiveBadge {
                Spacer()
                
                HStack {
                    Spacer()
                    ZStack {
                        Image(colorScheme == .light ? "badgeLight" : "badgeDark")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 180)
                        
                        if showStars1 {
                            Image("badgeStars1")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 180)
                                .opacity(colorScheme == .light ? 1 : 0.5)
                        }
                        
                        if showStars2 {
                            Image("badgeStars2")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 180)
                                .opacity(colorScheme == .light ? 1 : 0.5)
                        }
                        
                        if showStars3 {
                            Image("badgeStars3")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 180)
                                .opacity(colorScheme == .light ? 1 : 0.5)
                        }
                    }
                    .onAppear {
                        // setup for the cards' stars animations
                        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                            showStars1.toggle()
                        }
                        
                        withAnimation(.easeInOut(duration: 1.25).repeatForever(autoreverses: true)) {
                            showStars2.toggle()
                        }
                        
                        withAnimation(.easeInOut(duration: 1.75).repeatForever(autoreverses: true)) {
                            showStars3.toggle()
                        }
                    }
                    
                    
                    Spacer()
                    
                }
                
            }
            
            
            Spacer()
            
            // star border detail
            HStack {
                Spacer()
                
                Image("starBorder")
            }
        }
        .padding()
        .background(.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    func typeWriter(at position: Int = 0) {
        if position == 0 {
            // display "live" badge
            withAnimation(.spring) {
                showLiveBadge = true
            }
            withAnimation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true)) {
                liveBlinking.toggle()
            }
            
            currentMissionControlMessage = ""
            
        } else if position == missionControlMessage.count {
            withAnimation(.easeInOut(duration: 1)) {
                liveBlinking = false
                showLiveBadge = false
            }
        }
        
        if position < missionControlMessage.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.065) {
                currentMissionControlMessage.append(missionControlMessage[position])
                typeWriter(at: position + 1)
            }
        }
    }
}

#Preview {
    MissionControlTerminalView()
        .environmentObject(GameManager())
}
