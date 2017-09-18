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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Arreglar la UI para mostrar que no hay fotos.
        // Configurar la collection view
    }
    
    // 2. Sacar una foto
    
    // Compartir una foto
    
    // Guardar una foto en la galería
        
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
        // Quitar el picker controller.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // a. Obtener una imagen desde el dictionary de info y si no hay imagen,
        //   quitar el picker controller.
        // b. Arreglar la UI para mostrar que ya hay una foto.
        // c. Limpiar la image view.
        // d. Agregar una imagen en la image view.
        // e. Detectar los rostros en la imagen.
        // f. Quitar el picker controller.
    }
}

/*
extension EditorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Necesitamos una celda por cada emoji.
        // Devolver la cantidad de emojis.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Obtener la celda
        // Configurar la celda con el emoji actual
        // Si la celda esta seleccionada, mostrar un color celeste
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Solo haremos alguna accion si el emoji seleccionado no estaba seleccionado previamente.
        // Creamos una image view por cada image view que teniamos
        // A cada image view le ponemos la imagen del emoji seleccionado
        // Insertamos estas image views como subviews de la image view
        // Realizamos una transición
        // Actualizamos el indice seleccionado.
        // Recargamos la collection view
    }
}
*/
