//
//  ViewController.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 29/08/2022.
//

import UIKit


class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var layout : Any
        if #available(iOS 13.0, *){
            //Compositional Layout
            layout = CompositionalLayout.createCompositionalLayout()
        }else{
            //Flow Layout
            layout = UICollectionViewFlowLayout()
        
        }


        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout as! UICollectionViewLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(HotAppCell.self, forCellWithReuseIdentifier: "hotcell")
        collectionView.register(ComingSoonCell.self, forCellWithReuseIdentifier: "comingsooncell")
        
        setView()
        setContraint()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        
        view.addSubview(collectionView)
        collectionView.delegate=self
        collectionView.dataSource=self
        
    }
    
    func setContraint(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive=true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive=true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive=true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive=true
    }
    
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section==0) {
            return CGSize(width: 100, height:100)
        } else{
            return CGSize(width: 100, height:133)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var appCell = UICollectionViewCell()
        
        switch(indexPath.section){
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotcell", for: indexPath) as? HotAppCell{
                cell.configure()
                appCell = cell
            }
        default:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comingsooncell", for: indexPath) as? ComingSoonCell{
                cell.configure()
                appCell = cell
            }
        }
        
        return appCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            if (indexPath.section == 0){
                header.config(title: "Don't Miss These Event")
            }
            else{
                header.config(title: "Coming Soon", subtitle: "Pre-order now, play later")
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}
