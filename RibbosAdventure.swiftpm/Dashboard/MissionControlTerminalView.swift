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
                        
                    } else if gameManager.thirdLevelAvailable {
//                        Text("Your help is needed in one last mission!\nThis one might be harder than the others.")
//                            .font(.subheadline)
//                            .fontDesign(.monospaced)
//                            .foregroundStyle(.gray)
                    } else if gameManager.allLevelsComplete {
//                        Text("The RSC really appreciates all of the help you provided!\nYou are now entitled a Certified Space Explorer!")
//                            .font(.subheadline)
//                            .fontDesign(.monospaced)
//                            .foregroundStyle(.gray)
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
            
        } else if position == gameManager.firstLevelMissionControlMessage.count {
            withAnimation(.easeInOut(duration: 1)) {
                liveBlinking = false
                showLiveBadge = false
            }
        }
        
        if position < gameManager.firstLevelMissionControlMessage.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.065) {
                currentMissionControlMessage.append(gameManager.firstLevelMissionControlMessage[position])
                typeWriter(at: position + 1)
            }
        }
    }
}

#Preview {
    MissionControlTerminalView()
        .environmentObject(GameManager())
}
