//
//  HeaderCollectionReusableView.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 06/01/2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(title: String){
        titleLabel.text = title
    }
}
