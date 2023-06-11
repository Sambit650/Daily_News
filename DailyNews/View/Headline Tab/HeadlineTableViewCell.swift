//
//  HeadlineTableViewCell.swift
//  DailyNews
//
//  Created by Jovial on 9/2/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var newsTitle: UILabel!
  @IBOutlet weak var newsTime: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    newsImage.layer.cornerRadius = 10
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
