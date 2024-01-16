//
//  SceneViewController.swift
//  My App
//
//  Created by Raphael Ferezin Kitahara on 16/01/24.
//

import UIKit
import SceneKit

//class FirstLevelSceneViewController: UIViewController, SCNSceneRendererDelegate, SCNPhysicsContactDelegate {
//    var sceneView:SCNView!
//    var scene:SCNScene!
//    
//    var robboNode:SCNNode!
//    var selfieStickNode:SCNNode!
//    
//    var motionForce = SCNVector3(0, 0, 0)
//    
//    var sounds:[String:SCNAudioSource] = [:]
//    
//    override func viewDidLoad() {
//        setupScene()
//        setupNodes()
//        setupSounds()
//    }
//    
//    func setupScene(){
//        sceneView = self.view as? SCNView
//        sceneView.delegate = self
//        
//        //sceneView.allowsCameraControl = true
//        scene = SCNScene(named: "FirstLevelScene.scn")
//        sceneView.scene = scene
//        
//        scene.physicsWorld.contactDelegate = self
//        
//        
//    }
//    
//    func setupNodes() {
//        robboNode = scene.rootNode.childNode(withName: "robbo", recursively: true)!
//        // selfieStickNode = scene.rootNode.childNode(withName: "selfieStick", recursively: true)!
//        robboNode.physicsBody?.applyForce(SCNVector3(x: 10, y: 0, z: 0), asImpulse: false)
//    }
//    
//    func setupSounds() {
//
//        
//    }
//    
//    override var shouldAutorotate: Bool {
//        return false
//    }
//    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }
//    
//}
