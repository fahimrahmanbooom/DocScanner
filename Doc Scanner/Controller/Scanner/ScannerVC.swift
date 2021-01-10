//
//  ScannerViewController.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 8/1/21.
//

import UIKit
import AVFoundation

// MARK: - Scanner VC

class ScannerVC: UIViewController {
    
    // MARK: - Variables
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    var flashButtonSelected: Bool = false
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var cameraView: UIView!
    
    // MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewCustomColor(view: self.view, color: .white)
        setViewCustomColor(view: self.cameraView, color: .black)
        
        setCameraPreview()
    }

    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - View Will Disappear
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.captureSession?.stopRunning()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Cancel 
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        print(#function)
        
        self.captureSession?.stopRunning()
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
        setToggleFlashlight(on: self.flashButtonSelected)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Scan
    
    @IBAction func scanPressed(_ sender: UIButton) {
        print(#function)
        
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        
        settings.flashMode = .off
        settings.isHighResolutionPhotoEnabled = true
        
        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
    }
}


//-------------------------------------------------------------------------------------------------------------------------------------------------


// MARK: - Scanned Photo Processing

extension ScannerVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        if let image = UIImage(data: imageData) {
            
            // TO-DO: - move to corp page
            print("Photo Size:", image.getSizeInMB(), "MB")
        }
    }
}
