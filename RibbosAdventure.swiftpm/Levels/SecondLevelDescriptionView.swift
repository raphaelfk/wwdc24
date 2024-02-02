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
                        .foregroundStyle(Color(hex: "5F79D4"))
                    
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
            Text("Ribbo is now on Castle Planet and needs to go through an area that seems dangerous.")
            
            Text("There is too much fog where it's at, so it might need your help to go through this challenge!")
            
            Text("Castle Planet is much further away from Earth than Grass Planet was, so we can only send 10 blocks to Ribbo. Because of this, we have provided you with For Loop blocks, which run all of the commands inside of it a predetermined number of times:")
            
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
            
            Text("You can now create your algorithm, but just be mindful about how many code blocks you are using!")
            
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
