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
    var highlighted: Bool
    var inlineBlocks: [CodeBlock] = []
    let type: CodeBlockType
}

enum CodeBlockType: Equatable {
    case commandBlock
    case forBlock
    case ifBlock
}

struct CodeEditorView: View {
    var codeBlocksLimit: Int = 10
    @Binding var codeBlocksList: [CodeBlock]
    var commandBlocksGallery: [CodeBlock] = [CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock), CodeBlock(command: "rotateLeft()", highlighted: false, type: .commandBlock), CodeBlock(command: "rotateRight()", highlighted: false, type: .commandBlock)]
    var currentMission: Int
    var hasCodeBlocksLimit = false
    @Binding var isCodeEditorExpanded: Bool
    @Binding var runningScene: Bool
    @State var selectedBlock: UUID?
    @Binding var showCodeEditor: Bool
    @Binding var showIntroduction: Bool
    @Binding var showScene: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top bar
            HStack(alignment: .center) {
                Image(systemName: "chevron.left.forwardslash.chevron.right")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text("Code")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button {
                    withAnimation(.spring) {
                        // if the code editor is already expanded, reduce it
                        if isCodeEditorExpanded {
                            showCodeEditor = true
                            showIntroduction = true
                            showScene = true
                            isCodeEditorExpanded = false
                        
                        // if the code editor is not expanded, expand it
                        } else {
                            isCodeEditorExpanded = true
                            showIntroduction = false
                            showScene = false
                            showCodeEditor = true
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: isCodeEditorExpanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                    }
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.gray.opacity(0.25))
                    }
                }
                .buttonStyle(.plain)

                
            }
            .padding(.leading)
            .padding(.vertical, 8)
            .padding(.trailing, 8)
            
            // Divider
            Rectangle()
                .frame(height: 0.35)
                .foregroundStyle(.white)
            
            // Code
            ZStack(alignment: .top) {
                 ScrollView {
                    // code editor
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            // Empty state
                            if codeBlocksList.isEmpty {
                                Text("Click on blocks to compose your code!")
                                    .foregroundStyle(.gray)
                                
                                // Code blocks
                            } else {
                                ForEach(codeBlocksList) { codeBlock in
                                    switch codeBlock.type {
                                        case .commandBlock:
                                            HStack(alignment: .center) {
                                                Text(codeBlock.command ?? "Error")
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
                                                Color(hex: codeBlock.highlighted ? "BFAD5A" : "78C1B3")
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .onTapGesture {
                                                // go through list and delete the tapped code block
                                                if !runningScene {
                                                    withAnimation(.interactiveSpring) {
                                                        var index = 0
                                                        for codeBlockSearched in codeBlocksList {
                                                            if codeBlockSearched.id == codeBlock.id {
                                                                codeBlocksList.remove(at: index)
                                                                break
                                                            }
                                                            index += 1
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        case .ifBlock:
                                            VStack(alignment: .leading, spacing: 0) {
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
                                            ForBlockView(codeBlock: codeBlock, codeBlocksList: $codeBlocksList, runningScene: $runningScene, selectedBlock: $selectedBlock)
                                    }
                                    
                                }
                                
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
                
                // blocks limit (for second and third levels
                if hasCodeBlocksLimit {
                    HStack {
                        Spacer()
                        
                        Text("Blocks Limit: \(codeBlocksList.count) / \(codeBlocksLimit)")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                            .background {
                                // no more code blocks allowed
                                if codeBlocksList.count == codeBlocksLimit {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(hex: "F57F71").opacity(0.9))
                                    
                                    // almost out of code blocks
                                } else if codeBlocksList.count >= codeBlocksLimit - 3 {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(hex: "F7A03A").opacity(0.9))
                                    
                                    // still plenty of blocks to use
                                } else {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.gray.opacity(0.9))
                                }
                                
                            }
                            .padding()
                    }
                }
                
                
            }
            
            if !runningScene {
                // Divider
                Rectangle()
                    .frame(height: 0.35)
                    .foregroundStyle(.white)
                
                // Code blocks gallery
                HStack {
                    // if the user can place more code blocks
                    if codeBlocksList.count < codeBlocksLimit || !hasCodeBlocksLimit {
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
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring) {
                                            // going through list to see if any blocks that accept inline commands are selected
                                            if selectedBlock != nil {
                                                var listIndex = 0
                                                for block in self.codeBlocksList {
                                                    if block.id == self.selectedBlock {
                                                        break
                                                    }
                                                    listIndex += 1
                                                }
                                                
                                                self.codeBlocksList[listIndex].inlineBlocks.append(CodeBlock(command: codeBlock.command, highlighted: false, type: .commandBlock))
                                            } else {
                                                self.codeBlocksList.append(CodeBlock(command: codeBlock.command, highlighted: false, type: .commandBlock))
                                            }
                                        }
                                    }
                                    .draggable(codeBlock.command ?? "")
                            }
                        }
                        
                        // for loop
                        if currentMission > 1 && selectedBlock == nil {
                            VStack(alignment: .leading) {
                                // section title
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                    Text("For Loops")
                                    
                                    Spacer()
                                }
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                
                                // for block
                                VStack(alignment: .leading, spacing: -8) {
                                    HStack(spacing: 16) {
                                        Text("for")
                                            .fontDesign(.monospaced)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white.opacity(0.5))
                                            .frame(width: 36, height: 28)
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
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(hex: "FF79B3"))
                                        .frame(width: 32, height: 16)
                                    
                                }
                            }
                            .onTapGesture {
                                withAnimation(.interactiveSpring) {
                                    self.codeBlocksList.append(CodeBlock(highlighted: false, type: .forBlock))
                                }
                            }
                            .draggable("forLoop")
                        }
                        
                        // if statements
                        if currentMission > 2 && selectedBlock == nil {
                            VStack(alignment: .leading) {
                                // section title
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.triangle.branch")
                                    Text("If Statements")
                                    
                                    Spacer()
                                }
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                
                                // if block
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
                            }
                            .draggable("ifStatement")
                        }
                        
                    // no code blocks left
                    } else {
                        Text("You have reached the limit of code blocks we can send to Ribbo. Try refactoring your code using For Loops!")
                            .foregroundStyle(.white)
                            .padding(.vertical)
                        
                        Spacer()
                    }
                }
                .padding()
                .background {
                    Color(.white).opacity(0.1)
                }
            }
            
        }
        .background(Color(hex: "292A2F"))
        .onTapGesture {
            withAnimation(.spring) {
                self.selectedBlock = nil
            }
        }
    }
}

//#Preview {
//    CodeEditorView()
//}
