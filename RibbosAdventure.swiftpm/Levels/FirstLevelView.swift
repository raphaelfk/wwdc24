//
//  FirstLevelView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 16/01/24.
//

import SwiftUI
import SceneKit

struct FirstLevelView: View {
    var cameraNode: SCNNode? {
        scene?.rootNode.childNode(withName: "camera", recursively: false)
    }
    @State var codeBlocksList: [CodeBlock] = []
    @Environment (\.colorScheme) var colorScheme
    @EnvironmentObject var gameManager: GameManager
    @State var isCodeEditorExpanded = false
    @State var isIntroductionExpanded = false
    @State var isSceneExpanded = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var runningScene = false
    var scene = SCNScene(named: "FirstLevelScene.scn")
    @State var showCodeEditor = true
    @State var showDescriptionSheet = false
    @State var showIntroduction = true
    @State var showLevelCompleteSheet = false
    @State var showLevelFailedSheet = false
    @State var showScene = true
    
    
    @State var loadingLevel = true

    var body: some View {
        if loadingLevel {
            LoaderView()
                .onAppear {
                    Task {
                        try await Task.sleep(nanoseconds: 1_500_000_000)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            loadingLevel = false
                        }
                        
                    }
                }
            
        } else {
            VStack(spacing: 16) {
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
                        
                        Text("Ribbo found a river on his journey, but it doesn't know how to go through it.\nIt has sent a 3D model of his surroundings to us, so maybe you can use some of his commands to help him.\n\nThe commands are presented on the Coding console, you can tap them or drag them to the console to add them. After you create an algorithm you can test it on our simulator. If it passes, we will send it to Ribbo, but if it fails, it's just a simulator! Ribbo will be fine!")
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
                        VStack(spacing: 16) {
                            FirstLevelDescriptionView(descriptionVisibility: $showDescriptionSheet)
                        }
                        
                    })
                }
                
                
                HStack {
                    // Code editor
                    if showCodeEditor {
                        CodeEditorView(codeBlocksList: $codeBlocksList, currentMission: 1, isCodeEditorExpanded: $isCodeEditorExpanded, runningScene: $runningScene, showCodeEditor: $showCodeEditor, showIntroduction: $showIntroduction, showScene: $showScene)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.trailing, 8)
                    }
                    
                    // Scene view
                    if showScene {
                        ZStack {
                            SceneView(scene: scene, pointOfView: cameraNode, options: [.autoenablesDefaultLighting])
                            
                            VStack {
                                HStack {
                                    // Run Code Button
                                    Button(action: {
                                        runFirstLevelCode()
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
                                
                                
                                
                                Spacer()
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.leading, 8)
                    }
                }
                // fail sheet
                .sheet(isPresented: $showLevelFailedSheet, content: {
                    ZStack {
                        if colorScheme == .light {
                            LinearGradient(
                                colors: [
                                    Color(red: 0.88, green: 0.33, blue: 0.26),
                                    .white,
                                    .white
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        } else {
                            LinearGradient(
                                colors: [
                                    Color(red: 0.88, green: 0.33, blue: 0.26),
                                    .black,
                                    .black
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            
                        }
                        
                        
                        VStack(alignment: .center, spacing: 16) {
                            Spacer()
                            
                            Text("On no!")
                                .font(.largeTitle)
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .padding(.bottom, 80)
                            
                            Text("It looks like your code did not pass our test's safety requirements for Ribbo!\n\nBut don’t worry, this is just a simulator and nothing was actually sent, so Ribbo is fine!\n\nYou can try again, and if you need any help you can read the entire mission description by clicking on the ”Read More...” button.")
                                .multilineTextAlignment(.center)
                                .lineSpacing(8)
                                .padding(.horizontal, 32)
                            
                            Spacer()
                            
                            Button(action: {
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
                        
                    }
                    
                })
            }
            .padding()
            .background(Color(hex: colorScheme == .light ? "F2F1F6" : "131313").ignoresSafeArea())
            .navigationTitle("First Mission")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showLevelCompleteSheet, content: {
                ZStack {
                    if colorScheme == .light {
                        LinearGradient(
                            colors: [
                                Color(red: 0.47, green: 0.76, blue: 0.7),
                                .white,
                                .white
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    } else {
                        LinearGradient(
                            colors: [
                                Color(red: 0.47, green: 0.76, blue: 0.7),
                                .black,
                                .black
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                    }
                    
                    VStack(alignment: .center, spacing: 16) {
                        Spacer()
                        
                        Text("Congratulations!")
                            .font(.largeTitle)
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                            .padding(.bottom, 80)
                        
                        Text("Your code was sent and helped Ribbo overcome this challenge and continue his successful mission on Grass Planet!\n\nIt is by building code blocks like this that scientists send actual robots to explore other planets in our universe!")
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                            .padding(.horizontal, 32)
                        
                        Spacer()
                        
                        Button(action: {
                            gameManager.firstLevelComplete = true
                            gameManager.secondLevelAvailable = true
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
                }
                
            })
        }
    }
    
    func runFirstLevelCode() {
        withAnimation(.spring) {
            runningScene = true
        }
        
        if let ribboNode = scene?.rootNode.childNode(withName: "ribbo", recursively: true) {
            // move actions
            let moveFront = SCNAction.moveBy(x: -1.5, y: 0, z: 0, duration: 1)
            let moveBack = SCNAction.moveBy(x: 1.5, y: 0, z: 0, duration: 1)
            let moveLeft = SCNAction.moveBy(x: 0, y: 0, z: 1.5, duration: 1)
            let moveRight = SCNAction.moveBy(x: 0, y: 0, z: -1.5, duration: 1)

            // running code on ribbo
            Task {
                var ribboDirection = 0 // 0 forward, 1 left, -1 right, 2 back (considering start position)
                var currentAngle: Float = 0
                
                // iterating over each code block placed on the code editor
                for codeBlock in codeBlocksList {
                    var listIndex = 0
                    for codeBlockFromList in codeBlocksList {
                        withAnimation(.spring) {
                            if codeBlockFromList.id == codeBlock.id {
                                
                                codeBlocksList[listIndex].highlighted = true
                            } else {
                                codeBlocksList[listIndex].highlighted = false
                            }
                            listIndex += 1
                        }
                    }
                    
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
                    
                    // wait between running commands
                    try await Task.sleep(nanoseconds: 500_000)
                    
                    let xPosition = await ribboNode.position.x
                    let zPosition = await ribboNode.position.z
                    
                    // checking for allowed ribbo coordinates (to see if the code failed)
                    if await ribboNode.position.z <= -1.4 {
                        showLevelFailedSheet = true
                        break
                    } else if await ribboNode.position.z >= 2.8 {
                        showLevelFailedSheet = true
                        break
                    }
                    
                    if await ribboNode.position.x  >= -1.4 {
                        if await ribboNode.position.z >= 1.4 {
                            showLevelFailedSheet = true
                            break
                        }
                    } else if await ribboNode.position.x  < -3.2 {
                        if await ribboNode.position.z < 1.2 {
                            showLevelFailedSheet = true
                            break
                        }
                    }
                }

                for int in 0 ..< codeBlocksList.count {
                    codeBlocksList[int].highlighted = false
                }
                
                if await ribboNode.position.x < -4.75 {
                    showLevelCompleteSheet = true
                }
                
                runningScene = false
            }
        }
        
        
    }
}

#Preview {
    FirstLevelView()
        .environmentObject(GameManager())
}
