//
//  SportView.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 30/10/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import UIKit

class SportView: UIView {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomBorderView: UIView!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    init() {
        super.init(frame: .zero)
        fromNib()
        bottomBorderView.backgroundColor = UIColor.gray
    }
    
    func configure(with sportName: String) {
        titleLabel.text = sportName
    }
    
}
