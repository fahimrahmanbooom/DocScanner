//
//  HomeVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit

// MARK: - Home VC Helper

extension HomeVC {
    
    // MARK:- Customize the navigation bar home
    
    func setNavigationElements() {
        
        // MARK:- Selection
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selection))
        
        
        // MARK:- Settings
        var leftNavigationImage = UIImage(named: "settings")
        leftNavigationImage = leftNavigationImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftNavigationImage, style: .plain, target: self, action: #selector(settingsAction))
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Galary Button Color Change
    
    func setGalaryButtonColor() {
        
        if galaryButtonSelected == true && folderButtonSelected == false  {
            
            let galaryOriginalImage = UIImage(named: "galary")
            let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
            galaryButton.setImage(galaryTintedImage, for: .normal)
            galaryButton.tintColor = .systemBlue
            
            let folderOriginalImage = UIImage(named: "folder")
            let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
            folderButton.setImage(folderTintedImage, for: .normal)
            folderButton.tintColor = .black
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Folder Button Color Change
    
    func setFolderButtonColor() {
        
        if folderButtonSelected == true && galaryButtonSelected == false {
            
            let folderOriginalImage = UIImage(named: "folder")
            let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
            folderButton.setImage(folderTintedImage, for: .normal)
            folderButton.tintColor = .systemBlue
            
            let galaryOriginalImage = UIImage(named: "galary")
            let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
            galaryButton.setImage(galaryTintedImage, for: .normal)
            galaryButton.tintColor = .black
        }
    }
}
