//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 26/01/24.
//

import SwiftUI

struct CongratulationSheetView: View {
    var commandBlocksGallery: [CodeBlock] = [CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock), CodeBlock(command: "rotateLeft()", highlighted: false, type: .commandBlock), CodeBlock(command: "rotateRight()", highlighted: false, type: .commandBlock)]
    //@Binding var descriptionVisibility: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // header
            HStack(alignment: .top) {
                HStack(alignment: .top, spacing: 6) {
                    Text("Congratulations!")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                    
                    Image("sparkling-stars")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                        .foregroundStyle(Color(hex: "A8D47B"))
                        
                }
                
                Spacer()
                
                Button(action: {
                    //descriptionVisibility = false
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
            Text("Your code was sent and helped Ribbo overcome this challenge and continue his successful mission on Grass Planet.")
            
            Text("It’s by building code blocks like this that scientists send actual robots to explore other planets in our universe!")
            
            Text("You can now take a look at the Grass Planet Mission log on your dashboard and try to complete other missions!")
            
            // Code blocks example
            HStack {
                // ribbo commands
                VStack(alignment: .leading) {
                    Text("Grass Planet")
                        .foregroundStyle(Color(hex: "A8D47B"))
                        .fontWeight(.semibold)

                    // command blocks
                    HStack(alignment: .top) {
                        Text("This planet’s highlights were, mainly, it's nature formations.")
                        
                        Spacer()
                        
                        Image("grassSample")
                    }
                }
            }
            .padding()
            .background(.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button(action: {
                
            }, label: {
                Text("Go to Dashboard")
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        Color(hex: "A8D47B")
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            })
            
            
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

#Preview {
    CongratulationSheetView()
}
