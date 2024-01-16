//
//  CodeEditorView.swift
//  Robbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 16/01/24.
//

import SwiftUI

struct CodeBlock: Identifiable, Equatable {
    var id = UUID()
    var command: String?
    var condition: String?
    var inlineBlocks: [CodeBlock] = []
    let type: CodeBlockType
}

enum CodeBlockType: Equatable {
    case commandBlock
    case forBlock
    case ifBlock
}

struct CodeEditorView: View {
    var codeBlocksList: [CodeBlock] = [CodeBlock(command: "moveForward", type: .commandBlock), CodeBlock(type: .ifBlock)]
    var codeBlocksGallery: [CodeBlock] = [CodeBlock(command: "moveForward", type: .commandBlock), CodeBlock(command: "moveLeft", type: .commandBlock)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top bar
            HStack {
                Image(systemName: "chevron.left.forwardslash.chevron.right")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text("Code")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .padding()
            
            // Divider
            Rectangle()
                .frame(height: 0.35)
                .foregroundStyle(.white)
            
            // Code
            VStack(alignment: .leading, spacing: 12) {
                // Empty state
                if codeBlocksList.isEmpty {
                    Text("Move blocks to this space to compose your code!")
                        .foregroundStyle(.gray)
                    
                // Code blocks
                } else {
                    ForEach(codeBlocksList) { codeBlock in
                        switch codeBlock.type {
                            case .commandBlock:
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
                            case .ifBlock:
                                VStack(alignment: .leading, spacing: -8) {
                                    HStack(spacing: 16) {
                                        Text("if")
                                            .fontDesign(.monospaced)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white.opacity(0.5))
                                            .frame(width: 48, height: 32)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background {
                                        Color(hex: "FF79B3")
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    if codeBlock.inlineBlocks.isEmpty {
                                        HStack(spacing: 16) {
                                            Rectangle()
                                                .fill(Color(hex: "FF79B3"))
                                                .frame(width: 8, height: 80)
                                            
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.white.opacity(0.5))
                                                .frame(width: 48, height: 32)
                                            
                                        }
                                        
                                        
                                    } else {
                                        ForEach(codeBlock.inlineBlocks) { inlineBlock in
                                            HStack {
                                                Rectangle()
                                                    .fill(Color(hex: "FF79B3"))
                                                    .frame(width: 8)
                                                
                                                VStack {
                                                    
                                                }
                                            }
                                        }
                                    }

                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(hex: "FF79B3"))
                                        .frame(width: 48, height: 32)
                                    
                                }
                            case .forBlock:
                                VStack {
                                    
                                }
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
            // Divider
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(.white)
            
            // Code blocks gallery
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Image(systemName: "command")
                        Text("Commands")
                        
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    
                    ForEach(codeBlocksGallery) { codeBlock in
                        switch codeBlock.type {
                            case .commandBlock:
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
                                
                            case .ifBlock:
                                VStack(alignment: .leading, spacing: -8) {
                                    HStack(spacing: 16) {
                                        Text("if")
                                            .fontDesign(.monospaced)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white.opacity(0.5))
                                            .frame(width: 48, height: 32)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background {
                                        Color(hex: "FF79B3")
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    HStack(spacing: 16) {
                                        Rectangle()
                                            .fill(Color(hex: "FF79B3"))
                                            .frame(width: 8, height: 80)
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white.opacity(0.5))
                                            .frame(width: 48, height: 32)
                                        
                                    }

                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(hex: "FF79B3"))
                                        .frame(width: 48, height: 32)
                                    
                                }
                            case .forBlock:
                                VStack {
                                    
                                }
                        }
                    }
                }
                
                .padding()
            }
            
        }
        .background(Color(hex: "292A2F"))
    }
}

#Preview {
    CodeEditorView()
}
