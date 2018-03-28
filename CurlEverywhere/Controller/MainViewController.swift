//
//  ViewController.swift
//  CurlEverywhere
//
//  Created by Edward de la Fuente on 2/1/18.
//  Copyright © 2018 Edward de la Fuente. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var chosenImage: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickOnCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true;
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert", message: "No camera found", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    @IBAction func clickOnGallery(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true;
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        chosenImage = imageView.image
        performSegue(withIdentifier: "Edit Taken Photo", sender: self)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image
        chosenImage = imageView.image
        performSegue(withIdentifier: "Edit Chosen Photo", sender: self)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is EditViewController
        {
            let editVC = segue.destination as! EditViewController
            editVC.imageToEdit = chosenImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

