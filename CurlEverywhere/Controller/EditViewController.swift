//
//  EditViewController.swift
//  CurlEverywhere
//
//  Created by Edward de la Fuente on 2/13/18.
//  Copyright © 2018 Edward de la Fuente. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageToEdit: UIImage!
    var newImage: UIImage!
    
    var location = CGPoint.zero
    var stoneSize = CGSize(width: 122, height: 102)
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var selectedImage: UIImageView! {
        didSet {
            selectedImage.layer.borderColor = UIColor.black.cgColor
            selectedImage.layer.borderWidth = 0.1
        }
    }
    
    @IBOutlet weak var curlingStone: UIImageView!
    @IBAction func scaleCurlingStone(_ sender: UIPinchGestureRecognizer) {
        curlingStone.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        let newWidth = self.view.frame.size.width
        let newHeight = self.view.frame.size.height
        stoneSize = CGSize(width: newWidth, height: newHeight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! = touches.first! as UITouch
        location = touch.location(in: self.view)
        curlingStone.center = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! =  touches.first! as UITouch
        location = touch.location(in: self.view)
        curlingStone.center = location
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveImage(top: curlingStone.image!, bottom: imageToEdit, newSize: CGSize(width: 450, height: 450))
        UIImageWriteToSavedPhotosAlbum(newImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        cancelButton.setTitle("Done", for: UIControlState.normal)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIImagePickerController()
        pickerView.delegate = self
        selectedImage.image = imageToEdit
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "You can find your new image in your photo album.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func saveImage(top: UIImage, bottom: UIImage, newSize: CGSize) -> UIImage? {
        // begin context with new size
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        // draw images to context
        bottom.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        top.draw(in: CGRect(origin: location, size: stoneSize))
        // return the new image
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // returns an optional
        return newImage
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
