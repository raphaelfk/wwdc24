//
//  ThirdLevelView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 30/01/24.
//

import SwiftUI
import SceneKit

struct ThirdLevelView: View {
    @State var codeBlocksList: [CodeBlock] = []
    @Environment (\.colorScheme) var colorScheme
    @State var currentMap: [[String]] = [[]]
    @EnvironmentObject var gameManager: GameManager
    @State var isCodeEditorExpanded = false
    @State var isIntroductionExpanded = false
    @State var isSceneExpanded = false
    @State var loadingLevel = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var runningScene = false
    var sceneManager = SceneManager(sceneName: "ThirdLevelScene.scn", cameraName: "camera")
    @State var sceneReady = true
    @State var showCodeEditor = true
    @State var showDescriptionSheet = false
    @State var showIntroduction = true
    @State var showLevelCompleteSheet = false
    @State var showLevelFailedSheet = false
    @State var showLevelWarningSheet = false
    @State var showScene = true
    
    let maps = [
        // map 0
        [
            ["x", "y", "p", "g", "p", "g", "y", "g", "b", "y"],
            ["x", "g", "b", "y", "b", "y", "r", "p", "y", "b"],
            ["x", "p", "g", "r", "p", "g", "y", "g", "r", "y"],
            ["x", "x", "x", "b", "y", "b", "p", "x", "x", "x"],
            ["b", "b", "y", "x", "x", "x", "x", "y", "b", "b"],
            ["x", "x", "b", "x", "y", "b", "b", "p", "x", "x"],
            ["x", "x", "p", "b", "p", "x", "x", "x", "r", "r"],
            ["x", "b", "x", "x", "x", "x", "g", "r", "g", "y"],
            ["x", "p", "y", "r", "g", "r", "b", "p", "y", "b"],
            ["x", "g", "p", "b", "y", "p", "y", "g", "b", "p"]
        ],
        
        // map 1
        [
            ["x", "y", "p", "g", "p", "g", "y", "g", "b", "y"],
            ["x", "g", "x", "x", "x", "x", "x", "p", "y", "b"],
            ["x", "x", "y", "b", "b", "b", "y", "x", "x", "x"],
            ["x", "x", "b", "x", "x", "x", "p", "b", "b", "b"],
            ["b", "b", "p", "x", "r", "p", "x", "x", "x", "x"],
            ["x", "x", "x", "r", "y", "b", "b", "p", "g", "p"],
            ["x", "b", "p", "y", "p", "b", "r", "p", "r", "r"],
            ["x", "b", "p", "g", "b", "y", "g", "r", "g", "y"],
            ["x", "p", "y", "r", "g", "r", "b", "p", "y", "b"],
            ["x", "g", "p", "b", "y", "p", "y", "g", "b", "p"]
        ],
        
        // map 2
        [
            ["x", "y", "p", "g", "p", "g", "y", "g", "b", "y"],
            ["x", "g", "b", "y", "b", "y", "r", "p", "y", "b"],
            ["x", "p", "g", "r", "p", "g", "y", "g", "r", "y"],
            ["x", "x", "x", "b", "y", "b", "p", "b", "g", "p"],
            ["b", "b", "y", "x", "x", "x", "y", "r", "y", "b"],
            ["x", "x", "p", "b", "b", "y", "x", "p", "g", "p"],
            ["x", "b", "x", "x", "x", "b", "x", "x", "x", "x"],
            ["x", "b", "p", "g", "x", "p", "b", "b", "b", "b"],
            ["x", "p", "y", "r", "g", "x", "x", "x", "x", "x"],
            ["x", "g", "p", "b", "y", "p", "y", "g", "b", "p"]
        ]
    ]
    
    let randomTiles = [
        [  ["x", "y", "p", "r", "p", "g", "y", "g", "b", "y"],
           ["x", "g", "b", "y", "b", "y", "r", "p", "y", "b"],
           ["x", "p", "g", "r", "p", "g", "y", "g", "r", "y"],
           ["x", "y", "p", "b", "y", "b", "p", "b", "g", "p"],
           ["b", "b", "y", "p", "r", "p", "y", "r", "y", "b"],
           ["x", "r", "b", "r", "y", "b", "b", "p", "g", "p"],
           ["x", "b", "p", "y", "p", "b", "r", "p", "r", "r"],
           ["x", "b", "p", "g", "b", "y", "g", "r", "g", "y"],
           ["x", "p", "y", "r", "g", "r", "b", "p", "y", "b"],
           ["x", "g", "p", "b", "y", "p", "y", "g", "b", "p"]
        ],
        
        [  ["x", "y", "p", "g", "p", "g", "y", "g", "b", "y"],
           ["x", "g", "b", "y", "b", "y", "r", "p", "y", "b"],
           ["x", "p", "g", "r", "p", "g", "y", "g", "r", "y"],
           ["x", "y", "p", "b", "y", "b", "p", "b", "g", "p"],
           ["b", "b", "y", "p", "r", "p", "y", "r", "y", "b"],
           ["x", "r", "b", "r", "y", "b", "b", "p", "g", "p"],
           ["x", "b", "p", "y", "p", "b", "r", "p", "r", "r"],
           ["x", "b", "p", "g", "b", "y", "g", "r", "g", "y"],
           ["x", "p", "y", "r", "g", "r", "b", "p", "y", "b"],
           ["x", "g", "p", "b", "y", "p", "y", "g", "b", "p"]
        ],
        
        [  ["x", "y", "p", "g", "p", "g", "y", "g", "b", "y"],
           ["x", "g", "b", "y", "b", "y", "r", "p", "y", "b"],
           ["x", "p", "g", "r", "p", "g", "y", "g", "r", "y"],
           ["x", "y", "p", "b", "y", "b", "p", "b", "g", "p"],
           ["b", "b", "y", "p", "r", "p", "y", "r", "y", "b"],
           ["x", "r", "b", "r", "y", "b", "b", "p", "g", "p"],
           ["x", "b", "p", "y", "p", "b", "r", "p", "r", "r"],
           ["x", "b", "p", "g", "b", "y", "g", "r", "g", "y"],
           ["x", "p", "y", "r", "g", "r", "b", "p", "y", "b"],
           ["x", "g", "p", "b", "y", "p", "y", "g", "b", "p"]
        ]
    ]
    
    let mapWithNothing = [
        ["x", "y", "p", "g", "p", "g", "y", "g", "b", "y"],
        ["x", "g", "b", "y", "b", "y", "r", "p", "y", "b"],
        ["x", "p", "g", "r", "p", "g", "y", "g", "r", "y"],
        ["x", "y", "p", "b", "y", "b", "p", "b", "g", "p"],
        ["b", "b", "y", "p", "r", "p", "y", "r", "y", "b"],
        ["x", "r", "b", "r", "y", "b", "b", "p", "g", "p"],
        ["x", "b", "p", "y", "p", "b", "r", "p", "r", "r"],
        ["x", "b", "p", "g", "b", "y", "g", "r", "g", "y"],
        ["x", "p", "y", "r", "g", "r", "b", "p", "y", "b"],
        ["x", "g", "p", "b", "y", "p", "y", "g", "b", "p"]
    ]
    
    var body: some View {
        if loadingLevel {
            LoaderView()
                .onAppear {
                    Task {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            loadingLevel = false
                        }
                        
                        try await Task.sleep(nanoseconds: 3_750_000_000)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            sceneReady = true
                        }
                        
                    }
                }
        } else {
            VStack(spacing: 16) {
                // back to dashboard button
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            gameManager.playingThirdLevel = false
                        }
                    } label: {
                        Label("Back to Dashboard", systemImage: "chevron.left")
                            .padding(4)
                            .foregroundStyle(Color(hex: "A861D4"))
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                }
                
                // description
                if showIntroduction {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Mission Description")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        
                        Text("Ribbo is on Castle Planet, but this one is too far away from Earth, so we can send at max 10 command blocks to it.\nWith that in mind, we provided a \"for\" block to your coding interface. The for block repeats all of the commands inside of it a defined number of times. We think this might help you create a concise algorithm for Ribbo to follow!")
                            .foregroundStyle(.gray)
                            .lineLimit(3)
                        
                        HStack {
                            Button(action: {
                                showDescriptionSheet = true
                            }, label: {
                                Text("Read More...")
                                    .foregroundStyle(Color(hex: "A861D4"))
                            })
                            .buttonStyle(.plain)
                            
                            Spacer()
                        }
                        
                    }
                    .padding()
                    .background(colorScheme == .light ? .white : Color(hex: "212121"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .sheet(isPresented: $showDescriptionSheet, content: {
                        SecondLevelDescriptionView(descriptionVisibility: $showDescriptionSheet)
                    })
                }
                
                
                HStack {
                    // Code editor
                    if showCodeEditor {
                        CodeEditorView(codeBlocksList: $codeBlocksList, currentMission: 3, hasCodeBlocksLimit: true, isCodeEditorExpanded: $isCodeEditorExpanded, runningScene: $runningScene, showCodeEditor: $showCodeEditor, showIntroduction: $showIntroduction, showScene: $showScene)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.trailing, 8)
                    }
                    
                    // Scene view
                    if showScene {
                        ZStack {
                            SceneKitView(sceneManager: sceneManager)
                                .onAppear {
                                    Task {
                                        try await Task.sleep(nanoseconds: 1_500_000_000)
                                        setupScene()
                                    }
                                }
                            
                            // overlays
                            VStack(spacing: 0) {
                                // top buttons
                                HStack {
                                    // Run Code Button
                                    Button(action: {
                                        runThirdLevelCode()
                                    }, label: {
                                        HStack(spacing: 8) {
                                            if runningScene {
                                                Text("Runing")
                                                ProgressView()
                                            } else {
                                                Text("Run Code")
                                                Image(systemName: "play.fill")
                                            }
                                        }
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 12)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(.gray.opacity(0.5))
                                        }
                                    })
                                    .buttonStyle(.plain)
                                    .disabled(runningScene)
                                    .padding()
                                    
                                    Spacer()
                                    
                                    // Expand Scene Button
                                    Button(action: {
                                        withAnimation(.spring) {
                                            // if the scene is already expanded, reduce it
                                            if isSceneExpanded {
                                                showIntroduction = true
                                                showCodeEditor = true
                                                isSceneExpanded = false
                                                // if scene is not expanded, expand it
                                            } else {
                                                showIntroduction = false
                                                showCodeEditor = false
                                                isSceneExpanded = true
                                            }
                                        }
                                    }, label: {
                                        HStack(spacing: 8) {
                                            Image(systemName: isSceneExpanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                                        }
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 12)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(.gray.opacity(0.5))
                                        }
                                    })
                                    .buttonStyle(.plain)
                                    .padding()
                                }
                                
                                // warnings
                                if showLevelWarningSheet{
                                    // not reach goal destination warning
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack(spacing: 4) {
                                            Image(systemName: "exclamationmark.triangle.fill")
                                            Text("Look Out!")
                                            
                                            Spacer()
                                            
                                            Button {
                                                withAnimation(.interactiveSpring) {
                                                    showLevelWarningSheet = false
                                                }
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundStyle(.white.opacity(0.5))
                                            }
                                            .buttonStyle(.plain)
                                            
                                        }
                                        .fontWeight(.semibold)
                                        
                                        Text("It looks like Ribbo did not achieve his final destination.\nTry making a single algorithm which leads it to the green spot in a single run.")
                                            .multilineTextAlignment(.leading)
                                            .font(.subheadline)
                                    }
                                    .foregroundStyle(.white)
                                    .padding(12)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(hex: "F7A03A").opacity(0.9))
                                    }
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring) {
                                            showLevelWarningSheet = false
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                } else if showLevelFailedSheet {
                                    // fail warning
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack(spacing: 4) {
                                            Image(systemName: "xmark.square.fill")
                                            Text("Oh no!")
                                            
                                            Spacer()
                                            
                                            Button {
                                                withAnimation(.interactiveSpring) {
                                                    showLevelFailedSheet = false
                                                }
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundStyle(.white.opacity(0.5))
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        .fontWeight(.semibold)
                                        
                                        Text("It looks like your code did not pass our test's safety requirements for Ribbo! But don’t worry, this is just a simulator, so Ribbo is fine!\nIf you need any help you can read the entire mission description by clicking on ”Read More...”.")
                                            .multilineTextAlignment(.leading)
                                            .font(.subheadline)
                                    }
                                    .foregroundStyle(.white)
                                    .padding(12)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(hex: "F57F71").opacity(0.9))
                                    }
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring) {
                                            showLevelFailedSheet = false
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                
                                Spacer()
                            }
                            
                            if !sceneReady {
                                Rectangle()
                                    .fill(.thinMaterial)
                                
                                ProgressView()
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.leading, 8)
                    }
                    
                }
            }
            .padding()
            .background(Color(hex: colorScheme == .light ? "F2F1F6" : "131313").ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showLevelCompleteSheet, content: {
                ThirdLvlCongratulationSheetView(sheetVisibility: $showLevelCompleteSheet)
            })
        }
    }
    
    func setupScene() {
        let previousMap = currentMap
        
        currentMap = maps[Int.random(in: 0...2)]
        
        
        // changing colors
        
        // setting up map
        for line in 0...9 {
            for column in 0...9 {
                if let tileNode = sceneManager.scene.rootNode.childNode(withName: "Tile\(line)\(column)", recursively: true) {
                    if tileNode.position.y > 0 {
                        let moveDown = SCNAction.moveBy(x: 0, y: -0.7, z: 0, duration: 0.5)
                        tileNode.runAction(moveDown)
                    }

                    let moveUp = SCNAction.moveBy(x: 0, y: +0.7, z: 0, duration: 0.5)
                    switch currentMap[line][column] {
                        case "b":
                            // tileNode.geometry?.firstMaterial?.diffuse.contents = Color(hex: "5F79D4")
                            tileNode.geometry?.materials.append((tileNode.geometry?.firstMaterial!)!)
                            tileNode.geometry?.replaceMaterial(at: 0, with: (tileNode.geometry?.material(named: "blueTile"))!)
                            
                        case "g":
                            tileNode.geometry?.materials.append((tileNode.geometry?.firstMaterial!)!)
                            tileNode.geometry?.replaceMaterial(at: 0, with: (tileNode.geometry?.material(named: "greenTile"))!)
                        case "p":
                            tileNode.geometry?.materials.append((tileNode.geometry?.firstMaterial!)!)
                            tileNode.geometry?.replaceMaterial(at: 0, with: (tileNode.geometry?.material(named: "pinkTile"))!)
                        case "r":
                            tileNode.geometry?.materials.append((tileNode.geometry?.firstMaterial!)!)
                            tileNode.geometry?.replaceMaterial(at: 0, with: (tileNode.geometry?.material(named: "redTile"))!)
                        case "x":
                            tileNode.geometry?.materials.append((tileNode.geometry?.firstMaterial!)!)
                            tileNode.geometry?.replaceMaterial(at: 0, with: (tileNode.geometry?.material(named: "barrier"))!)
                            tileNode.runAction(moveUp)
                        case "y":
                            tileNode.geometry?.materials.append((tileNode.geometry?.firstMaterial!)!)
                            tileNode.geometry?.replaceMaterial(at: 0, with: (tileNode.geometry?.material(named: "yellowTile"))!)
                        default:
                            tileNode.geometry?.materials.append((tileNode.geometry?.firstMaterial!)!)
                            tileNode.geometry?.replaceMaterial(at: 0, with: (tileNode.geometry?.material(named: "blueTile"))!)
                    }
                }
            }
        }
    }
    
    func runThirdLevelCode() {
        withAnimation(.spring) {
            runningScene = true
            showLevelWarningSheet = false
            showLevelFailedSheet = false
        }
        
        
        
        if let ribboNode = sceneManager.scene.rootNode.childNode(withName: "ribbo", recursively: true) {
            var ribboMatrixColPosition = 0
            var ribboMatrixRowPosition = 4
            
            // move actions
            let moveFront = SCNAction.moveBy(x: -1.3, y: 0, z: 0, duration: 1)
            let moveBack = SCNAction.moveBy(x: 1.3, y: 0, z: 0, duration: 1)
            let moveLeft = SCNAction.moveBy(x: 0, y: 0, z: 1.3, duration: 1)
            let moveRight = SCNAction.moveBy(x: 0, y: 0, z: -1.3, duration: 1)
            
            // running code on ribbo
            Task {
                // placing ribbo on its starting position
                ribboNode.position.x = 0
                ribboNode.position.z = 0
                ribboNode.eulerAngles.x = 0
                ribboNode.eulerAngles.y = 0
                ribboNode.eulerAngles.z = 0
                
                var ribboDirection = 0 // 0 forward, 1 left, -1 right, 2 back (considering start position)
                var currentAngle: Float = 0
                
                setupScene()
                
                await ribboNode.runAction(moveFront)
                
                // iterating over each code block placed on the code editor
                while ribboMatrixColPosition < 10 && !showLevelFailedSheet && !showLevelWarningSheet { // run the code blocks while Ribbo is not on the green tiles or until it dies or stops
                    
                    // storing startPosition to see if any commands are being run. if not, Ribbo is stuck and the code should stop running
                    let whileRibboStartPosition = (ribboMatrixRowPosition, ribboMatrixColPosition)
                    
                    for codeBlock in codeBlocksList {
                        // highlighting the current running blocks
                        var listIndex = 0
                        var currentBlockIndex = 0
                        for codeBlockFromList in codeBlocksList {
                            if codeBlockFromList.id == codeBlock.id {
                                codeBlocksList[listIndex].highlighted = true
                                currentBlockIndex = listIndex
                            } else {
                                codeBlocksList[listIndex].highlighted = false
                            }
                            listIndex += 1
                        }
                        
                        // running the blocks
                        if codeBlock.type == .commandBlock {
                            switch codeBlock.command {
                                case "moveForward()":
                                    if ribboDirection == 0 {
                                        ribboMatrixColPosition += 1
                                        await ribboNode.runAction(moveFront)
                                    } else if ribboDirection == 1 {
                                        ribboMatrixRowPosition -= 1
                                        await ribboNode.runAction(moveLeft)
                                    } else if ribboDirection == 2 {
                                        ribboMatrixColPosition -= 1
                                        await ribboNode.runAction(moveBack)
                                    } else if ribboDirection == -1 {
                                        ribboMatrixRowPosition += 1
                                        await ribboNode.runAction(moveRight)
                                    }
                                    
                                    
                                case "rotateLeft()":
                                    await ribboNode.runAction(SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: (currentAngle + 1.57)), duration: 1))
                                    currentAngle += 1.57
                                    
                                    // facing forward, turn left
                                    if ribboDirection == 0 {
                                        ribboDirection += 1
                                        
                                        // facing left, turn back
                                    } else if ribboDirection == 1 {
                                        ribboDirection += 1
                                        
                                        // facing back, turn right
                                    } else if ribboDirection == 2 {
                                        ribboDirection = -1
                                        
                                        // facing right, turn forward
                                    } else if ribboDirection == -1 {
                                        ribboDirection += 1
                                    }
                                    
                                case "rotateRight()":
                                    await ribboNode.runAction(SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: (currentAngle - 1.57)), duration: 1))
                                    currentAngle -= 1.57
                                    
                                    // facing forward, turn to right
                                    if ribboDirection == 0 {
                                        ribboDirection -= 1
                                        
                                        // facing left, turn to front
                                    } else if ribboDirection == 1 {
                                        ribboDirection -= 1
                                        
                                        // facing back, turn to left
                                    } else if ribboDirection == 2 {
                                        ribboDirection = 1
                                        
                                        // facing right, turn to back
                                    } else if ribboDirection == -1 {
                                        ribboDirection = 2
                                    }
                                    
                                default:
                                    print("No command (\(codeBlock.command ?? "Error") found!")
                            }
                        } else { // if it is a if statement block
                            var runCodeBlockCommands = false
                            switch codeBlock.command {
                                case "isOnBlueTile":
                                    if currentMap[ribboMatrixRowPosition][ribboMatrixColPosition] == "b" {
                                        runCodeBlockCommands = true
                                    }
                                case "isOnPinkTile":
                                    if currentMap[ribboMatrixRowPosition][ribboMatrixColPosition] == "p" {
                                        runCodeBlockCommands = true
                                    }
                                case "isOnYellowTile":
                                    if currentMap[ribboMatrixRowPosition][ribboMatrixColPosition] == "y" {
                                        runCodeBlockCommands = true
                                    }
                                default:
                                    print("No condition identified for \(codeBlock.command ?? "")")
                            }
                            
                            // if the if statement is true, run the inline blocks
                            if runCodeBlockCommands {
                                // going through each inline block
                                for inlineBlock in codeBlocksList[currentBlockIndex].inlineBlocks {
                                    var inlineListIndex = 0
                                    
                                    // highlighting the current inline running blocks
                                    for codeBlockFromInlineList in codeBlocksList[inlineListIndex].inlineBlocks {
                                        if codeBlockFromInlineList.id == codeBlock.id {
                                            codeBlocksList[inlineListIndex].highlighted = true
                                        } else {
                                            codeBlocksList[inlineListIndex].highlighted = false
                                        }
                                        inlineListIndex += 1
                                    }
                                    
                                    // running the commands
                                    switch inlineBlock.command {
                                        case "moveForward()":
                                            if ribboDirection == 0 {
                                                ribboMatrixColPosition += 1
                                                await ribboNode.runAction(moveFront)
                                            } else if ribboDirection == 1 {
                                                ribboMatrixRowPosition -= 1
                                                await ribboNode.runAction(moveLeft)
                                            } else if ribboDirection == 2 {
                                                ribboMatrixColPosition -= 1
                                                await ribboNode.runAction(moveBack)
                                            } else if ribboDirection == -1 {
                                                ribboMatrixRowPosition += 1
                                                await ribboNode.runAction(moveRight)
                                            }
                                            
                                            
                                        case "rotateLeft()":
                                            await ribboNode.runAction(SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: (currentAngle + 1.57)), duration: 1))
                                            currentAngle += 1.57
                                            
                                            // facing forward, turn left
                                            if ribboDirection == 0 {
                                                ribboDirection += 1
                                                
                                                // facing left, turn back
                                            } else if ribboDirection == 1 {
                                                ribboDirection += 1
                                                
                                                // facing back, turn right
                                            } else if ribboDirection == 2 {
                                                ribboDirection = -1
                                                
                                                // facing right, turn forward
                                            } else if ribboDirection == -1 {
                                                ribboDirection += 1
                                            }
                                            
                                        case "rotateRight()":
                                            await ribboNode.runAction(SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: (currentAngle - 1.57)), duration: 1))
                                            currentAngle -= 1.57
                                            
                                            // facing forward, turn to right
                                            if ribboDirection == 0 {
                                                ribboDirection -= 1
                                                
                                                // facing left, turn to front
                                            } else if ribboDirection == 1 {
                                                ribboDirection -= 1
                                                
                                                // facing back, turn to left
                                            } else if ribboDirection == 2 {
                                                ribboDirection = 1
                                                
                                                // facing right, turn to back
                                            } else if ribboDirection == -1 {
                                                ribboDirection = 2
                                            }
                                            
                                        default:
                                            print("No command (\(inlineBlock.command ?? "Error") found!")
                                    }
                                    
                                    // wait between running commands
                                    try await Task.sleep(nanoseconds: 1_000_000)
                                    
                                    // checking for level completion
                                    if ribboMatrixColPosition >= currentMap[0].count {
                                        withAnimation(.spring) {
                                            showLevelCompleteSheet = true
                                            gameManager.thirdLevelComplete = true
                                            gameManager.allLevelsComplete = true
                                        }
                                        break
                                    }
                                    
                                    // checking for allowed ribbo coordinates (to see if the code failed)
                                    if ribboMatrixRowPosition >= currentMap.count || ribboMatrixRowPosition < 0 { // if its out of the map row wise
                                        withAnimation(.spring) {
                                            showLevelFailedSheet = true
                                        }
                                        break
                                    }
                                    
                                    if ribboMatrixColPosition < 0 { // if its out of the map column wise
                                        withAnimation(.spring) {
                                            showLevelFailedSheet = true
                                        }
                                        break
                                    }
                                    
                                    if currentMap[ribboMatrixRowPosition][ribboMatrixColPosition] == "x" { // if it hits a barrier
                                        withAnimation(.spring) {
                                            showLevelFailedSheet = true
                                        }
                                        break
                                    }
                                }
 
                            }
                            
                        }
                        
                        // wait between running commands
                        try await Task.sleep(nanoseconds: 500_000)
                        
                        // checking for level completion
                        if ribboMatrixColPosition >= currentMap[0].count {
                            withAnimation(.spring) {
                                showLevelCompleteSheet = true
                                gameManager.thirdLevelComplete = true
                                gameManager.allLevelsComplete = true
                            }
                            break
                        }
                        
                        // checking for allowed ribbo coordinates (to see if the code failed)
                        if ribboMatrixRowPosition >= currentMap.count || ribboMatrixRowPosition < 0 { // if its out of the map row wise
                            withAnimation(.spring) {
                                showLevelFailedSheet = true
                            }
                            break
                        }
                        
                        if ribboMatrixColPosition < 0 { // if its out of the map column wise
                            withAnimation(.spring) {
                                showLevelFailedSheet = true
                            }
                            break
                        }
                        
                        if currentMap[ribboMatrixRowPosition][ribboMatrixColPosition] == "x" { // if it hits a barrier
                            withAnimation(.spring) {
                                showLevelFailedSheet = true
                            }
                            break
                        }
                    }
                    
                    // if ribbo is stuck, stop code
                    if ribboMatrixRowPosition == whileRibboStartPosition.0 && ribboMatrixColPosition == whileRibboStartPosition.1 {
                        break
                    }
                }

                for int in 0 ..< codeBlocksList.count {
                    codeBlocksList[int].highlighted = false
                }
                
                if !showLevelCompleteSheet && !showLevelFailedSheet { // if ribbo did not die and did not win (stopped in the middle of the way)
                    withAnimation(.spring) {
                        showLevelWarningSheet = true
                        ribboNode.position.x = 0
                        ribboNode.position.z = 0
                        ribboNode.eulerAngles.x = 0
                        ribboNode.eulerAngles.y = 0
                        ribboNode.eulerAngles.z = 0
                    }
                }
                
                runningScene = false
            }
        }
    }
}
