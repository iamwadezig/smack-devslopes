//
//  AvatarCollectionViewCell.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 25/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}
class AvatarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView () {
        
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
    func configureCell(index: Int, type: AvatarType) {

        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else if type == AvatarType.light {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
}
