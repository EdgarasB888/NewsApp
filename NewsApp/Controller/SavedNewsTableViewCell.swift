//
//  FavouriteNewsTableViewCell.swift
//  NewsApp
//
//  Created by iMac on 2022-08-25.
//

import UIKit

class SavedNewsTableViewCell: UITableViewCell
{
    @IBOutlet weak var savedNewsTitleLabel: UILabel!
    @IBOutlet weak var savedNewsImageView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
