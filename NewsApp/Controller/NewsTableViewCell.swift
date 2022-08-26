//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by iMac on 2022-08-24.
//

import UIKit

class NewsTableViewCell: UITableViewCell
{
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
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
