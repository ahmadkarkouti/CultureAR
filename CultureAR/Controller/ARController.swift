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

class ARController: UIViewController, ARSCNViewDelegate {
    
    let sceneView: ARSCNView = {
        let sv = ARSCNView()
        return sv
    }()
    
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
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.fillSuperview(view)
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/monalisa/monalisa.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
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
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
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

