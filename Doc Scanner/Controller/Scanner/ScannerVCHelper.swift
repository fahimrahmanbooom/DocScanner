//
//  ScannerVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 8/1/21.
//

import UIKit
import AVFoundation

// MARK: -  Scannner VC Helper

extension ScannerVC {
    
    // MARK: - Flashlight
    
    func toggleTorch(on: Bool) {
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                on == true ? (device.torchMode = .on) : (device.torchMode = .off)
                device.unlockForConfiguration()
                
            } catch { print(#function) }
        }
    }
}
