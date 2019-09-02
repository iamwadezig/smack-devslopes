//
//  MessageCell.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 02/09/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var avatarLabel: CircleImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(message: Message) {
        
        messageLabel.text = message.message
        nameLabel.text = message.userName
        avatarLabel.image = UIImage(named: message.userAvatar)
        avatarLabel.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
    }

}
