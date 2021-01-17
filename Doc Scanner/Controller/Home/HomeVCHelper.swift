//
//  HomeVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit

// MARK: - Home VC Helper

extension HomeVC: UITextFieldDelegate {
    
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
    
    func setGalleryButtonColor() {
        
        if galleryButtonSelected == true && folderButtonSelected == false  {
            
            let galaryOriginalImage = UIImage(named: "galary")
            let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
            galleryButton.setImage(galaryTintedImage, for: .normal)
            galleryButton.tintColor = .systemBlue
            
            let folderOriginalImage = UIImage(named: "folder")
            let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
            folderButton.setImage(folderTintedImage, for: .normal)
            folderButton.tintColor = .black
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Folder Button Color Change
    
    func setFolderButtonColor() {
        
        if folderButtonSelected == true && galleryButtonSelected == false {
            
            let folderOriginalImage = UIImage(named: "folder")
            let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
            folderButton.setImage(folderTintedImage, for: .normal)
            folderButton.tintColor = .systemBlue
            
            let galaryOriginalImage = UIImage(named: "galary")
            let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
            galleryButton.setImage(galaryTintedImage, for: .normal)
            galleryButton.tintColor = .black
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
        
        self.folderTableView.showsVerticalScrollIndicator = false
        
        self.folderTableView.allowsMultipleSelectionDuringEditing = true
        
        self.view.addSubview(self.folderTableView)
        self.view.sendSubviewToBack(self.folderTableView)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Folder Table View Cell
    
    func setFolderCell(cell: UITableViewCell) -> UITableViewCell {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        cell.multipleSelectionBackgroundView = view
        cell.backgroundColor = .white
        cell.selectionStyle = .default
        cell.tintColor = UIColor(hex: "EB5757")
        
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
        
        self.documentCollectionView.allowsMultipleSelection = false
        
        self.view.addSubview(self.documentCollectionView)
        self.view.sendSubviewToBack(self.documentCollectionView)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Document Collection View Cell
    
    func setDocumentCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Refresh TVandCV
    
    func setRefreshTVandCV(tvSortBy: String, cvSortBy: String) {
        
        if self.folderButtonSelected {
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: tvSortBy)
            
            DispatchQueue.main.async {
                self.folderTableView.reloadData()
            }
        }
        
        if self.galleryButtonSelected {
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: cvSortBy)
            
            DispatchQueue.main.async {
                self.documentCollectionView.reloadData()
            }
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Filter Action Sheet
    
    func setActionSheet() {
        
        let actionSheetVC = UIAlertController(title: "", message: "Select an Option", preferredStyle: .actionSheet)
        
        actionSheetVC.addAction(UIAlertAction(title: "Rename", style: .default , handler:{ (UIAlertAction) in
            print("Rename")
            
        }))
        
        actionSheetVC.addAction(UIAlertAction(title: "Set Password", style: .default , handler:{ (UIAlertAction) in
            print("Set Password")
            
            if !self.mySelectedFolder.isEmpty {
                
                
                let passwordAlert = UIAlertController(title: "Set Password", message: "Please enter minimum 6 digits of password", preferredStyle: .alert)
                
                var passTextField : UITextField?
                var confPassTextField: UITextField?
                var password: String = String()
                
                passwordAlert.addTextField { (textField : UITextField) in
                    
                    textField.placeholder = "Password"
                    passTextField = textField
                    passTextField?.delegate = self
                }
                
                
                passwordAlert.addTextField { (textField: UITextField) in
                    
                    textField.placeholder = "Confirm Password"
                    confPassTextField = textField
                    confPassTextField?.delegate = self
                }
                
                
                passwordAlert.addAction(UIKit.UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                    if (passTextField?.text == confPassTextField?.text) {
                        if passTextField?.text != "" {
                            password = (passTextField!.text)!
                            
                            self.setFolderPasswordToRealm(folderName: self.mySelectedFolder[0], password: password)
                        }
                    }
                }))
                
                
                passwordAlert.addAction(UIKit.UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    self.dismiss(animated: true)
                }))
                
                self.present(passwordAlert, animated: true, completion: nil)
            }
            
        }))
        
        actionSheetVC.addAction(UIAlertAction(title: "Share", style: .default , handler:{ (UIAlertAction) in
            print("Share")
            
        }))
        
        actionSheetVC.addAction(UIAlertAction(title: "Delete", style: .default , handler:{ (UIAlertAction) in
            print("Delete")
            
        }))
        
        actionSheetVC.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler:{ (UIAlertAction) in
            print("Cancel")
            
        }))
        
        self.present(actionSheetVC, animated: true)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
}
