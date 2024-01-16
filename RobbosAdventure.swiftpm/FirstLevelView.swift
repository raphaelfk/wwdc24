//
//  FirstLevelView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 16/01/24.
//

import SwiftUI
import SceneKit

struct FirstLevelView: View {
    var scene = SCNScene(named: "FirstLevelScene.scn")!

    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
    }
    
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
                CodeEditorView()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.trailing, 8)
                
                // Scene view
                ZStack {
                    SceneView(scene: scene, pointOfView: cameraNode, options: [.allowsCameraControl,.autoenablesDefaultLighting])
                    
                    VStack {
                        HStack {
                            // Run Code Button
                            Button(action: {
                                
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
}

#Preview {
    FirstLevelView()
}
