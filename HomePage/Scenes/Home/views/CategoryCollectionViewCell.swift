//
//  CategoryCollectionViewCell.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        outerView.makeRoundedCornersWith(radius: 8.0)
    }
    
    func setData(category: Category){
        categoryTitleLabel.text = category.nameEn
        categoryImageView.kf.setImage(with: URL(string: Bundle.main.categoriesImagesURL + "/" + (category.image ?? "")))
    }
}
