//
//  ContainerComingAppCell.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 30/08/2022.
//

import UIKit
protocol ContainerComingAppCellDelegate {
    func showApp(app: App)
}

class ContainerComingAppCell: UICollectionViewCell {
   
    
    var containerApp: [App]?
    var viewController : ViewController?
    var delegate : ContainerComingAppCellDelegate?
    
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
    
    func config(listApp : [App]){
        self.containerApp = listApp
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
}

extension ContainerComingAppCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2, height: frame.height - 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension ContainerComingAppCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return containerApp?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var AppCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comingSoon", for: indexPath) as? ComingSoonCell{
            
            cell.configure(app: containerApp![indexPath.item])
            
            AppCell = cell
        }
        
        return AppCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = containerApp?[indexPath.item] {
            if let del = delegate {
                del.showApp(app: app)
            }
        }
    }
    
}
