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
    var scene = SCNScene(named: "FirstLevelScene.scn")

    var body: some View {
        VStack(spacing: 16) {
            // Introduction
            VStack(alignment: .leading) {
                Text("Introduction")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sed blandit lorem. Donec ornare, tortor a tempus cursus, nibh metus rutrum felis, ac lacinia nibh lacus non erat. Proin tincidunt vulputate neque a blandit. Nam vel lorem tincidunt erat lacinia commodo eget et turpis. Mauris mollis diam eu justo tempor luctus. Morbi semper vulputate egestas. Praesent placerat arcu justo, ac suscipit augue volutpat nec...")
                    .foregroundStyle(.gray)
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack {
                // Code editor
                CodeEditorView(codeBlocksList: $codeBlocksList)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.trailing, 8)
                
                // Scene view
                ZStack {
                    SceneView(scene: scene, pointOfView: cameraNode, options: [.allowsCameraControl,.autoenablesDefaultLighting])
                    
                    VStack {
                        HStack {
                            // Run Code Button
                            Button(action: {
                                runFirstLevelCode()
                            }, label: {
                                HStack(spacing: 8) {
                                    Text("Run Code")
                                    Image(systemName: "play.fill")
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
                            
                            Spacer()
                            
                            // Expand Scene Button
                            Button(action: {
                                
                            }, label: {
                                HStack(spacing: 8) {
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
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
        .padding()
        .background(Color(hex: "F2F1F6").ignoresSafeArea())
        .navigationTitle("Commands")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func runFirstLevelCode() {
        
        
        if let robboNode = scene?.rootNode.childNode(withName: "robbo", recursively: true) {
            // move actions
            let moveFront = SCNAction.moveBy(x: -1.75, y: 0, z: 0, duration: 1)
            let moveBack = SCNAction.moveBy(x: 1.75, y: 0, z: 0, duration: 1)
            let moveLeft = SCNAction.moveBy(x: 0, y: 0, z: 1.75, duration: 1)
            let moveRight = SCNAction.moveBy(x: 0, y: 0, z: -1.75, duration: 1)
            
            // rotate actions
            
            let rotateLeft = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: 1.57), duration: 1)
            let rotateLeftToFront = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: -1, z: 0, w: 1.57), duration: 1)
            let rotateLeftToBack = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: 3.14), duration: 1)
            let rotateRight = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: -1, z: 0, w: 1.57), duration: 1)
            let rotateRightToFront = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: 0), duration: 1)
            let rotateRightToBack = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: -1, z: 0, w: 3.14), duration: 1)
            
            // running code on robbo
            Task {
                var robboDirection = 0 // 0 forward, 1 left, -1 right, 2 back (considering start position)
                
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
                            if robboDirection == 0 {
                                await robboNode.runAction(rotateLeft)
                                robboDirection += 1
                                
                            } else if robboDirection == 1 {
                                await robboNode.runAction(rotateLeftToBack)
                                robboDirection += 1
                                
                            } else if robboDirection == 2 {
                                await robboNode.runAction(rotateRight)
                                robboDirection = -1
                                
                            } else if robboDirection == -1 {
                                await robboNode.runAction(rotateRightToFront)
                                robboDirection += 1
                            }
                            
                        case "rotateRight()":
                            if robboDirection == 0 {
                                await robboNode.runAction(rotateRight)
                                robboDirection -= 1
                                
                            } else if robboDirection == 1 {
                                await robboNode.runAction(rotateLeftToFront)
                                robboDirection -= 1
                                
                            } else if robboDirection == 2 {
                                await robboNode.runAction(rotateLeft)
                                robboDirection = -1
                                
                            } else if robboDirection == -1 {
                                await robboNode.runAction(rotateRightToBack)
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
            }
        }
    }
}

#Preview {
    FirstLevelView()
}
