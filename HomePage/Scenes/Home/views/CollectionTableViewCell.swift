//
//  AdsTableViewCell.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import UIKit

class collectionTableViewCell: UITableViewCell {

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        setupUI()
    }
    
    private func setupUI(){
        imagesCollectionView.register(UINib(nibName: String(describing: AdImageCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AdImageCollectionViewCell.self))
    }
    
    func setAdsData(){
        
    }
}


//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension collectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AdImageCollectionViewCell.self), for: indexPath) as! AdImageCollectionViewCell
        return cell
    }
}
