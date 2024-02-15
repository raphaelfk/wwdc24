//
//  ForBlockView.swift
//  Ribbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 24/01/24.
//

import SwiftUI

struct ForBlockView: View {
    let codeBlock: CodeBlock
    @Binding var codeBlocksCount: Int
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
                
                if !runningScene {
                    HStack(spacing: 12) {
                        Divider()
                        
                        Image(systemName: "xmark")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .font(.footnote)
                    }
                    .onTapGesture {
                        // removing block from codeBlocks list
                        withAnimation(.interactiveSpring) {
                            var listIndex = 0
                            for codeBlockSearched in codeBlocksList {
                                if codeBlockSearched.id == codeBlock.id {
                                    codeBlocksList.remove(at: listIndex)
                                    break
                                }
                                listIndex += 1
                            }
                            
                            updateCodeBlocksCount()
                        }
                    }
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
                                    withAnimation(.interactiveSpring) {
                                        // getting the for block index
                                        var listIndex = 0
                                        for codeBlockSearched in codeBlocksList {
                                            if codeBlockSearched.id == codeBlock.id {
                                                break
                                            }
                                            listIndex += 1
                                        }
                                        
                                        // searching for the inline block to be deleted and removing it from the for's inlineBlocks list
                                        var inlineListIndex = 0
                                        for inlineBlockSearched in codeBlocksList[listIndex].inlineBlocks {
                                            if inlineBlockSearched.id == inlineBlock.id {
                                                codeBlocksList[listIndex].inlineBlocks.remove(at: inlineListIndex)
                                                break
                                            }
                                            inlineListIndex += 1
                                        }
                                        
                                        updateCodeBlocksCount()
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    
                    if !runningScene {
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
    
    func updateCodeBlocksCount() {
        var updatedCount = 0
        
        for codeBlock in codeBlocksList {
            if codeBlock.type == .forBlock || codeBlock.type == .ifBlock {
                updatedCount += 1
                
                // counting all of the inline blocks
                for _ in codeBlock.inlineBlocks {
                    updatedCount += 1
                }
            } else {
                updatedCount += 1
            }
        }
        
        withAnimation(.interactiveSpring) {
            codeBlocksCount = updatedCount
        }
    }
}
