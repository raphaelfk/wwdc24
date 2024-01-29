//
//  SceneKitView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 26/01/24.
//

import Foundation
import SceneKit
import SwiftUI

struct SceneKitView : UIViewRepresentable {
    let sceneManager: SceneManager
    
    func makeUIView(context: Context) -> SCNView {
        return sceneManager.view
    }
    
    func updateUIView(_ scnView: SCNView, context: Context) {
    }
}
