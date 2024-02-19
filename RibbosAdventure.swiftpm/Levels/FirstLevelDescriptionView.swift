//
//  SwiftUIView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 25/01/24.
//

import SwiftUI

struct FirstLevelDescriptionView: View {
    var commandBlocksGallery: [CodeBlock] = [
        CodeBlock(command: "moveForward()", explanation: "// makes Ribbo move forward only one time", highlighted: false, type: .commandBlock),
        CodeBlock(command: "rotateLeft()", explanation: "// makes Ribbo rotate to it's left direction", highlighted: false, type: .commandBlock),
        CodeBlock(command: "rotateRight()", explanation: "// makes Ribbo rotate to it's right direction", highlighted: false, type: .commandBlock)
    ]
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
                    
                    Text("Grass Planet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("green"))
                    
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
            Text("Ribbo found a river on his journey in Grass Planet, but it does not know how to go through it. Maybe you can use some of his commands to help it!")
            
            Text("We've gathered the commands available to you:")
            
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
                
                let firstLevelCodeBlocks = [
                    CodeBlock(command: "moveForward()", explanation: "// makes Ribbo move forward by only one tile", highlighted: false, type: .commandBlock),
                    CodeBlock(command: "rotateLeft()", explanation: "// makes Ribbo rotate to it's left direction", highlighted: false, type: .commandBlock),
                    CodeBlock(command: "rotateRight()", explanation: "// makes Ribbo rotate to it's right direction", highlighted: false, type: .commandBlock)
                ]
                
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
                    .fill(Color(hex: "292A2F"))
            }
            .padding(.vertical, 8)
            
            Text("You can tap on each of them to add them to the console.")
            
            Text("Good luck!")
            
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
//    FirstLevelDescriptionView()
//}
