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
    @Binding var firstLevelComplete: Bool
    @State var isCodeEditorExpanded = false
    @State var isIntroductionExpanded = false
    @State var isSceneExpanded = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var runningScene = false
    var scene = SCNScene(named: "FirstLevelScene.scn")
    @Binding var secondLevelAvailable: Bool
    @State var showCodeEditor = true
    @State var showDescriptionSheet = false
    @State var showIntroduction = true
    @State var showLevelCompleteSheet = false
    @State var showScene = true

    var body: some View {
        VStack(spacing: 16) {
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
                        Spacer()
                        
                        Text("Ribbo found a river on his journey, but it doesn't know how to go through it.\nIt has sent a 3D model of his surroundings to us, so maybe you can use some of his commands to help him.\n\nThe commands are presented on the Coding console, you can tap them or drag them to the console to add them. After you create an algorithm you can test it on our simulator. If it passes, we will send it to Ribbo, but if it fails, it's just a simulator! Ribbo will be fine!")
                            .fontDesign(.monospaced)
                            .lineSpacing(10.0)
                            .padding(.horizontal, 64)
                        
                        Spacer()
                        
                        Button(action: {
                            showDescriptionSheet = false
                        }, label: {
                            Text("Dismiss")
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.gray.opacity(0.25))
                                }
                                .padding(.bottom, 32)
                        })
                    }
                    
                })
            }
            
            
            HStack {
                // Code editor
                if showCodeEditor {
                    CodeEditorView(codeBlocksList: $codeBlocksList)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.trailing, 8)
                }
                
                // Scene view
                if showScene {
                    ZStack {
                        SceneView(scene: scene, pointOfView: cameraNode, options: [.allowsCameraControl,.autoenablesDefaultLighting])
                        
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
                    firstLevelComplete = true
                    secondLevelAvailable = true
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
    
    func runFirstLevelCode() {
        runningScene = true
        
        if let robboNode = scene?.rootNode.childNode(withName: "robbo", recursively: true) {
            // move actions
            let moveFront = SCNAction.moveBy(x: -1.5, y: 0, z: 0, duration: 1)
            let moveBack = SCNAction.moveBy(x: 1.5, y: 0, z: 0, duration: 1)
            let moveLeft = SCNAction.moveBy(x: 0, y: 0, z: 1.5, duration: 1)
            let moveRight = SCNAction.moveBy(x: 0, y: 0, z: -1.5, duration: 1)

            // running code on robbo
            Task {
                var robboDirection = 0 // 0 forward, 1 left, -1 right, 2 back (considering start position)
                var currentAngle: Float = 0
                
                var rotateLeft = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: (1.57 + currentAngle)), duration: 1)
                
                // iterating over each code block placed on the code editor
                for codeBlock in codeBlocksList {
                    var listIndex = 0
                    for codeBlockFromList in codeBlocksList {
                        if codeBlockFromList.id == codeBlock.id {
                            codeBlocksList[listIndex].highlighted = true
                        } else {
                            codeBlocksList[listIndex].highlighted = false
                        }
                        listIndex += 1
                    }
                    
                    switch codeBlock.command {
                        case "moveForward()":
                            if robboDirection == 0 {
                                await robboNode.runAction(moveFront)
                            } else if robboDirection == 1 {
                                await robboNode.runAction(moveLeft)
                            } else if robboDirection == 2 {
                                await robboNode.runAction(moveBack)
                            } else if robboDirection == -1 {
                                await robboNode.runAction(moveRight)
                            }
                            
                            
                        case "rotateLeft()":
                            await robboNode.runAction(SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: (currentAngle + 1.57)), duration: 1))
                            currentAngle += 1.57
                            
                            // facing forward, turn left
                            if robboDirection == 0 {
                                robboDirection += 1
                                
                            // facing left, turn back
                            } else if robboDirection == 1 {
                                robboDirection += 1
                                
                            // facing back, turn right
                            } else if robboDirection == 2 {
                                robboDirection = -1
                                
                            // facing right, turn forward
                            } else if robboDirection == -1 {
                                robboDirection += 1
                            }
                            
                        case "rotateRight()":
                            await robboNode.runAction(SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: (currentAngle - 1.57)), duration: 1))
                            currentAngle -= 1.57
                            
                            // facing forward, turn to right
                            if robboDirection == 0 {
                                robboDirection -= 1
                                
                            // facing left, turn to front
                            } else if robboDirection == 1 {
                                robboDirection -= 1
                            
                            // facing back, turn to left
                            } else if robboDirection == 2 {
                                robboDirection = 1
                                
                            // facing right, turn to back
                            } else if robboDirection == -1 {
                                robboDirection = 2
                            }
                            
                        default:
                            print("No command (\(codeBlock.command ?? "Error") found!")
                    }
                    
                    // wait between running commands
                    try await Task.sleep(nanoseconds: 500_000)
                }

                for int in 0 ..< codeBlocksList.count {
                    codeBlocksList[int].highlighted = false
                }
                
                if await robboNode.position.x < -4.75 {
                    showLevelCompleteSheet = true
                }
                
                runningScene = false
            }
        }
        
        
    }
}

//#Preview {
//    FirstLevelView()
//}
