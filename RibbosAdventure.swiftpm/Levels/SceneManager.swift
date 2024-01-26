//
//  File 2.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 26/01/24.
//

import Foundation
import SceneKit
import SwiftUI

class SceneManager
{
    let scene: SCNScene
    let view: SCNView
    private let cameraOrbit: SCNNode
    private var maxWidthRatioRight: Float = 0.2
    private var maxWidthRatioLeft: Float = -0.2
    private var maxHeightRatioXDown: Float = 0.02
    private var maxHeightRatioXUp: Float = 0.4
    init(sceneName: String, cameraName: String) {
        self.view = SCNView()
        self.scene = SCNScene(named: (sceneName))!
        self.view.pointOfView = self.scene.rootNode.childNode(withName: cameraName, recursively: true)
        if self.view.pointOfView == nil {
            print("Error: Inexistent camera specified in init SceneManager")
            exit(1)
        }
        self.cameraOrbit = SCNNode()
        self.cameraOrbit.addChildNode(self.view.pointOfView!)
        self.scene.rootNode.addChildNode(self.cameraOrbit)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        panGesture.maximumNumberOfTouches = 1
        self.view.allowsCameraControl = false
        self.view.addGestureRecognizer(panGesture)
        self.view.backgroundColor = .white
        self.view.scene = self.scene
    }
    
    
    @objc private func panHandler(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view!)
        let ratioWidth = Float(translation.x) / Float(sender.view!.frame.size.width)
        if (sender.state == UIGestureRecognizer.State.changed) {
            withAnimation(.easeInOut) {
                if ratioWidth > 0.25 {
                    self.cameraOrbit.eulerAngles.y -= Float(Double.pi / 12) * 0.25 * 0.5
                    
                } else if ratioWidth < -0.25 {
                    self.cameraOrbit.eulerAngles.y -= Float(Double.pi / 12) * -0.25 * 0.5
                    
                } else {
                    self.cameraOrbit.eulerAngles.y -= Float(Double.pi / 12) * ratioWidth * 0.5
                    
                }
                
            }
        }
    }
}
