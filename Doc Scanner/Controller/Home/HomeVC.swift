//
//  HomeViewController.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit
import VisionKit
//import RealmSwift

// MARK: Home VC

class HomeVC: UIViewController {
    
    // MARK: - Variables
    
    var galleryButtonSelected = Bool()
    var folderButtonSelected = Bool()
    
    var docsAndFoldsTableView: UITableView = UITableView()
    var docsAndFoldsCollectionView: UICollectionView!
    
    var myDocuments = [Documents]()
    var myFolders = [Folders]()
    
    var mySelectedFolder = [String]()
    var mySelectedDocument = [String]()
    
    var folderName: String = "Default"
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var topBarStackView: UIStackView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var folderButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.galleryButtonSelected = false
        self.folderButtonSelected = true
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Library", preferredLargeTitle: true)
        
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        
        self.setNavigationElements()
        
        self.setGalleryAndFolderButtonColor()
        
        self.setDocumentCollectionView()
        
        self.docsAndFoldsTableView.tableFooterView = UIView()
        
        self.myDocuments.removeAll()
        
        self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
        
        self.myFolders.removeAll()
        
        self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
        
        //let realm = try! Realm()
        //print(realm.configuration.fileURL)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - View Did Appear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Library", preferredLargeTitle: true)
        
        self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
        
        self.showToast(message: "Synced", duration: 1.0, position: .center)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Navigation Settings
    
    @objc func settingsAction() {
        print(#function)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Selection
    
    @objc func selection() {
        print(#function)
        
        // MARK: - List Button Selected
        
//        if !self.docsAndFoldsTableView.isHidden {
//
//            self.docsAndFoldsTableView.isEditing = !self.docsAndFoldsTableView.isEditing
//
//            if self.docsAndFoldsTableView.isEditing {
//
//                self.navigationItem.rightBarButtonItem?.title = "Delete"
//            }
//            else {
//
//                self.navigationItem.rightBarButtonItem?.title = "Select"
//
//                if !mySelectedFolder.isEmpty {
//
//                    for deleteFolder in mySelectedFolder {
//
//                        self.deleteFolderFromRealm(folderName: deleteFolder)
//
//                        self.myFolders.removeAll()
//                        self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
//                    }
//
//                    self.mySelectedFolder.removeAll()
//
//                    DispatchQueue.main.async {
//                        self.docsAndFoldsTableView.reloadData()
//                    }
//                }
//
//
//                if !self.mySelectedDocument.isEmpty {
//
//                    for deleteDocument in mySelectedDocument {
//
//                        self.deleteDocumentFromRealm(documentName: deleteDocument)
//
//                        self.myDocuments.removeAll()
//                        self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
//                    }
//
//                    self.mySelectedDocument.removeAll()
//
//                    DispatchQueue.main.async {
//                        self.docsAndFoldsTableView.reloadData()
//                    }
//                }
//            }
//        }
        
        
        
        //-------------------------------------------------------------------------------------------------------------------------------------------------
        
        
        
        // MARK: - Grid Button Selected
        
        if !self.docsAndFoldsCollectionView.isHidden {
            
            self.docsAndFoldsCollectionView.allowsMultipleSelection = !self.docsAndFoldsCollectionView.allowsMultipleSelection
            
            if self.docsAndFoldsCollectionView.allowsMultipleSelection {
                
                self.navigationItem.rightBarButtonItem?.title = "Delete"
            }
            else {
                
                self.navigationItem.rightBarButtonItem?.title = "Select"
                
//                if !self.mySelectedDocument.isEmpty {
//                    print(self.mySelectedDocument)
//                    for deleteDocument in mySelectedDocument {
//                        print("for loop")
//                        self.deleteDocumentFromRealm(documentName: deleteDocument)
//                    }
//
//                    self.mySelectedDocument.removeAll()
//
//                    //self.myDocuments.removeAll()
//                    //self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
//
//                    self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
//                    DispatchQueue.main.async {
//                        print("reload data")
//                        self.docsAndFoldsCollectionView.reloadData()
//                    }
//                }
                
                
//                if !self.mySelectedFolder.isEmpty {
//
//                    for deleteFolder in mySelectedFolder {
//
//                        self.deleteFolderFromRealm(folderName: deleteFolder)
//                    }
//
//                    self.mySelectedFolder.removeAll()
//
//                    //self.myFolders.removeAll()
//                    //self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
//
//                    self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
//                    DispatchQueue.main.async {
//                        self.docsAndFoldsCollectionView.reloadData()
//                    }
//                }
            }
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Add Folder
    
    @IBAction func addFolderPressed(_ sender: UIButton) {
        print(#function)
        
        if let createFolderVC = self.storyboard?.instantiateViewController(withIdentifier: "createFolderVC") as? CreateFolderVC {
            
            self.navigationController?.pushViewController(createFolderVC, animated: true)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Folders
    
    @IBAction func foldersPressed(_ sender: UIButton) {
        print(#function)
        
        if self.folderButtonSelected == true {
            
            self.docsAndFoldsCollectionView.isHidden = true
            self.docsAndFoldsTableView.isHidden = false
            
            self.docsAndFoldsCollectionView.removeFromSuperview()
            
            self.setFolderButtonColor()
            
            self.setFolderTableView()
            
            // when folder button is selected do -
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: folderName, sortBy: "documentSize")
            
            DispatchQueue.main.async {
                self.docsAndFoldsTableView.reloadData()
            }
            
            self.galleryButtonSelected = true
            self.folderButtonSelected = false
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Gallery
    
    @IBAction func galleryPressed(_ sender: UIButton) {
        print(#function)
        
        if self.galleryButtonSelected == true {
            
            self.docsAndFoldsTableView.isHidden = true
            self.docsAndFoldsCollectionView.isHidden = false
            
            self.docsAndFoldsTableView.removeFromSuperview()
            
            self.setGalleryButtonColor()
            
            self.setDocumentCollectionView()
            
            // When gallery button is selected do -
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: folderName, sortBy: "documentSize")
            
            DispatchQueue.main.async {
                self.docsAndFoldsCollectionView.reloadData()
            }
            
            self.galleryButtonSelected = false
            self.folderButtonSelected = true
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Filter
    
    @IBAction func filterPressed(_ sender: UIButton) {
        print(#function)
        
        self.setActionSheet()
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Search
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print(#function)
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Camera
    @IBAction func cameraPressed(_ sender: UIButton) {
        print(#function)
        
        let vnDocVC = VNDocumentCameraViewController()
        vnDocVC.delegate = self
        present(vnDocVC, animated: false)
        
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Home VC Folder Table View

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Number Of Rows In Section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Number Of Section
    
    func numberOfSections(in tableView: UITableView) -> Int { return self.myFolders.count + self.myDocuments.count }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Cell For Row At
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = docsAndFoldsTableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! docsAndFoldsTVCell
        
        if indexPath.section < self.myFolders.count {
            
            cell.docsAndFoldsImageView.image = UIImage(named: "createFolder")
            cell.nameLabel.text = self.myFolders[indexPath.section].folderName
            cell.numberOfItemsLabel.text = String(self.myFolders[indexPath.section].documents.count) + " Document(s)"
        }
        
        else {
            
            cell.docsAndFoldsImageView.image = UIImage(data: self.myDocuments[indexPath.section - self.myFolders.count].documentData ?? Data())
            cell.nameLabel.text = self.myDocuments[indexPath.section - self.myFolders.count].documentName
            cell.numberOfItemsLabel.text = "1 Document"
        }
        
        return self.setFolderCell(cell: cell)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Height For Row At
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - Height For Header In Section
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - View For Header In Section
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Did Select Row At
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath.section)
        
        if !self.docsAndFoldsTableView.isEditing {
            
            if indexPath.section < self.myFolders.count {
                
                if let folderGalleryVC = self.storyboard?.instantiateViewController(withIdentifier: "folderGalleryVC") as? FolderGalleryVC {
                    
                    folderGalleryVC.folderName = self.myFolders[indexPath.section].folderName!
                    
                    self.navigationController?.pushViewController(folderGalleryVC, animated: false)
                }
            }
            else {
                
                if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditVC {
                    
                    editVC.editImage = UIImage(data: self.myDocuments[indexPath.section - self.myFolders.count].documentData ?? Data()) ?? UIImage()
                    editVC.currentDocumentName = self.myDocuments[indexPath.section - self.myFolders.count].documentName ?? String()
                    
                    self.navigationController?.pushViewController(editVC, animated: true)
                }
            }
        }
        else {
            
            if indexPath.section < self.myFolders.count {
            
                self.mySelectedFolder.append(self.myFolders[indexPath.section].folderName!)
            }
            else {
                
                self.mySelectedDocument.append(self.myDocuments[indexPath.section - self.myFolders.count].documentName!)
            }
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Did Deselect Row At
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print(#function, indexPath.section)
        
        if self.docsAndFoldsTableView.isEditing {
            
            if indexPath.section < self.myFolders.count {
                
                self.mySelectedFolder.removeAll(where: { $0 == self.myFolders[indexPath.section].folderName })
            }
            else {
                
                self.mySelectedDocument.removeAll(where: { $0 == self.myDocuments[indexPath.section - self.myFolders.count].documentName })
            }
        }
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Document Collection View

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Number Of Items In Section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.myFolders.count + self.myDocuments.count
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Cell For Item At
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = docsAndFoldsCollectionView.dequeueReusableCell(withReuseIdentifier: "documentCell", for: indexPath) as! DocsAndFoldsCVCell
        
        
        if indexPath.row < self.myFolders.count {
            
            cell.docsAndFoldsImageView.image = UIImage(named: "createFolder")
            cell.nameLabel.text = self.myFolders[indexPath.row].folderName
            cell.numberOfItemsLabel.text = String(self.myFolders[indexPath.row].documents.count) + " Document(s)"
        }
        else {
            
            cell.docsAndFoldsImageView.image = UIImage(data: self.myDocuments[indexPath.row - self.myFolders.count].documentData ?? Data())
            cell.nameLabel.text = self.myDocuments[indexPath.row - self.myFolders.count].documentName
            cell.numberOfItemsLabel.text = "1 Document"
        }
        
        return self.setDocumentCell(cell: cell)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        
        return CGSize(width: size, height: size + 30)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Did Select Item At
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell : UICollectionViewCell = self.docsAndFoldsCollectionView.cellForItem(at: indexPath)!
        
        cell.backgroundColor = UIColor(hex: "EB5757")
        
        if !self.docsAndFoldsCollectionView.allowsMultipleSelection {
            
            if indexPath.row < self.myFolders.count {
                
                if let folderGalleryVC = self.storyboard?.instantiateViewController(withIdentifier: "folderGalleryVC") as? FolderGalleryVC {
                    
                    folderGalleryVC.folderName = self.myFolders[indexPath.row].folderName!
                    
                    self.navigationController?.pushViewController(folderGalleryVC, animated: false)
                }
            }
            else {
                
                if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditVC {
                    
                    editVC.editImage = UIImage(data: self.myDocuments[indexPath.row - self.myFolders.count].documentData ?? Data()) ?? UIImage()
                    editVC.currentDocumentName = self.myDocuments[indexPath.row - self.myFolders.count].documentName ?? String()
                    
                    self.navigationController?.pushViewController(editVC, animated: true)
                }
            }
        }
        else {
            
            if indexPath.row < self.myFolders.count {
            
                self.mySelectedFolder.append(self.myFolders[indexPath.row].folderName!)
            }
            else {
                
                self.mySelectedDocument.append(self.myDocuments[indexPath.row - self.myFolders.count].documentName!)
            }
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Did Deselect Item At
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        
        let cell : UICollectionViewCell = self.docsAndFoldsCollectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = .white
        
        if self.docsAndFoldsCollectionView.allowsMultipleSelection {
            
            if indexPath.row < self.myFolders.count {
                
                self.mySelectedFolder.removeAll(where: { $0 == self.myFolders[indexPath.row].folderName })
                
            }
            else {
                
                self.mySelectedDocument.removeAll(where: { $0 == self.myDocuments[indexPath.row - self.myFolders.count].documentName })
            }
        }
    }
}




//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------




// MARK: - VN Document Camera View Controller Delegates

extension HomeVC: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
        var rawImages: [UIImage] = [UIImage]()
        
        for pageNumber in 0..<scan.pageCount {
            
            let image = scan.imageOfPage(at: pageNumber)
            rawImages.append(image)
        }
        
        if scan.pageCount == 1 {
            
            if let imageData = rawImages.first?.jpegData(compressionQuality: 0.9) {
                
                self.writeDocumentToRealm(folderName: self.folderName, documentName: "Doc", documentData: imageData, documentSize: Int(imageData.getSizeInMB()))
            }
        }
        else {
            
            let createdCustomFolderName = "Custom\(Date.getCurrentTime())"
            
            for rawImage in 0..<rawImages.count {
                
                if let imageData = rawImages[rawImage].jpegData(compressionQuality: 0.9) {
                    
                    self.writeFolderToRealm(folderName: createdCustomFolderName)
                    
                    self.writeDocumentToRealm(folderName: createdCustomFolderName, documentName: "Doc", documentData: imageData, documentSize: Int(imageData.getSizeInMB()))
                }
            }
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        print(error.localizedDescription)
        controller.dismiss(animated: true)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}
