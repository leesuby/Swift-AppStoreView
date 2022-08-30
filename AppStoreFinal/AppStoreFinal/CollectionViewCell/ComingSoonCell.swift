//
//  ComingSoonCell.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 29/08/2022.
//

import Foundation
import UIKit
class ComingSoonCell: UICollectionViewCell {
    
    let name = UILabel()
    let avatar = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        avatar.layer.cornerRadius = 60
        avatar.contentMode = .scaleAspectFit
        avatar.clipsToBounds = true
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textAlignment = .center
        name.textColor = .label
        
        let stackView = UIStackView(arrangedSubviews: [avatar,name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        contentView.addSubview(stackView)
        
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
        
    }
    
    func configure() {
        name.text = "Genshin Impact"
        avatar.image = UIImage(named: "GenshinLogo")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }
}
