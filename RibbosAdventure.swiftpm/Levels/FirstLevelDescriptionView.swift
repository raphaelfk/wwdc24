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
                    Image(systemName: "xmark")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .padding(8)
                        .background {
                            Circle()
                                .fill(.gray.opacity(0.15))
                        }
                })
                .buttonStyle(.plain)
                
            }
            .padding(.bottom)
            
            // description
            Text("On his first mission, Ribbo found a river on his journey in Grass Planet, but it does not know how to go through it. It has sent a 3D model of his surroundings to us, so maybe you can use some of his commands to help it!")
            
            Text("You'll need to create an algorithm for it to follow, so here's a sneak peek of what you will have to use:")
            
            // Code blocks example
            HStack {
                // ribbo commands
                VStack(alignment: .leading) {
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
                    ForEach(commandBlocksGallery) { codeBlock in
                        HStack(alignment: .center, spacing: 16) {
                            Text(codeBlock.command ?? "Error")
                                .fontDesign(.monospaced)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background {
                                    Color(.white).opacity(0.2)
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
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.white)
            }
            
            Text("You can tap on each of them to add them to the console.")
            
            Text("After you create your algorithm, you can test it on our simulator. If it passes, we will send it to Ribbo, but if it fails, it's just a simulator! Ribbo will be fine!")
            
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
