//
//  ViewController.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 29/08/2022.
//

import UIKit


class ViewController: UIViewController , ContainerComingAppCellDelegate{
    
    var collectionView: UICollectionView!
    var featureApp: FeaturedApps?
    var appCategories: [AppCategory]?
    
    var isIOSLargerThan13: Bool {
        if #available(iOS 17.0, *){
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var layout : Any
        
        AppCategory.fetchFeaturedApps { (featureApp) -> () in
            self.featureApp = featureApp
            self.appCategories = featureApp.categories
            self.collectionView.reloadData()
        }
        
        if (isIOSLargerThan13){
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
        
        if (isIOSLargerThan13){
            collectionView.register(HotAppCell.self, forCellWithReuseIdentifier: "hotcell")
            collectionView.register(ComingSoonCell.self, forCellWithReuseIdentifier: "comingsooncell")
            
        }
        else{
            collectionView.register(ContainerHotAppCell.self, forCellWithReuseIdentifier: "hotcontainer")
            collectionView.register(ContainerComingAppCell.self, forCellWithReuseIdentifier: "comingcontainer")
            collectionView.contentInset = .init(top: 10, left: 20, bottom: 10, right: 10)
        }
        
        
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
    
    func showApp(app: App){
        print(app)
        
        let dialogMessage = UIAlertController(title: app.Name, message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
}

//UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section==0){
            return CGSize(width: collectionView.frame.size.width, height: 370)}
        else{
            return CGSize(width: collectionView.frame.size.width, height: 270)}
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:80)
    }
    
    
}

//UICollectionViewDelegate vs UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isIOSLargerThan13 ? 10 : 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return appCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var appCell = UICollectionViewCell()
        
        if (isIOSLargerThan13){
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
        }
        
        else{
            switch(indexPath.section){
            case 0:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotcontainer", for: indexPath) as? ContainerHotAppCell{
                    
                    cell.config(listApp: appCategories![indexPath.section].apps!)
                    
                    appCell = cell
                }
                
            default:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comingcontainer", for: indexPath) as? ContainerComingAppCell{
                    
                    cell.config(listApp: appCategories![indexPath.section].apps!)
                    cell.delegate = self
                    
                    appCell = cell
                }
            }
        }
        
        return appCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            
            header.config(title: appCategories![indexPath.section].name!)
           
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

