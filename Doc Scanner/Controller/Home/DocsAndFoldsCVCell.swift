//
//  DocumentCVCell.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 9/1/21.
//

import UIKit

// MARK: - Document Collection View Cell

class DocsAndFoldsCVCell: UICollectionViewCell {
    
    // MARK: -  Outlets
    
    @IBOutlet weak var docsAndFoldsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Is Selected
    
    override var isSelected: Bool {
        didSet {
            
            self.backgroundColor = isSelected ? UIColor(hex: "EB5757") : UIColor.white
        }
    }
}
