//
//  HomeViewController.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    enum SectionHeaders{
        case Ads
        case Categories
        case Line
    }
    
    private var sections: [SectionHeaders] = []
    private var sectionsCountWithoutLinesCount: Int = 0
    private var data: HomeData?{
        didSet{
            guard let data = data else {
                return
            }
            
            if !data.result.offers.isEmpty{
                sections.append(.Ads)
                sectionsCountWithoutLinesCount+=1
            }
            
            if !data.result.categories.isEmpty{
                sections.append(.Categories)
                sectionsCountWithoutLinesCount+=1
            }
            
            if !data.result.main.isEmpty{
                data.result.main.forEach { _ in
                    sections.append(.Line)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchData()
    }
    
    private func setupUI(){
        homeTableView.isHidden = true
        homeTableView.register(UINib(nibName: String(describing: CollectionTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CollectionTableViewCell.self))
        homeTableView.register(UINib(nibName: String(describing: LinesCollectionTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LinesCollectionTableViewCell.self))
    }
    
    private func fetchData(){
        APIRoute.shared.fetchRequest(clientRequest: .GetData, decodingModel: HomeData.self) { [weak self] (result) in
            switch result{
            case .success(let data):
                self?.data = data
                self?.homeTableView.reloadData()
                self?.homeTableView.isHidden = false
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section]{
        case .Ads:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CollectionTableViewCell.self), for: indexPath) as! CollectionTableViewCell
            cell.setData(section: .Ads, offers: data?.result.offers)
            return cell
        case .Categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CollectionTableViewCell.self), for: indexPath) as! CollectionTableViewCell
            cell.setData(section: .Categories, categories: data?.result.categories)
            return cell
        case .Line:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LinesCollectionTableViewCell.self), for: indexPath) as! LinesCollectionTableViewCell
            if let data = data{
                cell.setData(main: data.result.main[indexPath.section - sectionsCountWithoutLinesCount])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame:CGRect(x: 0, y: 0, width: tableView.frame.width, height: 36))
        let title = UILabel(frame:CGRect(x: 8, y: 0, width: tableView.frame.width / 1.25, height: 34))
        title.textColor =  #colorLiteral(red: 0.1994126141, green: 0.4209131598, blue: 0.4094862938, alpha: 1)
        title.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        switch sections[section]{
        case .Ads:
            return nil
        case .Categories:
            title.text = "Shop by category"
        default:
            title.text = data?.result.main[section - sectionsCountWithoutLinesCount].titleEn
        }
        headerView.addSubview(title)
        headerView.backgroundColor = .systemGray6
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
