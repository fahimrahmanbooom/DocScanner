//
//  HomeVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit

// MARK: - Home VC Helper

extension HomeVC {
    
    // MARK: - Set Customize the navigation bar home
    
    func setNavigationElements() {
        
        // MARK:- Selection
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selection))
        
        
        // MARK:- Settings
        var leftNavigationImage = UIImage(named: "settings")
        leftNavigationImage = leftNavigationImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftNavigationImage, style: .plain, target: self, action: #selector(settingsAction))
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Galary Button Color Change
    
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
    
    
    // MARK: - Set Folder Button Color Change
    
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
    
    
    // MARK: - Set Folder Table View
    
    func setFolderTableView() {
        
        self.folderTableView.register(UINib(nibName: "FolderTVCell", bundle: nil), forCellReuseIdentifier: "folderCell")
        
        self.folderTableView.frame = CGRect(x: topBarStackView.frame.minX, y: topBarStackView.frame.height, width: view.frame.width, height: (view.frame.height - (bottomView.frame.height + 50)))
        self.folderTableView.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.folderTableView.dataSource = self
        self.folderTableView.delegate = self
    
        self.view.addSubview(self.folderTableView)
        self.view.sendSubviewToBack(self.folderTableView)
    }
  
    

    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Folder Table View Cell
    
    func setFolderCell(cell: UITableViewCell) -> UITableViewCell {

        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Document Collection View
    
    func setDocumentCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

        self.documentCollectionView = UICollectionView(frame: CGRect(x: topBarStackView.frame.minX, y: topBarStackView.frame.height, width: view.frame.width, height: view.frame.height - (bottomView.frame.height + 50)), collectionViewLayout: layout)
     
        self.documentCollectionView.register(UINib(nibName: "DocumentCVCell", bundle: nil), forCellWithReuseIdentifier: "documentCell")
        
        self.documentCollectionView.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.documentCollectionView.delegate = self
        self.documentCollectionView.dataSource = self
        
        self.documentCollectionView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(self.documentCollectionView)
        self.view.sendSubviewToBack(self.documentCollectionView)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Document Collection View Cell
    
    func setDocumentCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        
        return cell
    }
}
