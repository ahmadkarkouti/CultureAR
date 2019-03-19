//
//  ARController.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 19/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARController: UIViewController {
    
    let sceneView: ARSCNView = {
        let sv = ARSCNView()
        return sv
    }()
    var focusSquare: FocusSquare?
    var screenCenter: CGPoint!
    var modelsInScene: [SCNNode] = []
    var model: ARModel = StaticAPI.shared.arModels.first!
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "cancel-music").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        btn.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    let changeModelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "3d").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.addTarget(self, action: #selector(changeModel), for: .touchUpInside)
        return btn
    }()
    
    let scaleUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return btn
    }()
    
    let scaleDownButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "minus-symbol").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return btn
    }()
    
    let rotateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "rotation").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return btn
    }()
    
    let addModelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "add-2").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 35
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.addTarget(self, action: #selector(addObject), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.fillSuperview(view)
        screenCenter = view.center
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        configuration.isLightEstimationEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    fileprivate func setupConstraints() {
        changeModelButton.anchor(view: view, top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        rotateButton.anchor(view: view, top: view.safeAreaLayoutGuide.topAnchor, leading: changeModelButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        closeButton.anchor(view: view, top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
        addModelButton.anchor(view: view, top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 24, right: 0))
        addModelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func closeButtonPressed() {
       dismiss(animated: true)
    }
    
    @objc func changeModel() {
        definesPresentationContext = true
        let vc = ModelPicker()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let viewCenter = CGPoint(x: size.width/2, y: size.height/2)
        screenCenter = viewCenter
    }
    
    
    
    
    func updateFocusSquare() {
        guard let focusSquareLocal = focusSquare else {return}
        guard let pointOfView = sceneView.pointOfView else { return }
        let firstVisibleModel = modelsInScene.first { (node) -> Bool in
            return sceneView.isNode(node, insideFrustumOf: pointOfView)
        }
        let modelsAreVisible = firstVisibleModel != nil
        if modelsAreVisible != focusSquareLocal.isHidden {
            focusSquareLocal.setHidden(to: modelsAreVisible)
            
        }
        
        // Depending on the size of the flat surface
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        if let hitTestResult = hitTest.first {
            //            print("Focus square hits a plane")
            let canAddNewModel = hitTestResult.anchor is ARPlaneAnchor
            focusSquareLocal.isClosed = canAddNewModel
            addModelButton.isEnabled = canAddNewModel
            
        } else {
            //            print("Focus Square does not hit a plane")
            focusSquareLocal.isClosed = false
            addModelButton.isEnabled = false
        }
    }
    
    func rotateObject() -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(360)), z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(action)
        
        return repeatAction
    }
    
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}



extension ARController: ModelPickerDelegate {
    func updateModel(model: ARModel) {
        print(model)
        self.model = model
    }
    
    
}
