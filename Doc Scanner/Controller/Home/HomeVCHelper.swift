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
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Folder Table View
    
    func setFolderTableView() {
        //folderTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        folderTableView.frame = CGRect(x: topBarStackView.frame.minX, y: topBarStackView.frame.height, width: view.frame.width, height: view.frame.height)
        folderTableView.backgroundColor = UIColor(hex: "EEEEEE")
        folderTableView.dataSource = self
        folderTableView.delegate = self
    
        self.view.addSubview(folderTableView)
        self.view.sendSubviewToBack(folderTableView)
    }
  
    

    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Folder Table View Cell
    
    func setCell(cell: UITableViewCell) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "#$%&"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true

        return cell
    }
}
