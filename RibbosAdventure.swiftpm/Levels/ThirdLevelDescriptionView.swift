//
//  ThirdLevelDescriptionView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 26/01/24.
//

import SwiftUI

struct ThirdLevelDescriptionView: View {
    var commandBlocksGallery: [CodeBlock] = [CodeBlock(command: "moveForward()", type: .commandBlock), CodeBlock(command: "rotateLeft()", type: .commandBlock), CodeBlock(command: "rotateRight()", type: .commandBlock)]
    @Binding var descriptionVisibility: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Mission Description")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                    
                    Text("Party Planet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("purple"))
                    
                }
                
                Spacer()
                
                Button(action: {
                    descriptionVisibility = false
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray.opacity(0.25))
                })
                .buttonStyle(.plain)
                
            }
            .padding(.bottom)
            
            // description
            Text("Ribbo is now on his last mission, all thanks to you!")
            
            Text("The 10 blocks limit remains, but now Ribbo is challenged by a color changing dancefloor. Our scientists have started an algorithm that you can complete and have provided if statements that you can use.")
            
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
                    .fill(Color(hex: "292A2F"))
            }
            .padding(.vertical, 8)
            
            Text("We count on you to solve this last one!")
            
            Spacer()
            
            // page watermarks
            HStack(alignment: .bottom) {
                Image("rsc-watermark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                
                Spacer()
                
                Image("starBorder")
                
            }
        }
        .padding(32)
    }
}

//#Preview {
//    SecondLevelDescriptionView()
//}
