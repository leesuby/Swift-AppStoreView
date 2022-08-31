//
//  HotAppCell.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 29/08/2022.
//

import Foundation
import UIKit
class HotAppCell: UICollectionViewCell {
    
    
    let tagline = UILabel()
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    let avatar = UIImageView()
    let buyButton = UIButton(type: .custom)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue
        
        
        imageView.layer.cornerRadius = 5
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        
        avatar.layer.cornerRadius = 30
        avatar.contentMode = .scaleAspectFit
        
        
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        
        avatar.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
        innerStackView.axis = .vertical
        
        let outerStackView = UIStackView(arrangedSubviews: [avatar, innerStackView, buyButton])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.axis = .horizontal
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        
        
        let stackView = UIStackView(arrangedSubviews: [separator, tagline, imageView, outerStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        
        contentView.addSubview(stackView)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 10
        
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
        
    }
    
    func configure() {
        tagline.text = "NOW AVAILABLE"
        name.text = "Genshin Impact"
        subtitle.text = "Explore a Wolrd of Adventure"
        imageView.image = UIImage(named: "GenshinBanner")
        avatar.image = UIImage(named: "GenshinLogo")
    }
    
    func configure(app : App){
        name.text = app.Name
        subtitle.text = app.Category
        imageView.image = UIImage(named: app.ImageName!)
        avatar.image = UIImage(named: app.ImageName!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }
}
