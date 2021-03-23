//
//  ViewController.swift
//  TestCoreML
//
//  Created by Augus on 2021/3/22.
//

import UIKit
import CoreML

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    private var imageView: UIImageView!
    private var showLabel: UILabel!
    
    private var cameraButton: UIButton!
    private var libraryButton: UIButton!
    
    private var kImageWidth = 224.0
    
    var model: Resnet50!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        self.title = "Test Core ML"
        addSubviews();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        print("/(i)")
        
        let config = MLModelConfiguration()
        model = try? Resnet50(configuration: config)

        
    }
    
    // add subview
    
    func addSubviews() -> Void {
        
        // set button
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:.camera,
                                                                target: self,
                                                                action: #selector(leftBarButtonAction(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                                                 target: self,
                                                                 action: #selector(rightBarButtonAction(_:)))
        
        
        // set show image and label
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 299, height: 299)
        imageView.center = self.view.center
        imageView.backgroundColor = .darkGray;
        self.view .addSubview(imageView)
        
        showLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.height + 299, width: self.view.bounds.width, height: 100))
        
        showLabel.backgroundColor = .green
        showLabel.textAlignment = .center
        self.view.addSubview(showLabel)
    
        
    }
    
    
    /// camera action
    @objc func leftBarButtonAction(_ sender: UIBarButtonItem) -> Void {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("camera is not avaible")
            return
        }
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        
        present(cameraPicker, animated: true) {
          
            print("present camera picker")
            
        };
        
        
        
    }
    
    /// library
    @objc func rightBarButtonAction(_ sender: UIBarButtonItem) -> Void {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true) {
            print("present photoLibrary picker")

        };
        
    }

}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true) {
          print("dismiss picker ")
        };
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        showLabel.text = "Analyzing Image ..."
        
        // 异步
        
//        DispatchQueue.global(qos: .userInteractive).async {
//
//            DispatchQueue.main.async {
//
//
//            }
//        }
        guard (info[.originalImage] as? UIImage) != nil else {
            print("data is null")
            return
        }
        
        let img = info[.originalImage] as! UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: kImageWidth, height: kImageWidth), true, 2.0)
        img.draw(in: CGRect(x: 0, y: 0, width: kImageWidth, height: kImageWidth))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard status == kCVReturnSuccess else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let ctxt = CGContext(data: pixelData, width: Int(newImage.size.width), height:Int( newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        ctxt?.translateBy(x: 0, y: newImage.size.height)
        ctxt?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(ctxt!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        
        imageView.image = newImage
        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
            return
        }
        print("class label\(prediction.classLabel)")
        showLabel.text = "I think this is a \(prediction.classLabel)"
        
        self.dismiss(animated: true) {
            
        }
    }
}

