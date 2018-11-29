//
//  SelfSizedCollectionCell.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 27.08.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import UIKit
class TitleCell: UIView {
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Initialization and deinitialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
        fromNib()
    }
    
    init() {
        super.init(frame: .zero)
        configureUI()
        fromNib()
    }
    
    
    func configureUI() {
        backgroundColor = .gray
        
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Touches
extension TitleCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
}
extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        contentView.fillSuperview()
        return contentView
    }
}
