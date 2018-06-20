//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by Tang Jiasheng on 2018/6/19.
//  Copyright © 2018 Jiasheng Tang. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var todoMainLabel: UILabel!
    @IBOutlet weak var todoSecondaryLabel: UILabel!
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
