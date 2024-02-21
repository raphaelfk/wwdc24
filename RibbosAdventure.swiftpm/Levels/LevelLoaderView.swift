//
//  LoaderView.swift
//  Ribbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 25/01/24.
//

import SwiftUI

struct LoaderView: View {
    @State var currentMission: Int = 1
    @State var isRotated = false
    @Binding var showLoaderView: Bool
    @State var showRocketLoader = true
    let firstLevelCodeBlocks = [
        CodeBlock(command: "moveForward()", explanation: "// makes Ribbo move forward by only one tile", type: .commandBlock),
        CodeBlock(command: "rotateLeft()", explanation: "// makes Ribbo rotate to it's left direction", type: .commandBlock),
        CodeBlock(command: "rotateRight()", explanation: "// makes Ribbo rotate to it's right direction", type: .commandBlock)
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                // background
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
                
                Image("loaderStars")
                    .resizable()
                    .scaledToFit()
                
                // first mission description
                if currentMission == 1 {
                    HStack(alignment: .center) {
                        // description text
                        VStack(alignment: .leading, spacing: 24) {
                            
                            // header
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Mission Description")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .fontDesign(.monospaced)
                                        .foregroundStyle(.white)
                                    
                                    Text("Grass Planet")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(hex: "A8D47B"))
                                    
                                }
                                
                                Spacer()
                                
                            }
                            .padding(.bottom)
                            
                            // description
                            Text("Ribbo found a river on his journey in Grass Planet, but it does not know how to go through it. Maybe you can use some of his commands to help it!")
                                .foregroundStyle(.white)
                            
                            Text("We've gathered the commands available to you on the panel to your right.")
                                .foregroundStyle(.white)
                            
                            Text("Good luck!")
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                            
                            Text("(You can always take a look at the description from inside the mission)")
                                .foregroundStyle(.gray)
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: geo.size.width / 1.6)
                        .padding(.horizontal, 80)
                        .padding(.bottom, 64)
                        
                        Spacer()
                        
                        // Code blocks example
                        VStack(alignment: .leading, spacing: 20) {
                            HStack(spacing: 4) {
                                Image(systemName: "command")
                                Text("Commands")
                                
                                Spacer()
                            }
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.bottom, 4)
                            
                            // command blocks
                            ForEach(firstLevelCodeBlocks) { codeBlock in
                                HStack(alignment: .center, spacing: 16) {
                                    Text(codeBlock.command ?? "Error")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background {
                                            Color(hex: "78C1B3")
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Text(codeBlock.explanation ?? "")
                                        .font(.subheadline)
                                        .fontDesign(.monospaced)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                    
                                }
                                
                            }
                        }
                        .padding()
                        .padding(.bottom)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, 40)
                        .padding(.trailing, 32)
                    }
                    
                // second mission description
                } else if currentMission == 2 {
                    HStack(alignment: .center) {
                        // description text
                        VStack(alignment: .leading, spacing: 24) {
                            
                            // header
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Mission Description")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .fontDesign(.monospaced)
                                        .foregroundStyle(.white)
                                    
                                    Text("Castle Planet")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color("blue"))
                                    
                                }
                                
                                Spacer()
                                
                            }
                            .padding(.bottom)
                            
                            // description
                            Text("Ribbo is now on Castle Planet and needs to go through a foggy area that seems dangerous.")
                                .foregroundStyle(.white)
                            
                            Text("Castle Planet is much further away from Earth, so we can only send 10 blocks to Ribbo. Because of this, we have provided you with For Loop blocks, which run all of the commands inside of it a predetermined number of times.")
                                .foregroundStyle(.white)
                            
                            Text("We're counting on you!")
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                            
                            Text("(You can always take a look at the description from inside the mission)")
                                .foregroundStyle(.gray)
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: geo.size.width / 1.6)
                        .padding(.horizontal, 80)
                        .padding(.bottom, 64)
                        
                        Spacer()
                        
                        // Code blocks example
                        HStack {
                            // ribbo commands
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                    Text("For Loops")
                                    
                                    Spacer()
                                }
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.bottom, 4)
                                
                                // for block
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack(spacing: 16) {
                                        // for head
                                        HStack(spacing: 16) {
                                            Text("repeat for")
                                                .fontDesign(.monospaced)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)
                                            
                                            // place for number to be added
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(.white.opacity(0.5))
                                                    .frame(width: 36, height: 28)
                                                
                                                Text("5")
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .keyboardType(.numberPad)
                                                    .frame(width: 36, height: 28)
                                                
                                            }
                                            
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background {
                                            Color(hex: "FF79B3")
                                        }
                                        .clipShape(
                                            .rect(
                                                topLeadingRadius: 8,
                                                bottomLeadingRadius: 0,
                                                bottomTrailingRadius: 8,
                                                topTrailingRadius: 8
                                            )
                                        )
                                        
                                        // comments
                                        Text("// select how many times the inline commands will run")
                                            .font(.subheadline)
                                            .fontDesign(.monospaced)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                    }

                                    // inline commands
                                    VStack(alignment: .leading, spacing: 0) {
                                        Rectangle()
                                            .fill(Color(hex: "FF79B3"))
                                            .frame(width: 8, height: 4)
                                        
                                        // move forward command
                                        HStack(alignment: .center, spacing: 16) {
                                            Rectangle()
                                                .fill(Color(hex: "FF79B3"))
                                                .frame(width: 8, height: 48)
                                            
                                            HStack(alignment: .center) {
                                                Text("moveForward()")
                                                    .fontDesign(.monospaced)
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.white)
                                                
                                            }
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background {
                                                Color(hex: "78C1B3")
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .frame(height: 36)
                                        }

                                        Rectangle()
                                            .fill(Color(hex: "FF79B3"))
                                            .frame(width: 8, height: 4)
                                        
                                        // place to add more commands
                                        HStack(spacing: 16) {
                                            Rectangle()
                                                .fill(Color(hex: "FF79B3"))
                                                .frame(width: 8, height: 48)
                                            
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.white.opacity(0.5))
                                                .frame(width: 48, height: 32)
                                            
                                            // comments
                                            Text("// place to add blocks inside the for loop")
                                                .font(.subheadline)
                                                .fontDesign(.monospaced)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)
                                            
                                            
                                        }
                                        
                                    }
                                    
                                    
                                    Rectangle()
                                        .fill(Color(hex: "FF79B3"))
                                        .frame(width: 32, height: 16)
                                        .clipShape(
                                            .rect(
                                                topLeadingRadius: 0,
                                                bottomLeadingRadius: 4,
                                                bottomTrailingRadius: 4,
                                                topTrailingRadius: 4
                                            )
                                        )
                                }

                            }
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, 40)
                        .padding(.trailing, 32)
                        
                        
                    }
                } else if currentMission == 3 {
                    HStack(alignment: .center) {
                        // description text
                        VStack(alignment: .leading, spacing: 24) {
                            
                            // header
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Mission Description")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .fontDesign(.monospaced)
                                        .foregroundStyle(.white)
                                    
                                    Text("Party Planet")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color("purple"))
                                    
                                }
                                
                                Spacer()
                                
                            }
                            .padding(.bottom)
                            
                            // description
                            Text("Ribbo is now on his last mission, all thanks to you!")
                                .foregroundStyle(.white)
                            
                            Text("The 10 blocks limit remains, but now Ribbo is challenged by a color changing dancefloor. Our scientists have started an algorithm that you can complete and have provided if statements that you can use.")
                                .foregroundStyle(.white)
                            
                            Text("We count on you to solve this last one!")
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                            
                            Text("(You can always take a look at the description and get tips from inside the mission)")
                                .foregroundStyle(.gray)
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: geo.size.width / 1.6)
                        .padding(.horizontal, 80)
                        .padding(.bottom, 64)
                        
                        Spacer()
                        
                        // Code blocks example
                        HStack {
                            // ribbo commands
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.triangle.branch")
                                    Text("If Statements")
                                    
                                    Spacer()
                                }
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.bottom, 4)
                                
                                // if block
                                VStack(alignment: .leading, spacing: 0) {
                                    // for head and comment
                                    HStack(spacing: 16) {
                                        HStack(spacing: 16) {
                                            Text("if")
                                                .fontDesign(.monospaced)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)
                                            
                                            // place condition selection
                                            Text("isOnPinkTile")
                                                .foregroundStyle(.white)
                                                .multilineTextAlignment(.center)
                                                .keyboardType(.numberPad)
                                                .frame(height: 28)
                                                .padding(.horizontal, 8)
                                                .background {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(.white.opacity(0.5))
                                                        .frame(height: 28)
                                                }
                                            
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background {
                                            Color(hex: "906EBC")
                                        }
                                        .clipShape(
                                            .rect(
                                                topLeadingRadius: 8,
                                                bottomLeadingRadius: 0,
                                                bottomTrailingRadius: 8,
                                                topTrailingRadius: 8
                                            )
                                        )
                                        
                                        // comment
                                        Text("// select the condition for the inline blocks to run")
                                            .font(.subheadline)
                                            .fontDesign(.monospaced)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    // place for commands to be added
                                    VStack(alignment: .leading, spacing: 0) {
                                        // if side detail
                                        Rectangle()
                                            .fill(Color(hex: "906EBC"))
                                            .frame(width: 8, height: 4)
                                        
                                        // rotate left command
                                        HStack(alignment: .center, spacing: 16) {
                                            Rectangle()
                                                .fill(Color(hex: "906EBC"))
                                                .frame(width: 8, height: 48)
                                            
                                            HStack(alignment: .center) {
                                                Text("rotateLeft()")
                                                    .fontDesign(.monospaced)
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.white)
                                                
                                            }
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background {
                                                Color(hex: "78C1B3")
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .frame(height: 36)

                                        }
                                        
                                        // space to add more commands
                                        HStack(spacing: 16) {
                                            Rectangle()
                                                .fill(Color(hex: "906EBC"))
                                                .frame(width: 8, height: 48)
                                            
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.white.opacity(0.5))
                                                .frame(width: 48, height: 32)
                                            
                                            // comment
                                            Text("// place to add more commands")
                                                .font(.subheadline)
                                                .fontDesign(.monospaced)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)
                                            
                                        }
                                        
                                        Rectangle()
                                            .fill(Color(hex: "906EBC"))
                                            .frame(width: 8, height: 4)
                                        
                                    }
                                    Rectangle()
                                        .fill(Color(hex: "906EBC"))
                                        .frame(width: 32, height: 16)
                                        .clipShape(
                                            .rect(
                                                topLeadingRadius: 0,
                                                bottomLeadingRadius: 4,
                                                bottomTrailingRadius: 4,
                                                topTrailingRadius: 4
                                            )
                                        )
                                    
                                }
                            }
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, 40)
                        .padding(.trailing, 32)
                    }
                }
                
                
                // rocket loader and button
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        if showRocketLoader {
                            Image("rocket-loader")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                                .padding()
                                .padding(.horizontal)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 0.75).repeatForever(autoreverses: false)) {
                                        isRotated.toggle()
                                    }
                                }
                        } else {
                            Button {
                                withAnimation(.easeInOut(duration: 1)) {
                                    showLoaderView = false
                                }
                            } label: {
                                HStack(spacing: 8) {
                                    Text("Go to Mission")
                                    Image(systemName: "chevron.forward")
                                }
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background {
                                    if currentMission == 1 {
                                        Color("green")
                                    } else if currentMission == 2 {
                                        Color("blue")
                                    } else {
                                        Color("purple")
                                    }
                                   
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .padding(32)

                        }
                        
                    }
                }
                
                
            }
            .onAppear {
                Task {
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showRocketLoader = false
                    }
                    
                }
            }
        }
       
    }
}
