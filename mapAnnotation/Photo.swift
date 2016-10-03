//
//  photo.swift
//  mapAnnotation
//
//  Created by John Mac on 9/28/16.
//  Copyright © 2016 John Wetters. All rights reserved.
//

import Foundation
import UIKit

class Photo: NSObject, NSCoding {
    // MARK: Properties
    
    var photo: UIImage?
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("photo")
    
    // MARK: Types
    
    struct PropertyKey {
        static let photoKey = "photo"
    }
    
    // MARK: Initialization
    
    init?(photo: UIImage?) {
        // Initialize stored properties.
        self.photo = photo
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        
        
        // Must call designated initializer.
        self.init(photo: photo)
    }
    
}
