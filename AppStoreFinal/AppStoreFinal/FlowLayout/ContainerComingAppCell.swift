//
//  ContainerComingAppCell.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 30/08/2022.
//

import UIKit

class ContainerComingAppCell: UICollectionViewCell {
    
    let ComingAppCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(ComingAppCollectionView)
        
        ComingAppCollectionView.delegate = self
        ComingAppCollectionView.dataSource = self
        
        ComingAppCollectionView.register(ComingSoonCell.self, forCellWithReuseIdentifier: "comingSoon")
        
        NSLayoutConstraint.activate([
            ComingAppCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            ComingAppCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ComingAppCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ComingAppCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
}

extension ContainerComingAppCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2, height: frame.height-80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
    }
}

extension ContainerComingAppCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var AppCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comingSoon", for: indexPath) as? ComingSoonCell{
            cell.configure()
            
            AppCell = cell
        }
        
        return AppCell
    }
    
    
}
