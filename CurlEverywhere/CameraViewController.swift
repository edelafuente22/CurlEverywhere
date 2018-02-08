//
//  CameraViewController.swift
//  CurlEverywhere
//
//  Created by Edward de la Fuente on 2/1/18.
//  Copyright © 2018 Edward de la Fuente. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    let cameraController = CameraController()

    
    @IBOutlet fileprivate var capturePreviewView: UIView!
    
    @IBOutlet weak var captureButton: UIButton!
    
    @IBOutlet weak var toggleFlashButton: UIButton!
    @IBOutlet weak var toggleCameraMode: UIButton!
    @IBOutlet weak var toggleFacingMode: UIButton!
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        }
        configureCameraController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

