//
//  SecondViewController.swift
//  mapAnnotation
//
//  Created by John Mac on 9/27/16.
//  Copyright © 2016 John Wetters. All rights reserved.
//
import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {//begin
    
    @IBOutlet var imageView: UIImageView!
    
     var myPhoto:  UIImage?
    
    
    
    override func viewDidLoad() {//begin
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
    }//end
    
    
    override func didReceiveMemoryWarning() {//begin
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//end
    
   
    
    
    @IBAction func chooseFromCamera(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
        
        print("\ntake photo with camera\n")
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("\npicture taken\n")
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        
    
        print("\nimage saved\n")
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func stop(_ sender: AnyObject) {
        
        print("stop pictures and dismiss controller")
        
         self.dismiss(animated: true, completion: nil)
        
    }
    
 
    
    
}//end

