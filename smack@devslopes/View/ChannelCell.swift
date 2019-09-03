//
//  ChannelCell.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 28/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //Outlets
    
    @IBOutlet weak var channelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    //do something with its background color when the cell selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
            
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
    }
    
    func configureCell(channel: Channel) {
        
        let title = channel.channelTitle ?? ""
        channelLabel.text = "#\(title)"
        channelLabel.font = UIFont(name: "Avenir-Book", size: 20)
        //unread channel
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelLabel.font = UIFont(name: "Avenir-Heavy", size: 22)
            }
        }
    }

}
