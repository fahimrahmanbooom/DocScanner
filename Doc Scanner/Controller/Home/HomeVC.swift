//
//  HomeViewController.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit
//import RealmSwift

// MARK: Home VC

class HomeVC: UIViewController {
    
    // MARK: - Variables
    
    var galleryButtonSelected: Bool = true
    var folderButtonSelected: Bool = false
    
    var folderTableView: UITableView = UITableView()
    var documentCollectionView: UICollectionView!
    
    var myDocuments = [Documents]()
    var myFolders = [Folders]()
    
    
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
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Library", preferredLargeTitle: true)
        
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        
        self.setNavigationElements()
        
        self.setGalleryButtonColor()
        
        self.setFolderButtonColor()
        
        self.setDocumentCollectionView()
        
        self.myDocuments.removeAll()
        
        self.myDocuments = self.readDocumentFromRealm(sortBy: "documentSize")
        
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
        
        self.myDocuments.removeAll()
        self.myDocuments = self.readDocumentFromRealm(sortBy: "documentSize")
        
        self.myFolders.removeAll()
        self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
        
        self.galleryButtonSelected ?
            self.documentCollectionView.reloadData() :
            self.folderTableView.reloadData()
        
        self.showToast(message: "Synced", duration: 2.0)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        self.myFolders.removeAll()
        self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
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
        
        // MARK: - Folder Button Selected
        
        if self.folderButtonSelected {
            
            self.folderTableView.isEditing = !self.folderTableView.isEditing
            
            self.folderTableView.isEditing ?
                (self.navigationItem.rightBarButtonItem?.title = "Delete") :
                (self.navigationItem.rightBarButtonItem?.title = "Select")
            
            self.folderTableView.reloadData()
        }
        
        
        
        //-------------------------------------------------------------------------------------------------------------------------------------------------
        
        
        
        // MARK: - Gallery Button Selected
        
        if self.galleryButtonSelected {
            
            self.documentCollectionView.allowsMultipleSelection = !self.documentCollectionView.allowsMultipleSelection
            
            self.documentCollectionView.allowsMultipleSelection ?
                (self.navigationItem.rightBarButtonItem?.title = "Delete") :
                (self.navigationItem.rightBarButtonItem?.title = "Select")
            
            self.documentCollectionView.reloadData()
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
        
        self.folderButtonSelected = true
        self.galleryButtonSelected = false
        
        self.folderTableView.isHidden = false
        self.documentCollectionView.isHidden = true
        
        self.documentCollectionView.removeFromSuperview()
        
        self.setFolderButtonColor()
        
        self.setFolderTableView()
        
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Gallery
    
    @IBAction func galleryPressed(_ sender: UIButton) {
        print(#function)
        
        self.galleryButtonSelected = true
        self.folderButtonSelected = false
        
        self.folderTableView.isHidden = true
        self.documentCollectionView.isHidden = false
        
        self.folderTableView.removeFromSuperview()
        
        self.setGalleryButtonColor()
        
        self.setDocumentCollectionView()
        
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Filter
    
    @IBAction func filterPressed(_ sender: UIButton) {
        print(#function)
        
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
        
        if let scannerVC = self.storyboard?.instantiateViewController(withIdentifier: "scannerVC") as? ScannerVC {
            
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(scannerVC, animated: false)
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int { return self.myFolders.count }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Cell For Row At
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = folderTableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! FolderTableViewCell
        
        cell.folderImageView.image = UIImage(data: self.myFolders[indexPath.section].documents.first?.documentData ?? Data())
        cell.folderNameLabel.text = self.myFolders[indexPath.section].folderName
        cell.numberOfDocumentsLabel.text = String(self.myFolders[indexPath.section].documents.count) + " Document(s)"
        
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
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Did Deselect Row At
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print(#function, indexPath.section)
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Document Collection View

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Number Of Items In Section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myDocuments.count
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Cell For Item At
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = documentCollectionView.dequeueReusableCell(withReuseIdentifier: "documentCell", for: indexPath) as! DocumentCVCell
        
        cell.documentImageView.image = UIImage(data: self.myDocuments[indexPath.row].documentData ?? Data())
        cell.documentNameLabel.text = self.myDocuments[indexPath.row].documentName
        cell.numberOfDocumentsLabel.text = "1 Document"
        
        return self.setDocumentCell(cell: cell)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        
        return CGSize(width: size, height: size + 25)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Did Select Item At
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        
        let cell : UICollectionViewCell = self.documentCollectionView.cellForItem(at: indexPath)!
        
        cell.backgroundColor = UIColor(hex: "EB5757")
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Did Deselect Item At
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        
        let cell : UICollectionViewCell = self.documentCollectionView.cellForItem(at: indexPath)!
        
        cell.backgroundColor = .white
    }
}
