//
//  ExploreTableViewCell.swift
//  DailyNews
//
//  Created by Jovial on 9/2/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var newsHeader: UILabel!
  @IBOutlet weak var newsPublishTime: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    newsImage.layer.cornerRadius = 10
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
