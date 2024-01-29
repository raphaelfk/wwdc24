//
//  SecondLevelView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 16/01/24.
//

import SwiftUI
import SceneKit

struct SecondLevelView: View {
    @State var codeBlocksList: [CodeBlock] = []
    @Environment (\.colorScheme) var colorScheme
    @EnvironmentObject var gameManager: GameManager
    @State var isCodeEditorExpanded = false
    @State var isIntroductionExpanded = false
    @State var isSceneExpanded = false
    @State var loadingLevel = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var runningScene = false
    var sceneManager = SceneManager(sceneName: "SecondLevelScene.scn", cameraName: "camera")
    @State var sceneReady = false
    @State var showCodeEditor = true
    @State var showDescriptionSheet = false
    @State var showIntroduction = true
    @State var showLevelCompleteSheet = false
    @State var showLevelFailedSheet = false
    @State var showLevelWarningSheet = false
    @State var showScene = true
    
    var body: some View {
        if loadingLevel {
            LoaderView()
                .onAppear {
                    Task {
                        try await Task.sleep(nanoseconds: 1_750_000_000)
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
                            gameManager.playingFirstLevel = false
                        }
                    } label: {
                        Label("Back to Dashboard", systemImage: "chevron.left")
                            .padding(4)
                    }
                    
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
                            })
                            
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
                        CodeEditorView(codeBlocksList: $codeBlocksList, currentMission: 2, hasCodeBlocksLimit: true, isCodeEditorExpanded: $isCodeEditorExpanded, runningScene: $runningScene, showCodeEditor: $showCodeEditor, showIntroduction: $showIntroduction, showScene: $showScene)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.trailing, 8)
                    }
                    
                    // Scene view
                    if showScene {
                        ZStack {
                            SceneKitView(sceneManager: sceneManager)
                            
                            // overlays
                            VStack(spacing: 0) {
                                // top buttons
                                HStack {
                                    // Run Code Button
                                    Button(action: {
                                        runSecondLevelCode()
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
            .navigationTitle("First Mission")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showLevelCompleteSheet, content: {
                VStack(alignment: .center, spacing: 16) {
                    Spacer()
                    
                    Text("Congratulations!")
                        .font(.title)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                    
                    Text("Your code was sent and helped Ribbo overcome this challenge and continue his successful mission on Grass Planet!\n\nIt is by building code blocks like this that scientists send actual robots to explore other planets in our universe!")
                    
                    Spacer()
                    
                    Button(action: {
                        gameManager.secondLevelComplete = true
                        gameManager.thirdLevelAvailable = true
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Back to Dashboard")
                            .fontWeight(.semibold)
                            .fontDesign(.monospaced)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.gray.opacity(0.25))
                            }
                            .padding(.bottom, 32)
                    })
                    .buttonStyle(.plain)
                }
                .padding(32)
            })
        }
        
    }
    
    func runSecondLevelCode() {
        withAnimation(.spring) {
            runningScene = true
        }
        
        if let ribboNode = sceneManager.scene.rootNode.childNode(withName: "ribbo", recursively: true) {

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
                
                // iterating over each code block placed on the code editor
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
                                    await ribboNode.runAction(moveFront)
                                } else if ribboDirection == 1 {
                                    await ribboNode.runAction(moveLeft)
                                } else if ribboDirection == 2 {
                                    await ribboNode.runAction(moveBack)
                                } else if ribboDirection == -1 {
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
                    } else { // if it is a for loop block

                        // iterating for the defined number of times
                        for _ in 0 ..< (Int(codeBlock.command ?? "0") ?? 0) {
                            
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
                                            await ribboNode.runAction(moveFront)
                                        } else if ribboDirection == 1 {
                                            await ribboNode.runAction(moveLeft)
                                        } else if ribboDirection == 2 {
                                            await ribboNode.runAction(moveBack)
                                        } else if ribboDirection == -1 {
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
                                try await Task.sleep(nanoseconds: 500_000)
                            }
                            
                        }
                    }
                    
                    // wait between running commands
                    try await Task.sleep(nanoseconds: 500_000)
                    
                    // checking for allowed ribbo coordinates (to see if the code failed)
                    if ribboNode.position.z <= -1.2 {
                        withAnimation(.spring) {
                            showLevelFailedSheet = true
                        }
                        break
                    }
                    // if its left to ribbo's starting position
                    if ribboNode.position.z >= 1.2 {
                        withAnimation(.spring) {
                            showLevelFailedSheet = true
                        }
                        break
                    }
                    
                    if ribboNode.position.x  <= -11 { // if ribbo moves to front more than first bridge
                        if ribboNode.position.z >= 1.4 {
                            withAnimation(.spring) {
                                showLevelFailedSheet = true
                            }
                            break
                        }
                    } else if ribboNode.position.x  < -3.2 {
                        if ribboNode.position.z < 1.2 {
                            withAnimation(.spring) {
                                showLevelFailedSheet = true
                            }
                            break
                        }
                    }
                }
                
                for int in 0 ..< codeBlocksList.count {
                    codeBlocksList[int].highlighted = false
                }
                
                if ribboNode.position.x <= -14.3 {
                    showLevelCompleteSheet = true
                } else {
                    withAnimation(.spring) {
                        if !showLevelFailedSheet {
                            showLevelWarningSheet = true
                        }
                        
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

//#Preview {
//    FirstLevelView()
//}
