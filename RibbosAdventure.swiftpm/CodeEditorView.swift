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
    var explanation: String?
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
    @State var codeBlocksCount = 0
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
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "chevron.left.forwardslash.chevron.right")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text("Code")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                // show solution button
                Button {
                    withAnimation(.spring) {
                        if currentMission == 1 {
                            codeBlocksList = [
                                CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "rotateLeft()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "rotateRight()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock)
                            ]
                        } else if currentMission == 2 {
                            codeBlocksList = [
                                CodeBlock(command: "8", highlighted: false, inlineBlocks: [CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock)], type: .forBlock),
                                CodeBlock(command: "rotateRight()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "4", highlighted: false, inlineBlocks: [CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock)], type: .forBlock),
                                CodeBlock(command: "rotateLeft()", highlighted: false, type: .commandBlock),
                                CodeBlock(command: "4", highlighted: false, inlineBlocks: [CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock)], type: .forBlock)
                            ]
                        } else {
                            codeBlocksList = [
                                CodeBlock(command: "isOnBlueTile", highlighted: false, inlineBlocks: [CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock)], type: .ifBlock),
                                CodeBlock(command: "isOnPinkTile", highlighted: false, inlineBlocks: [CodeBlock(command: "rotateLeft()", highlighted: false, type: .commandBlock), CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock)], type: .ifBlock),
                                CodeBlock(command: "isOnYellowTile", highlighted: false, inlineBlocks: [CodeBlock(command: "rotateRight()", highlighted: false, type: .commandBlock), CodeBlock(command: "moveForward()", highlighted: false, type: .commandBlock)], type: .ifBlock)
                            ]
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text("Show Solution")
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
                            if codeBlocksList.isEmpty && currentMission != 3 {
                                Text("Click on the command blocks below to compose your code!")
                                    .foregroundStyle(.gray)
                                
                            // Code blocks
                            } else {
                                if currentMission == 3 {
                                    // static move forward command
                                    HStack(alignment: .center) {
                                        Text("moveForward()")
                                            .fontDesign(.monospaced)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background {
                                        Color(hex: "7E8C98")
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    // while block
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 16) {
                                            Text("while")
                                                .fontDesign(.monospaced)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)
                                            
                                            // condition
                                            Text("isNotOnGreenTile")
                                                .foregroundStyle(.white)
                                                .multilineTextAlignment(.center)
                                                .keyboardType(.numberPad)
                                                .frame(height: 28)
                                                .padding(.horizontal, 8)
                                                .background {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(.white.opacity(0.5))
                                                        .frame(height: 28)
                                                }
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background {
                                            Color(hex: "7E8C98")
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
                                            if codeBlocksList.isEmpty {
                                                HStack(spacing: 16) {
                                                    Rectangle()
                                                        .fill(Color(hex: "7E8C98"))
                                                        .frame(width: 8, height: 80)
                                                    
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color(hex: "BFAD5A"))
                                                        .frame(width: 48, height: 32)
                                                }
                                                
                                            } else {
                                                HStack {
                                                    // left rectangle
                                                    Rectangle()
                                                        .fill(Color(hex: "7E8C98"))
                                                        .frame(width: 8)
                                                    
                                                    // code blocks
                                                    VStack(alignment: .leading) {
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
                                                                            
                                                                            updateCodeBlocksCount()
                                                                        }
                                                                        
                                                                    }
                                                                case .ifBlock:
                                                                    IfBlockView(codeBlock: codeBlock, codeBlocksList: $codeBlocksList, runningScene: $runningScene, selectedBlock: $selectedBlock)
                                                                    
                                                                case .forBlock:
                                                                    ForBlockView(codeBlock: codeBlock, codeBlocksList: $codeBlocksList, runningScene: $runningScene, selectedBlock: $selectedBlock)
                                                            }
                                                            
                                                        }
                                                        
                                                        if selectedBlock == nil {
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .fill(Color(hex: "BFAD5A"))
                                                                .frame(width: 48, height: 32)
                                                        } else {
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .fill(.white.opacity(0.5))
                                                                .frame(width: 48, height: 32)
                                                                .onTapGesture {
                                                                    selectedBlock = nil
                                                                }
                                                        }
                                                    }
                                                    .padding(.vertical, 12)
                                                }
                                            }
                                        }
                                        
                                        
                                        // while end rectangle
                                        Rectangle()
                                            .fill(Color(hex: "7E8C98"))
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
                                                        
                                                        updateCodeBlocksCount()
                                                    }
                                                    
                                                }
                                            case .ifBlock:
                                                IfBlockView(codeBlock: codeBlock, codeBlocksList: $codeBlocksList, runningScene: $runningScene, selectedBlock: $selectedBlock)
                                                
                                            case .forBlock:
                                                ForBlockView(codeBlock: codeBlock, codeBlocksList: $codeBlocksList, runningScene: $runningScene, selectedBlock: $selectedBlock)
                                        }
                                        
                                    }
                                    
                                    // add command block indicator
                                    if !runningScene {
                                        if selectedBlock == nil {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(hex: "BFAD5A"))
                                                .frame(width: 48, height: 32)
                                        } else {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.white.opacity(0.5))
                                                .frame(width: 48, height: 32)
                                                .onTapGesture {
                                                    selectedBlock = nil
                                                }
                                        }
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
                        
                        Text("Blocks Limit: \(codeBlocksCount) / \(codeBlocksLimit)")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                            .background {
                                // no more code blocks allowed
                                if codeBlocksCount == codeBlocksLimit {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(hex: "F57F71").opacity(0.9))
                                    
                                    // almost out of code blocks
                                } else if codeBlocksCount >= codeBlocksLimit - 3 {
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
                    if codeBlocksCount < codeBlocksLimit || !hasCodeBlocksLimit {
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
                                                if hasCodeBlocksLimit {
                                                    if codeBlocksCount < codeBlocksLimit {
                                                        self.codeBlocksList.append(CodeBlock(command: codeBlock.command, highlighted: false, type: .commandBlock))
                                                    }
                                                } else {
                                                    self.codeBlocksList.append(CodeBlock(command: codeBlock.command, highlighted: false, type: .commandBlock))
                                                }
                                                
                                            }
                                        }
                                        
                                        updateCodeBlocksCount()
                                    }
                            }
                        }
                        
                        // for loop
                        if currentMission == 2 && selectedBlock == nil {
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
                                updateCodeBlocksCount()
                            }
                        }
                        
                        // if statements
                        if currentMission == 3 && selectedBlock == nil {
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
                                            .frame(width: 36, height: 28)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background {
                                        Color(hex: "906EBC")
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    HStack(spacing: 16) {
                                        Rectangle()
                                            .fill(Color(hex: "906EBC"))
                                            .frame(width: 8, height: 80)
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white.opacity(0.5))
                                            .frame(width: 48, height: 32)
                                        
                                    }
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(hex: "906EBC"))
                                        .frame(width: 32, height: 16)
                                    
                                }
                            }
                            .onTapGesture {
                                withAnimation(.interactiveSpring) {
                                    self.codeBlocksList.append(CodeBlock(highlighted: false, type: .ifBlock))
                                }
                                updateCodeBlocksCount()
                            }
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

//#Preview {
//    CodeEditorView()
//}
