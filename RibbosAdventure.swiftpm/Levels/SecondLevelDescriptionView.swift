//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 26/01/24.
//

import SwiftUI

struct SecondLevelDescriptionView: View {
    var commandBlocksGallery: [CodeBlock] = [CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock), CodeBlock(command: "rotateLeft()", highlighted: false, type: .commandBlock), CodeBlock(command: "rotateRight()", highlighted: false, type: .commandBlock)]
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
                    
                    Text("Castle Planet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("blue"))
                    
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
            Text("Ribbo is now on Castle Planet and needs to go through a foggy area that seems dangerous.")
            
            Text("Castle Planet is much further away from Earth, so we can only send 10 blocks to Ribbo. Because of this, we have provided you with For Loop blocks, which run all of the commands inside of it a predetermined number of times.")
            
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
                                Text("for")
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
                    .fill(Color(hex: "292A2F"))
            }
            .padding(.vertical, 8)
            
            Text("We're counting on you!")
            
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
