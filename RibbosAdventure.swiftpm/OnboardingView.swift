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
    @State var showStars1 = true
    @State var showStars2 = false
    @State var showStars3 = false
    
    var body: some View {
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
                }
                if showStars2 {
                    Image("onboardingStars2")
                }
                if showStars3 {
                    Image("onboardingStars3")
                }
            }
            
            if onboardingStage == 1 {
                // ribboBlueprint
                HStack {
                    Image("ribboBlueprint")
                    Spacer()
                }
            }
            
            
            // text
            HStack {
                if onboardingStage == 0 {
                    Text("Ribbo's Adventure")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontDesign(.monospaced)
                        .frame(width: 500)
                        .lineSpacing(16.0)
                        .padding(.trailing, 32)
                    
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
                    
                    Text("Your job is to help Ribbo overcome these challenges by creating algorithms, a set of steps, for him to follow.\nFor each mission, there will always be a job description that the control center provided to you, in case you need any help along the way!")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontDesign(.monospaced)
                        .frame(width: 500)
                        .lineSpacing(16.0)
                        .padding(.trailing, 32)
                        .multilineTextAlignment(.center)
                }
                
            }
            .padding()
            
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
                            finishedOnboarding = true
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

//#Preview {
//    OnboardingView()
//}
