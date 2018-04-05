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
    
    var imageWidth: CGFloat = 0
    var imageHeight: CGFloat = 0
    var imagePosition = CGPoint(x: 0, y: 0)
    var imageSize = CGSize(width: 0, height: 0)
    
    var location = CGPoint.zero
    var newPosition = CGPoint(x: 0, y: 0)
    var stoneSize = CGSize(width: 122, height: 102)
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var selectedImage: UIImageView! {
        didSet {
            imageWidth = selectedImage.bounds.width
            imageHeight = selectedImage.bounds.height
            imageSize = CGSize(width: imageWidth, height: imageHeight)
            imagePosition = CGPoint(x: selectedImage.bounds.origin.x, y: selectedImage.bounds.origin.y)
        }
    }
    
    @IBOutlet weak var curlingStone: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIImagePickerController()
        pickerView.delegate = self
        selectedImage.image = imageToEdit
    }
    
    @IBAction func scaleCurlingStone(_ sender: UIPinchGestureRecognizer) {
        curlingStone.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        let newWidth = self.view.bounds.size.width
        let newHeight = self.view.bounds.size.height
        stoneSize = CGSize(width: newWidth, height: newHeight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! = touches.first! as UITouch
        location = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! =  touches.first! as UITouch
        location = touch.location(in: self.view)
        curlingStone.center = location
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.saveImage(top: curlingStone.image!, bottom: imageToEdit, newSize: imageSize)
        UIImageWriteToSavedPhotosAlbum(newImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        cancelButton.setTitle("Done", for: UIControlState.normal)
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
    
    @discardableResult
    func saveImage(top: UIImage, bottom: UIImage, newSize: CGSize) -> UIImage? {
        let newX = curlingStone.frame.origin.x
        let newY = curlingStone.frame.origin.y
        newPosition = CGPoint(x: newX, y: newY)
        
        // begin context with new size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        // draw images to context
        bottom.draw(in: CGRect(origin: imagePosition, size: imageSize))
        top.draw(in: CGRect(origin: newPosition, size: stoneSize))
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
