//
//  imageEditVC.swift
//  MobInstagram
//
//  Created by wenbin Chen on 25/9/18.
//  Copyright © 2018 wenbin Chen. All rights reserved.
//

import UIKit
import CoreImage

class imageEditVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var filter3Btn: UIButton!
    @IBOutlet var filter2Btn: UIButton!
    @IBOutlet var filter1Btn: UIButton!
    @IBOutlet var picImg: UIImageView!
    
    @IBOutlet var contrastSlid: UISlider!
    @IBOutlet var brightSlid: UISlider!
    
    //variable store the picked photo
    var img : UIImage = UIImage(named: "pbg.jpg")!
    var filteredCIImage : CIImage = CIImage()
    var adjustedCIImage : CIImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picTap = UITapGestureRecognizer(target: self, action: #selector(imageEditVC.selectImg))
        picTap.numberOfTapsRequired = 1
        picImg.isUserInteractionEnabled = true
        picImg.addGestureRecognizer(picTap)
        
        brightSlid.maximumValue = 0.2
        brightSlid.minimumValue = -0.2
        brightSlid.value = 0
        contrastSlid.maximumValue = 2
        contrastSlid.minimumValue = 0
        contrastSlid.value = 1
        
        
    }
    
    //select image from camera or album
    @objc func selectImg(){
        var alert: UIAlertController!
        alert = UIAlertController(title: "Pick Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cleanAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel,handler:nil)
        let cameraAction = UIAlertAction(title: "camera", style: UIAlertAction.Style.default){(action:UIAlertAction)in
            self.cameraImg()
        }
        let albumAction = UIAlertAction(title: "album", style: UIAlertAction.Style.default){ (action:UIAlertAction)in
            self.albumImg()
        }
        alert.addAction(cleanAction)
        alert.addAction(cameraAction)
        alert.addAction(albumAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //pick image from album
    @objc func albumImg(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //pick image from camera
    @objc func cameraImg(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo
            
            let overlayImage = UIImageView(image: UIImage(named: "grid.png"))
            let overlayRect = CGRect(x:0, y:20, width:415, height: 600)
            overlayImage.frame = overlayRect
            imagePicker.cameraOverlayView = overlayImage
            
            
            self.present(imagePicker, animated: true, completion: nil)
        }else {
            
        }
    }
    
    //delegate function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picImg.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        img = picImg.image!
        self.filteredCIImage = CIImage(image: img)!
        self.adjustedCIImage = CIImage(image: img)!
        self.dismiss(animated: true, completion: nil)
    }

    //clicking confirm button to send image to upload view and go to that view
    @IBAction func confirmBtn_click(_ sender: Any) {
        let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: "uploadVC") as! uploadVC
        uploadVC.img = picImg.image!
        uploadVC.ciImage = self.adjustedCIImage
        self.navigationController?.pushViewController(uploadVC, animated: true)
    }
    
    //three filters
    @IBAction func filter1Btn_click(_ sender: Any) {
        let ciImage = CIImage(image: img)
        let color = CIColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 0.5)
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(color, forKey: kCIInputColorKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        picImg.image = UIImage(ciImage:outImage!)
        self.filteredCIImage = outImage!
        self.adjustedCIImage = outImage!
        
        filter1Btn.setTitleColor(.white, for: UIControl.State())
        filter1Btn.backgroundColor = .blue
        filter2Btn.setTitleColor(.blue, for: UIControl.State())
        filter2Btn.backgroundColor = .white
        filter3Btn.setTitleColor(.blue, for: UIControl.State())
        filter3Btn.backgroundColor = .white
    }
    
    @IBAction func filter2Btn_click(_ sender: Any) {
        let ciImage = CIImage(image: img)
        let color = CIColor(red: 0.4, green: 0.8, blue: 0.6, alpha: 0.5)
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(color, forKey: kCIInputColorKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        picImg.image = UIImage(ciImage:outImage!)
        self.filteredCIImage = outImage!
        self.adjustedCIImage = outImage!
        
        filter1Btn.setTitleColor(.blue, for: UIControl.State())
        filter1Btn.backgroundColor = .white
        filter2Btn.setTitleColor(.white, for: UIControl.State())
        filter2Btn.backgroundColor = .blue
        filter3Btn.setTitleColor(.blue, for: UIControl.State())
        filter3Btn.backgroundColor = .white
    }
    
    @IBAction func filter3Btn_click(_ sender: Any) {
        let ciImage = CIImage(image: img)
        let color = CIColor(red: 0.6, green: 0.4, blue: 0.8, alpha: 0.5)
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(color, forKey: kCIInputColorKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        picImg.image = UIImage(ciImage:outImage!)
        self.filteredCIImage = outImage!
        self.adjustedCIImage = outImage!
        
        filter1Btn.setTitleColor(.blue, for: UIControl.State())
        filter1Btn.backgroundColor = .white
        filter2Btn.setTitleColor(.blue, for: UIControl.State())
        filter2Btn.backgroundColor = .white
        filter3Btn.setTitleColor(.white, for: UIControl.State())
        filter3Btn.backgroundColor = .blue
    }
    
    //change brightness
    @IBAction func brightValueChanged(_ sender: Any) {
        let ciImage = self.filteredCIImage
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(brightSlid.value, forKey: kCIInputBrightnessKey)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        picImg.image = UIImage(ciImage:outImage!)
        self.adjustedCIImage = outImage!
        
    }
    
    //change contrast
    @IBAction func contrastValueChanged(_ sender: Any) {
        let ciImage = self.filteredCIImage
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(contrastSlid.value, forKey: kCIInputContrastKey)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        picImg.image = UIImage(ciImage:outImage!)
        self.adjustedCIImage = outImage!
    }
}
