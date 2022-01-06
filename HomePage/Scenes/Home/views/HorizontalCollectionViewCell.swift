//
//  HorizontalCollectionViewCell.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 06/01/2022.
//

import UIKit
import AdvancedPageControl

class HorizontalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sectionName: HomeViewController.SectionHeaders?
    var offers: [Offer]?
    var categories: [Category]?
    var didScroll: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        collectionView.register(UINib(nibName: String(describing: AdImageCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AdImageCollectionViewCell.self))
        collectionView.register(UINib(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
    }
    
    func setData(section: HomeViewController.SectionHeaders, offers: [Offer]? = nil, categories: [Category]? = nil){
        sectionName = section
        self.offers = offers
        self.categories = categories
        let count = offers?.count ?? (categories?.count ?? 0) % 4 == 0 ? ((categories?.count ?? 0) / 4) : ((categories?.count ?? 0) / 4 + 1)
        if count == 1{
            //pageController.isHidden = true
        }
        pageController.drawer = ExtendedDotDrawer(numberOfPages: 17, height: 8,space: 4, indicatorColor: .yellow, dotsColor: .lightGray, isBordered: false, borderColor: .lightGray, borderWidth: 1, indicatorBorderColor: .yellow, indicatorBorderWidth: 1)
    }
    
    func scrollToIndex(index: Int){
        guard sectionName == .Ads else {return}
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}


//MARK:- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HorizontalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionName{
        case .Ads:
            return 17
        default:
            return categories?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sectionName{
        case .Ads:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AdImageCollectionViewCell.self), for: indexPath) as! AdImageCollectionViewCell
//            if let offers = offers{
//                cell.setAdImage(offer: offers[indexPath.row])
//            }
            cell.setImage()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as! CategoryCollectionViewCell
            if let categories = categories{
                cell.setData(category: categories[indexPath.row])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch sectionName{
        case .Ads:
            return 0
        default:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch sectionName{
        case .Ads:
            return 0
        default:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sectionName{
        case .Ads:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        default:
            return CGSize(width: collectionView.frame.width/2 - 4, height: collectionView.frame.height/2 - 4)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        
        let index = Int(round(offSet/width))
        pageController.setPage(index)
        guard scrollView.isDragging else {return}
        didScroll?()
    }
}
