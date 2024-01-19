//
//  FirstLevelARView.swift
//  Ribbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 19/01/24.
//

import Foundation
import ARKit
import SceneKit
import SwiftUI
import RealityKit
import UIKit

class FirstLevelARView: UIViewController, ARSCNViewDelegate {
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
        arView.scene = SCNScene(named: "FirstLevelScene.scn")!
    }
    
    // MARK: - Functions for standard AR view handling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        arView.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {}
    
    func sessionInterruptionEnded(_ session: ARSession) {}
    func session(_ session: ARSession, didFailWithError error: Error)
    {}
    func session(_ session: ARSession, cameraDidChangeTrackingState
                 camera: ARCamera) {}
}

//struct NavigationIndicator: UIViewControllerRepresentable {
//    typealias UIViewControllerType = <#type#>
//    
//    typealias UIViewControllerType = ARView
//    
//    func makeUIViewController(context: Context) -> ARView {
//        return ARView()
//    }
//    func updateUIViewController(_ uiViewController:
//                                NavigationIndicator.UIViewControllerType, context:
//                                UIViewControllerRepresentableContext<NavigationIndicator>) { }
//}
