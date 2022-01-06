//
//  SearchCollectionViewCell.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 06/01/2022.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var changeCityButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI(){
        searchBar.makeRoundedCornersWith(radius: 6.0)
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = .white
    }

}
