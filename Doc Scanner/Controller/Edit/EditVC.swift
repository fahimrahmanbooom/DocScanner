//
//  EditVC.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 11/1/21.
//

import UIKit

// MARK: - Edit View Controller

class EditVC: UIViewController {
    
    
    // MARK: - Variables
    
    var editImage: UIImage = UIImage()
    var rotationCounter: Int = 0
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var editImageView: UIImageView!
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewCustomColor(view: self.view, color: .white)
        self.setEditImage(imageView: self.editImageView, image: self.editImage, contentMode: .scaleAspectFit)
        self.setNavigationElements()
        self.editImageView.enableZoom()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Done Button
    
    @objc func done() {
        print(#function)
        
        setImageRotation()
    }
}
