//
//  ViewController.swift
//  AR Travel
//
//  Created by Gokul Nair on 11/10/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "TravelCard", bundle: Bundle.main) {
        
        configuration.detectionImages = imageToTrack
        
        configuration.maximumNumberOfTrackedImages = 2
            
            print("added")
        
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
   
    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "scene1"{
                if let travelScene = SCNScene(named: "art.scnassets/scene1.scn"){
                    if let travelNode = travelScene.rootNode.childNodes.first{
                        travelNode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(travelNode)
                    }
                }
            }
            if imageAnchor.referenceImage.name == "scene2"{
                if let travelScene = SCNScene(named: "art.scnassets/scene2.scn"){
                    if let travelNode = travelScene.rootNode.childNodes.first{
                        travelNode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(travelNode)
                    }
                }
            }
            
           
        }
        
        return node
    }
    
}

extension ViewController{
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
