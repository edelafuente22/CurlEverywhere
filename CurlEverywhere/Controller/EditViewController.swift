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
    @IBOutlet weak var selectedImage: UIImageView! {
        didSet {
            selectedImage.layer.borderColor = UIColor.yellow.cgColor
            selectedImage.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var curlingStone: UIImageView!
    @IBAction func scaleCurlingStone(_ sender: UIPinchGestureRecognizer) {
        curlingStone.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    
    
    var location = CGPoint(x: 126, y: 521)
    
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
        saveImage(top: curlingStone.image!, bottom: imageToEdit, newSize: CGSize(width: 122, height: 102))
        UIImageWriteToSavedPhotosAlbum(newImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIImagePickerController()
        pickerView.delegate = self
        selectedImage.image = imageToEdit

        curlingStone.center = CGPoint(x: 126, y: 521)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your new image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func saveImage(top: UIImage, bottom: UIImage, newSize: CGSize) -> UIImage? {
        // begin context with new size
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        // draw images to context
        bottom.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        top.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        // return the new image
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // returns an optional
        return newImage
    }
    
//    func saveImage() {
//        let bottomImage = UIImage(named: "imageToEdit")!
//        let topImage = UIImage(named: "curlingstone")!
//
//        let newSize = CGSize // set this to what you need
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//
//        bottomImage.draw(in: CGRect(origin: CGPoint.zero, size: newSize))//As drawInRect is deprecated
//        topImage.draw(at: CGRect(origin: CGPoint.zero, size: newSize))//As drawInRect is deprecated
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
