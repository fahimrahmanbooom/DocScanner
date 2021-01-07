//
//  ScannerViewController.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 8/1/21.
//

import UIKit

// MARK: - Scanner VC

class ScannerVC: UIViewController {
    
    // MARK: - Variables
    
    var flashButtonSelected: Bool = false
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var cameraView: UIView!
    
    // MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewCustomColor(view: self.view, color: .white)
        setViewCustomColor(view: self.cameraView, color: .black)
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Cancel 
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        print(#function)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Single
    
    @IBAction func singlePressed(_ sender: UIButton) {
        print(#function)
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Batch
    
    @IBAction func batchPressed(_ sender: UIButton) {
        print(#function)
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Flash
    
    @IBAction func flashPressed(_ sender: UIButton) {
        print(#function)
        
        self.flashButtonSelected = !self.flashButtonSelected
        toggleTorch(on: self.flashButtonSelected)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - Scan
    
    @IBAction func scanPressed(_ sender: UIButton) {
        print(#function)
        
    }
}
