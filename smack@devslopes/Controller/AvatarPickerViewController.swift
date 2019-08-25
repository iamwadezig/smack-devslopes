//
//  AvatarPickerViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 24/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func segmentPressed(_ sender: Any) {
    }
}

extension AvatarPickerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCollectionViewCell {
            
            return cell
        }
        
        return AvatarCollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    
}

extension AvatarPickerViewController: UICollectionViewDelegate {
    
    
    
}

extension AvatarPickerViewController: UICollectionViewDelegateFlowLayout{
    
    
}
