//
//  ForBlockView.swift
//  Ribbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 24/01/24.
//

import SwiftUI

struct ForBlockView: View {
    let codeBlock: CodeBlock
    @Binding var codeBlocksList: [CodeBlock]
    @Binding var runningScene: Bool
    @Binding var selectedBlock: UUID?
    @State var showNumberPad = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                    
                    Text(codeBlock.command ?? "0")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .frame(width: 36, height: 28)
                    
                }
                .onTapGesture {
                    showNumberPad = true
                }
                .popover(isPresented: $showNumberPad) {
                    NumberPadView(blockID: codeBlock.id, codeBlocksList: $codeBlocksList)
                        .padding()
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
            
            
            
            // place for commands to be added
            VStack(alignment: .leading, spacing: 0) {
                if codeBlock.inlineBlocks.isEmpty {
                    HStack(spacing: 16) {
                        Rectangle()
                            .fill(Color(hex: "FF79B3"))
                            .frame(width: 8, height: 80)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(codeBlock.id == self.selectedBlock ? Color(hex: "BFAD5A") : .white.opacity(0.5))
                            .frame(width: 48, height: 32)
                            .onTapGesture {
                                withAnimation(.interactiveSpring) {
                                    self.selectedBlock = codeBlock.id
                                }
                            }
                    }
                    
                } else {
                    Rectangle()
                        .fill(Color(hex: "FF79B3"))
                        .frame(width: 8, height: 4)
                    
                    ForEach(codeBlock.inlineBlocks) { inlineBlock in
                        HStack(alignment: .center, spacing: 16) {
                            Rectangle()
                                .fill(Color(hex: "FF79B3"))
                                .frame(width: 8, height: 44)
                            
                            HStack(alignment: .center) {
                                Text(inlineBlock.command ?? "Error")
                                    .fontDesign(.monospaced)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                
                                if !runningScene {
                                    Divider()
                                    
                                    Image(systemName: "xmark")
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                        .font(.footnote)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background {
                                Color(hex: inlineBlock.highlighted ? "BFAD5A" : "78C1B3")
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(height: 36)
                            .onTapGesture {
                                // go through list and delete the tapped code block
                                if !runningScene {
#warning("fazer a lógica de deletar o code block de dentro")
                                    withAnimation(.interactiveSpring) {
                                        var index = 0
                                        for codeBlockSearched in codeBlock.inlineBlocks {
                                            if codeBlockSearched.id == inlineBlock.id {
                                                codeBlocksList.remove(at: index)
                                                break
                                            }
                                            index += 1
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    
                    Rectangle()
                        .fill(Color(hex: "FF79B3"))
                        .frame(width: 8, height: 4)
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
