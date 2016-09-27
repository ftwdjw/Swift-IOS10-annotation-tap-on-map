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
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func stop(_ sender: AnyObject) {
        
        print("stop pictures and dismiss controller")
        
         self.dismiss(animated: true, completion: nil)
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("\nprepare for segue\n")
        
        if segue.identifier == "toCamera" {
            let dvc = segue.destination as! ListPage
            dvc.newImage = imageView.image
            if dvc.newImage != nil{
                print("\nnewImage is present\n")
            }
            else{
                print("\nno picture present\n")
            }
        }
    }
    
    
}//end

