//
//  HomeViewController.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit

// MARK: Home VC

class HomeVC: UIViewController {
    
    // MARK: - Variables
    
    var galaryButtonSelected: Bool = true
    var folderButtonSelected: Bool = false
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var galaryButton: UIButton!
    @IBOutlet weak var folderButton: UIButton!
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Library", preferredLargeTitle: true)
        
        setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        
        setNavigationElements()
        
        setGalaryButtonColor()
        
        setFolderButtonColor()
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
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Add Folder
    
    @IBAction func addFolderPressed(_ sender: UIButton) {
        print(#function)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Folders
    
    @IBAction func foldersPressed(_ sender: UIButton) {
        print(#function)
        
        self.folderButtonSelected = true
        self.galaryButtonSelected = false
        
        setFolderButtonColor()
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Galary
    
    @IBAction func galaryPressed(_ sender: UIButton) {
        print(#function)
 
        self.galaryButtonSelected = true
        self.folderButtonSelected = false
        
        setGalaryButtonColor()
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
            scannerVC.modalPresentationStyle = .fullScreen
            self.present(scannerVC, animated: true, completion: nil)
        }
    }
}
