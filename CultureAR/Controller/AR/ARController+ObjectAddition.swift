//
//  ARController+ObjectAddition.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 19/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension ARController {
    
    fileprivate func getModel(named name: String) -> SCNNode? {
        let scene = SCNScene(named: "art.scnassets/\(name)/\(name).scn")
        guard let model = scene?.rootNode.childNode(withName: "SketchUp", recursively: false) else {return nil}
        
        model.name = name
        var scale: CGFloat
        switch name {
        case "iPhoneX": scale = 0.025
        case "iPhone8": scale = 0.000008
        case "iPhone7": scale = 0.0001
        case "MacBookPro13": scale = 0.0022
        default: scale = 1
        }
        
        model.scale = SCNVector3(scale, scale, scale)
        return model
    }
    
    @objc func addObject(_ sender: Any) {
        guard focusSquare != nil else {return}
        let modelNmae = model.name
        guard let model = getModel(named: modelNmae) else {
            print("Unable to load model \(modelNmae)!")
            return
        }
        //        let light = sceneView.scene.rootNode.childNodes.filter { $0.name == "spot" }.first!
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        guard let worldTransformColumn3 = hitTest.first?.worldTransform.columns.3 else {return}
        model.runAction(rotateObject())
        //        model.addChildNode(light)
        model.position = SCNVector3(worldTransformColumn3.x, worldTransformColumn3.y, worldTransformColumn3.z)
        sceneView.scene.rootNode.addChildNode(model)
        print("\(modelNmae) added sucessfully!")
        modelsInScene.append(model)
        print(modelsInScene.count, "Models in the scene")
    }
}
