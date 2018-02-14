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
    @IBOutlet weak var selectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIImagePickerController()
        pickerView.delegate = self
        selectedImage.image = imageToEdit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
