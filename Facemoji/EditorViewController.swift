//
//  EditorViewController.swift
//  Facemoji
//
//  Created by Fernando Ortiz on 9/9/17.
//  Copyright © 2017 Fernando Ortiz. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    
    @IBOutlet weak var emptyPhotoContainer: UIView!
    @IBOutlet weak var takenPhotoContainer: UIView!
    
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedEmojiIndex = 0
    var emojiImageViews: [UIImageView] = []
    var emojis = [#imageLiteral(resourceName: "emoji-1"), #imageLiteral(resourceName: "emoji-2"), #imageLiteral(resourceName: "emoji-3"), #imageLiteral(resourceName: "emoji-4"), #imageLiteral(resourceName: "emoji-5"), #imageLiteral(resourceName: "emoji-6")]
    
    var photoPicker: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEmptyPhotoContainer()
        emojiCollectionView.delegate = self
        emojiCollectionView.dataSource = self
    }
    
    @IBAction func takeAPhotoButtonPressed() {
        if photoPicker == nil {
            photoPicker = UIImagePickerController()
            photoPicker?.allowsEditing = true
            photoPicker?.sourceType = .camera
            photoPicker?.delegate = self
        }
        self.present(photoPicker!, animated: true, completion: nil)
    }
    
    @IBAction func sharePhoto() {
        guard let image = imageView.snapshot else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func savePhoto() {
        guard let image = imageView.snapshot else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(photoSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func photoSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            alert("La foto ha sido guardada")
        } else {
            alert("Ha ocurrido un error")
        }
    }
        
}

private extension EditorViewController {
    func showTakenPhotoContainer() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        emptyPhotoContainer.isHidden = true
        takenPhotoContainer.isHidden = false
    }
    
    func showEmptyPhotoContainer() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        emptyPhotoContainer.isHidden = false
        takenPhotoContainer.isHidden = true
    }
}

extension EditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        showTakenPhotoContainer()
        clearImageView()
        imageView.image = image
        detectFacesOnImage()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func detectFacesOnImage() {
        guard let image = imageView.image else { return }
        let facesBounds = image.getFacesBounds(for: imageView, extendedBy: 0.5)
        
        for bounds in facesBounds {
            let indicator = UIImageView(frame: bounds)
            indicator.image = emojis[selectedEmojiIndex]
            indicator.backgroundColor = UIColor.clear
            indicator.contentMode = .scaleAspectFit
            imageView.addSubview(indicator)
            emojiImageViews.append(indicator)
        }
    }
    
    func clearImageView() {
        for imageView in emojiImageViews {
            imageView.removeFromSuperview()
        }
        emojiImageViews = []
    }
}

extension EditorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditorEmojiCollectionViewCell", for: indexPath) as! EditorEmojiCollectionViewCell
        
        let emoji = emojis[indexPath.row]
        cell.configure(with: emoji)
        
        if indexPath.row == selectedEmojiIndex {
            cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedEmojiIndex != indexPath.row else { return }
        
        var newEmojiImageViews = [UIImageView]()
        
        let transitionOptions: UIViewAnimationOptions = {
            if selectedEmojiIndex < indexPath.row {
                return [.curveEaseInOut, .transitionFlipFromLeft]
            } else {
                return [.curveEaseInOut, .transitionFlipFromRight]
            }
        }()
        
        for imageView in emojiImageViews {
            let newImageView = UIImageView(frame: imageView.frame)
            newImageView.contentMode = .scaleAspectFit
            newImageView.image = emojis[indexPath.row]
            imageView.addSubview(newImageView)
            UIView.transition(
                from: imageView,
                to: newImageView,
                duration: 0.4,
                options: transitionOptions,
                completion: { completed in
                    if completed {
                        imageView.removeFromSuperview()
                    }
                }
            )
            newEmojiImageViews.append(newImageView)
        }
        emojiImageViews = newEmojiImageViews
        selectedEmojiIndex = indexPath.row
        collectionView.reloadData()
    }
}
