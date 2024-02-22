//
//  OnboardingView.swift
//  Ribbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 18/01/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var finishedOnboarding: Bool
    @State var onboardingStage = 0
    @State var rotateStar = false
    @State var showTitle = false
    @State var showStars1 = true
    @State var showStars2 = false
    @State var showStars3 = false
    @State var showStartButton = false
    @State var titleDetailWidth = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.03, green: 0.05, blue: 0.22), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.02, green: 0.03, blue: 0.14), location: 0.50),
                        Gradient.Stop(color: Color(red: 0.01, green: 0.04, blue: 0.16), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 1, y: 0),
                    endPoint: UnitPoint(x: 0, y: 1)
                )
                .ignoresSafeArea()
                .onAppear {
                    // setup for the cards' stars animations
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        showStars1.toggle()
                    }
                    
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        showStars2.toggle()
                    }
                    
                    withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                        showStars3.toggle()
                    }
                }
                
                
                ZStack {
                    if showStars1 {
                        Image("onboardingStars1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                    }
                    if showStars2 {
                        Image("onboardingStars2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                    }
                    if showStars3 {
                        Image("onboardingStars3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                    }
                }
                
                // images
                if onboardingStage == 1 {
                    // ribboBlueprint
                    HStack {
                        Image("ribboBlueprint")
                        Spacer()
                    }
                } else if onboardingStage == 2 {
                    // console blueprint
                    HStack {
                        Spacer()
                        Image("consoleBlueprint")
                            .padding(.trailing, 60)
                    }
                }
                
                // text
                HStack {
                    if onboardingStage == 0 {
                        Spacer()
                        
                        if showTitle {
                            VStack(spacing: 24) {
                                Text("RIBBO'S")
                                    .foregroundStyle(.white)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .fontDesign(.monospaced)
                                
                                
                                HStack(alignment: .center, spacing: 16) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: titleDetailWidth, height: 2)
                                        .foregroundStyle(.white)
                                    
                                    Image("titleStar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .rotationEffect(Angle.degrees(rotateStar ? 360 : 0))
                                    
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: titleDetailWidth, height: 2)
                                        .foregroundStyle(.white)
                                    
                                }
                                
                                Text("ADVENTURE")
                                    .foregroundStyle(.white)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .fontDesign(.monospaced)
                                
                            }
                            .onAppear {
                                withAnimation(.easeInOut(duration: 2.5)) {
                                    titleDetailWidth = 100
                                    showStartButton = true
                                    rotateStar.toggle()
                                }
                            }
                        }
                        
                        Spacer()
                        
                        
                    } else if onboardingStage == 1 {
                        Spacer()
                        
                        Text("You have been contacted by RSC (Ribbo Space Center) to help them with their newest robot: Ribbo.\n\nRibbo is on a mission to collect data and study samples from other planets, and it is able to scan its surroundings when it detects strange terrains that it does not know how to go through.")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontDesign(.monospaced)
                            .frame(width: 500)
                            .lineSpacing(16.0)
                            .padding(.trailing, 32)
                        
                    } else if onboardingStage == 2 {
                        
                        Text("Your job is to help Ribbo overcome these challenges by creating algorithms, a set of steps, for him to follow.\n\nRCS is counting on you!")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontDesign(.monospaced)
                            .frame(width: 500)
                            .lineSpacing(16.0)
                            .padding(.leading, 72)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    
                }
                .padding()
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        showTitle = true
                    }
                }
                
                // button
                VStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring) {
                            if onboardingStage == 0 {
                                onboardingStage = 1
                            } else if onboardingStage == 1 {
                                onboardingStage = 2
                            } else if onboardingStage == 2 {
                                withAnimation(.easeInOut(duration: 1.5)) {
                                    finishedOnboarding = true
                                }
                            }
                        }
                        
                    }, label: {
                        if onboardingStage == 0 {
                            Text("Start")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.white.opacity(0.25))
                                }
                                .padding(.bottom, 64)
                        } else if onboardingStage == 1 {
                            Text("Tell me more...")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.white.opacity(0.25))
                                }
                                .padding(.bottom, 64)
                        } else if onboardingStage == 2 {
                            Text("I'm Ready!")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.white.opacity(0.25))
                                }
                                .padding(.bottom, 64)
                        }
                        
                        
                    })
                    .buttonStyle(.plain)
                }
            }
            
            
            
        }
    }
}

//#Preview {
//    OnboardingView()
//}
