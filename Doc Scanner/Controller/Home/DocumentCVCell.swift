//
//  DocumentCVCell.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 9/1/21.
//

import UIKit

// MARK: - Document Collection View Cell

class DocumentCVCell: UICollectionViewCell {

    // MARK: -  Outlets
    
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var numberOfDocumentsLabel: UILabel!
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
