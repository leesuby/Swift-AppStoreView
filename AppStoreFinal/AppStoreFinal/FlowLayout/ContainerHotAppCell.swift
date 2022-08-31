//
//  ContainerHotAppCell.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 30/08/2022.
//

import Foundation
import UIKit
class ContainerHotAppCell: UICollectionViewCell{
    
    var containerApp: [App]?
    
    var HotAppCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(HotAppCollectionView)
        
        HotAppCollectionView.dataSource = self
        HotAppCollectionView.delegate = self
        
        HotAppCollectionView.register(HotAppCell.self, forCellWithReuseIdentifier: "app")
        
        NSLayoutConstraint.activate([
            HotAppCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            HotAppCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            HotAppCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            HotAppCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }
    
    func config(listApp : [App]){
        self.containerApp = listApp
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}


extension ContainerHotAppCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40 , height: frame.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -50, left: 20, bottom: 0, right: 0)
    }
}


extension ContainerHotAppCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return containerApp?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tmpCell = UICollectionViewCell()
        if let cell = HotAppCollectionView.dequeueReusableCell(withReuseIdentifier: "app", for: indexPath) as? HotAppCell{
            
            cell.configure()
            
            return cell
        }
        return tmpCell
    }
    
}
