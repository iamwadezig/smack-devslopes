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
    
    //Variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func segmentPressed(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = AvatarType.dark
        } else if segmentControl.selectedSegmentIndex == 1 {
            avatarType = AvatarType.light
        }
        collectionView.reloadData()
        
    }
    //set the dimension and number of coloumn inside collection view depending on the device, ie iphone se will be narrower than iphone x max therefore iphone x max can contain more coloumns
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColoumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColoumns = 4
        }
        
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColoumns - 1) * spaceBetweenCells) / numberOfColoumns
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
}

extension AvatarPickerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCollectionViewCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        
        return AvatarCollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        print(UserDataService.instance.avatarName)
        self.dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    
}

extension AvatarPickerViewController: UICollectionViewDelegate {
    
    
    
}

extension AvatarPickerViewController: UICollectionViewDelegateFlowLayout{
    
    
}
