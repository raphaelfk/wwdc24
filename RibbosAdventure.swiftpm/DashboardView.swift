//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 18/01/24.
//

import SwiftUI

struct DashboardView: View {
    @State var allLevelsComplete = false
    @State private var animateGradient = false
    @Environment(\.colorScheme) var colorScheme
    @State var firstLevelComplete = false
    @State var secondLevelAvailable = true
    @State var secondLevelComplete = false
    @State var showStars1 = true
    @State var showStars2 = false
    @State var showStars3 = false
    @State var thirdLevelAvailable = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(spacing: 16){
                // first level card
                ZStack {
                    // background image
                    HStack {
                        Spacer()
                        ZStack {
                            Image("firstCardOrbits")
                                .resizable()
                                .scaledToFit()
                            
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
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                FirstLevelView(firstLevelComplete: $firstLevelComplete, secondLevelAvailable: $secondLevelAvailable)
                            } label: {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("Play")
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
                
                // second level card
                ZStack {

                    // background image
                    HStack {
                        Spacer()
                        if secondLevelAvailable {
                            ZStack {
                                Image("secondCardOrbits")
                                    .resizable()
                                    .scaledToFit()
                                
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
                        
                        HStack {
                            Spacer()
                            
                            if secondLevelAvailable {
                                NavigationLink {
                                    SecondLevelView(secondLevelComplete: $secondLevelComplete, thirdLevelAvailable: $thirdLevelAvailable)
                                } label: {
                                    HStack {
                                        Image(systemName: "play.fill")
                                        Text("Play")
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
                    if !secondLevelAvailable {
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
                
                // third level card
                ZStack {
                    // background image
                    HStack {
                        Spacer()
                        
                        if thirdLevelAvailable {
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
                            
                            if thirdLevelAvailable {
                                Button(action: {
                                    
                                }, label: {
                                    HStack {
                                        Image(systemName: "play.fill")
                                        Text("Play")
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
                    
                    if !thirdLevelAvailable {
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
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "apple.terminal.fill")
                        Text("Mission Control Terminal")
                    }
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .foregroundStyle( Color(hex: colorScheme == .light ? "505050" : "C9C9C9"))
                    
                    
                    if !secondLevelAvailable {
                        Text("Start with the first mission.\nOnce you complete it, others will become available!")
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.gray)
                    } else if secondLevelAvailable && (!thirdLevelAvailable) {
                        Text("Ribbo is now on the Castle Planet.\nIt needs your help again in his second mission!")
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.gray)
                    } else if thirdLevelAvailable {
                        Text("Your help is needed in one last mission!\nThis one might be harder than the others.")
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.gray)
                    } else if allLevelsComplete {
                        Text("The RSC really appreciates all of the help you provided!\nYou are now entitled a Certified Space Explorer!")
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.gray)
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
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
                
                
                // planet logs
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "doc.on.clipboard.fill")
                        Text("Planet Logs")
                    }
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .foregroundStyle( Color(hex: colorScheme == .light ? "505050" : "C9C9C9"))
                    
                    if firstLevelComplete {
                        
                    } else {
                        Text("You still have no logs. Try completing a mission to get your first one.")
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.gray)
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
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
                
            }
            
        }
        .padding()
        .navigationTitle("Mission Dashboard")
    }
}

#Preview {
    DashboardView()
}
