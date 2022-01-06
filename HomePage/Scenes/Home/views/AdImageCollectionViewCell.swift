//
//  AdImageCollectionViewCell.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import UIKit

class AdImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setAdImage(offer: Offer){
        adImageView.kf.setImage(with: URL(string: Bundle.main.offersImagesURL + "/" + (offer.image ?? "")))
    }
}
