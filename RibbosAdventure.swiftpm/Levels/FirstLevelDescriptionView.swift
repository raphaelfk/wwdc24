//
//  SwiftUIView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 25/01/24.
//

import SwiftUI

struct FirstLevelDescriptionView: View {
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
                    
                    Text("Grass Planet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(hex: "A8D47B"))
                    
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
            Text("Ribbo found a river on his journey in Grass Planet, but it does not know how to go through it.")
            
            Text("It has sent a 3D model of his surroundings to us, so maybe you can use some of his commands to help him.")
            
            Text("The commands are presented on the Coding Console we provided to you:")
            
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
                    
                    // command blocks
                    ForEach(commandBlocksGallery) { codeBlock in
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
                    }
                }
            }
            .padding()
            .background(Color(hex: "292A2F"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
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
