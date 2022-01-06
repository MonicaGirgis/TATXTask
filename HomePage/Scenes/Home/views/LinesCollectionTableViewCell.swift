//
//  LinesCollectionTableViewCell.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import UIKit

class LinesCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var linesCollectionView: UICollectionView!
    
    private var stores: [Store] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        linesCollectionView.register(UINib(nibName: String(describing: StoreCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: StoreCollectionViewCell.self))
    }
    
    func setData(main: Main){
        let viewLayout = linesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        viewLayout.scrollDirection = main.viewType == "vertical" ? .vertical : .horizontal
        stores = main.stores
        linesCollectionView.reloadData()
    }
}


//MARK:- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension LinesCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StoreCollectionViewCell.self), for: indexPath) as! StoreCollectionViewCell
        cell.setData(store: stores[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width/2 - 4, height: collectionView.frame.height)
    }
}
