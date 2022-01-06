//
//  HomeViewController.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    enum SectionHeaders{
        case Search
        case Ads
        case Categories
        case Line
    }
    
    private var timer = Timer()
    private var didUserScroll = false
    private var counter = 0
    private var sections: [SectionHeaders] = []
    private var sectionsCountWithoutLinesCount: Int = 0
    private var data: HomeData?{
        didSet{
            guard let data = data else {
                return
            }
            sections.append(.Search)
            sectionsCountWithoutLinesCount+=1
            
            if !data.result.offers.isEmpty{
                sections.append(.Ads)
                sectionsCountWithoutLinesCount+=1
            }
            
            if !data.result.categories.isEmpty{
                sections.append(.Categories)
                sectionsCountWithoutLinesCount+=1
            }
            
            data.result.main.forEach { _ in
                sections.append(.Line)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
    }
    
    @objc private func changeImage(){
        guard !didUserScroll else {return}
        if counter < 16{
            counter += 1
        }else{
            counter = 0
        }
        if let cell = homeCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? HorizontalCollectionViewCell{
            cell.scrollToIndex(index: counter)
        }
    }
    
    private func setupUI(){
        homeCollectionView.isHidden = true
        homeCollectionView.register(UINib(nibName: String(describing: HorizontalCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: HorizontalCollectionViewCell.self))
        homeCollectionView.register(UINib(nibName: String(describing: StoreCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: StoreCollectionViewCell.self))
        homeCollectionView.register(UINib(nibName: String(describing: LinesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: LinesCollectionViewCell.self))
        homeCollectionView.register(UINib(nibName: String(describing: SearchCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SearchCollectionViewCell.self))
        homeCollectionView.register(UINib(nibName: String(describing: HeaderCollectionReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCollectionReusableView.self))
    }
    
    private func fetchData(){
        APIRoute.shared.fetchRequest(clientRequest: .GetData, decodingModel: HomeData.self) { [weak self] (result) in
            switch result{
            case .success(let data):
                self?.data = data
                self?.homeCollectionView.reloadData()
                self?.homeCollectionView.isHidden = false
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (sections[section] == .Line && data?.result.main[section - sectionsCountWithoutLinesCount].viewType == "vertical") ? (data?.result.main[section - sectionsCountWithoutLinesCount].stores.count ?? 0) : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section]{
        case .Search:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCollectionViewCell.self), for: indexPath) as! SearchCollectionViewCell
            return cell
        case .Ads:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HorizontalCollectionViewCell.self), for: indexPath) as! HorizontalCollectionViewCell
            cell.setData(section: .Ads, offers: data?.result.offers)
            cell.didScroll = { [weak self] in
                self?.didUserScroll = true
            }
            return cell
        case .Categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HorizontalCollectionViewCell.self), for: indexPath) as! HorizontalCollectionViewCell
            cell.setData(section: .Categories, categories: data?.result.categories)
            return cell
        case .Line:
            switch data?.result.main[indexPath.section - sectionsCountWithoutLinesCount].viewType{
            case "vertical":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StoreCollectionViewCell.self), for: indexPath) as! StoreCollectionViewCell
                if let data = data{
                    cell.setData(store: data.result.main[indexPath.section - sectionsCountWithoutLinesCount].stores[indexPath.row])
                }
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LinesCollectionViewCell.self), for: indexPath) as! LinesCollectionViewCell
                if let data = data{
                    cell.setData(main: data.result.main[indexPath.section - sectionsCountWithoutLinesCount])
                }
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard sections[section] == .Line, data?.result.main[section - sectionsCountWithoutLinesCount].viewType == "vertical" else {
            return 0
        }
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard sections[section] == .Line, data?.result.main[section - sectionsCountWithoutLinesCount].viewType == "vertical" else {
            return 0
        }
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sections[indexPath.section]{
        case .Ads:
            return CGSize(width: collectionView.frame.width, height: 400)
        case .Categories:
            return CGSize(width: collectionView.frame.width, height: 200)
        case .Search:
            return CGSize(width: collectionView.frame.width, height: 160)
        case .Line:
            guard data?.result.main[indexPath.section - sectionsCountWithoutLinesCount].viewType == "vertical" else {
                return CGSize(width: collectionView.frame.width, height: 330)
            }
            return CGSize(width: collectionView.frame.width/2 - 4, height: 330)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: HeaderCollectionReusableView.self), for: indexPath) as! HeaderCollectionReusableView
        switch sections[indexPath.section]{
        case .Categories:
            sectionHeader.setData(title: "Shop by category")
            return sectionHeader
        case .Line:
            sectionHeader.setData(title: data?.result.main[indexPath.section - sectionsCountWithoutLinesCount].titleEn ?? "")
            return sectionHeader
        default:
            assert(false, "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard sections[section] != .Ads , sections[section] != .Search else { return CGSize(width: collectionView.frame.width, height: 0)}
        return CGSize(width: collectionView.frame.width, height: 48)
    }
}
