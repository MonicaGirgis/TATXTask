//
//  StoreCollectionViewCell.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var deliveryFeesLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        addToCartButton.makeRoundedCornersWith(radius: 8.0)
    }
    
    func setData(store: Store){
        productNameLabel.text = store.nameEn
        categoryTitleLabel.text = store.category.nameEn
        deliveryFeesLabel.text = "\(store.deliveryFees)"
        deliveryTimeLabel.text = store.deliveryTimeEn
        productImageView.kf.setImage(with: URL(string: Bundle.main.storesImagesURL + "/" + store.image))
    }

}
