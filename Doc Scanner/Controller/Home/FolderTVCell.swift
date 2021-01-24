//
//  FolderTableViewCell.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 9/1/21.
//

import UIKit

// MARK: - Folder Table View Cell

class docsAndFoldsTVCell: UITableViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var docsAndFoldsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    
    // MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Selected
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
