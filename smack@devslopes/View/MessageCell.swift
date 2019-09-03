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
        
        //timestamp parse from JSON we got
        //2017-07-13T21:49:25.590Z

        //endIndex from end ie. "Z" then -5 character ie ".590Z"
        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        //so we get 2017-07-13T21:49:25
        isoDate = String(isoDate[..<end])
        //
        let isoFormatter = ISO8601DateFormatter()
        //change string into ISO8601Date format, transform from 2017-07-13T21:49:25.590Z to 2017-07-13T21:49:25Z
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        //use another dateformatter so its more readable 
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDate
        }
    }
}
