//
//  Support.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit
import AVFoundation
import RealmSwift
import Toast_Swift

// MARK: - Custom Navigation Bar Design and Function


extension UIViewController {
    
    func setCustomNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title
            
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: Custom View Background Color
    
    func setViewCustomColor(view: UIView, color: UIColor) {
        
        view.backgroundColor = color
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Write Folder To Realm
    
    func writeFolderToRealm(folderName: String) {
        
        let realm = try! Realm() // realm object
        let disk = Disk() // disk object
        let myFolder = Folders() // folder object
        
        realm.beginWrite()
        
        let folder = realm.objects(Folders.self).filter("folderName == '\(folderName)'")
        
        if folderName != folder.first?.folderName {
            
            myFolder.folderName = folderName
            myFolder.folderDateAndTime = Date.getCurrentDateAndTime()
            
            disk.folders.append(myFolder)
            
            realm.add(disk)
            do {
                try realm.commitWrite()
                self.showToast(message: "Folder Created", duration: 3.0)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        else {
            self.showToast(message: "Folder Exists", duration: 3.0)
            realm.cancelWrite()
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Write Document To Realm
    
    func writeDocumentToRealm(documentName: String, documentData: Data, documentSize: Int) {
        
        let realm = try! Realm() // realm object
        let document = Documents() // document object
        
        realm.beginWrite()
        
        let filteredfolder = realm.objects(Folders.self).filter("folderName == 'Default'")
        let filteredDocument = realm.objects(Documents.self).filter("documentName == '\(documentName)'")
        
        if documentName != filteredDocument.first?.documentName {
            
            document.documentName = documentName + Date.getCurrentTime()
            document.documentData = documentData
            document.documentSize = documentSize
            document.documentDateAndTime = Date.getCurrentDateAndTime()
            
            filteredfolder.first?.documents.append(document)
            
            realm.add(document)
            do {
                try realm.commitWrite()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        else {
            self.showToast(message: "Document Exists", duration: 4.0)
            realm.cancelWrite()
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Read Document From Realm
    
    func readDocumentFromRealm(sortBy: String) -> [Documents] {
        
        let realm = try! Realm() // realm object
        var myDocuments = [Documents]()
        
        let folders = realm.objects(Folders.self).filter("folderName == 'Default'")
        
        for folder in folders {
            
            for document in folder.documents.sorted(byKeyPath: sortBy, ascending: false) {
                
                myDocuments.append(document)
            }
        }
        return myDocuments
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Read Folder From Realm
    
    func readFolderFromRealm(sortBy: String) -> [Folders] {
        
        let realm = try! Realm() // realm object
        
        var myFolders = [Folders]()
        
        let folders = realm.objects(Folders.self).sorted(byKeyPath: sortBy, ascending: false)
        
        for folder in folders {
            
            myFolders.append(folder)
        }
        return myFolders
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Delete Folder From Realm
    
    func deleteFolderFromRealm(folderName: String) {
        
        let realm = try! Realm() // realm object
        
        realm.beginWrite()
        
        let folder = realm.objects(Folders.self).filter("folderName == '\(folderName)'")
        
        if folderName == folder.first?.folderName {
            
            realm.delete(folder)
            
            do {
                try realm.commitWrite()
                self.showToast(message: "Folder(s) Deleted", duration: 3.0)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        else {
            self.showToast(message: "No Folder Deleted", duration: 3.0)
            realm.cancelWrite()
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Toast
    
    func showToast(message: String, duration: Double) {
        
        var toastStyle = ToastStyle()
        toastStyle.messageColor = .white
        toastStyle.backgroundColor = .black
        
        self.view.makeToast(message, duration: duration, position: .bottom, style: toastStyle)
    }
    
}


//-------------------------------------------------------------------------------------------------------------------------------------------------


// MARK:- Use Hex Code For Color Selection

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hex: "ff0000") // return red color for wrong hex input
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Get Image Size In MB

extension Data {
    
    func getSizeInMB() -> Double {
        return (Double(self.count) / 1024 / 1024).rounded()
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Get Current Date Helper

extension Date {
    
    static func getCurrentDateAndTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        return dateFormatter.string(from: Date())
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Zoom In An UIImage View

extension UIImageView {
    
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    
    @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
        
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
