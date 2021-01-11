//
//  DataModel.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 12/1/21.
//

import Foundation

// MARK: - Data Model

//-------------------------------------------------------------------------------------------------------------------------------------------------


// MARK: - My Documents

struct MyDocuments {
    
    var documentData: Data? = nil
    var documentName: String? = String()
    var documentDateAndTime: String = String()
    var documentSize: Int = Int()
}
