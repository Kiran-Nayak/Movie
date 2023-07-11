//
//  ViewController.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private var tblView: UITableView = {
        let tblView = UITableView()
        tblView.register(cellWithClass: TitleTableViewCell.self)
        tblView.register(cellWithClass: PosterTableViewCell.self)
        return tblView
    }()
    
    private var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .searchGray
        return view
    }()
    
    private var searchField: UITextField = {
        let field = UITextField()
        field.placeholder = "search movies by title/actor/genre/director"
        field.backgroundColor = .white
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.layer.cornerRadius = 8
        return field
    }()

    private var viewmodel: MainViewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        title = "Movie"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(onClearFilter))
        
        view.addSubview(searchView)
        searchView.addSubview(searchField)
        view.addSubview(tblView)
        
        
        searchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        tblView.dataSource = self
        tblView.delegate = self
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewmodel.delegate = self
        viewmodel.category = .None
        viewmodel.categoryData = ""
        searchField.text = ""
        viewmodel.getMainHirarchy()
    }
    
    @objc private func onClearFilter() {
        viewmodel.category = .None
        viewmodel.categoryData = ""
        viewmodel.getMainHirarchy()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchView.frame = CGRect(x: 0, y: topbarHeight,width: view.frame.width, height: 48)
        searchField.frame = CGRect(x: 16, y: 6, width: view.frame.width - 32, height: 36)
        tblView.frame = CGRect(x: 0, y: topbarHeight + 48, width: view.frame.width, height: view.frame.height - (topbarHeight + 48))
    }
    
    @objc private func textFieldDidChange() {
        if searchField.text == nil || searchField.text?.isEmpty == true {
            viewmodel.category = .None
            viewmodel.categoryData = ""
            viewmodel.getMainHirarchy()
        }else {
            viewmodel.findMovies(data: viewmodel.loadData(), search: searchField.text ?? "")
        }
    }


}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (viewmodel.category != .None && !viewmodel.categoryData.isEmpty) || searchField.text?.isEmpty == false {
            return 92
        }else {
            return tableView.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (viewmodel.category != .None && !viewmodel.categoryData.isEmpty) || searchField.text?.isEmpty == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell", for: indexPath) as? PosterTableViewCell
            cell?.lblTitle.text = viewmodel.list[indexPath.row]?.title
            cell?.lblYear.text = "Released \(viewmodel.list[indexPath.row]?.year ?? "")"
            cell?.lblLanguage.text = "Language \(viewmodel.list[indexPath.row]?.language ?? "")"
            cell?.imageview.load(urlString: viewmodel.list[indexPath.row]?.poster)
            return cell ?? UITableViewCell()
            
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell
            cell?.lblTitle.text = viewmodel.list[indexPath.row]?.title
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (viewmodel.category != .None && !viewmodel.categoryData.isEmpty) || searchField.text?.isEmpty == false {
            let vc = DetailViewController()
            vc.data = viewmodel.list[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }else if viewmodel.category == .None {
            viewmodel.getCategoryHirarchy(data: viewmodel.loadData(), type: viewmodel.list[indexPath.row]?.type ?? .Year)
        }else {
            viewmodel.setCategoryData(value: viewmodel.list[indexPath.row]?.title ?? "")
            viewmodel.findMoviesFilter(data: viewmodel.loadData())
        }
        tblView.reloadData()
    }
    
}

extension MainViewController: ClickedOnData {
    func didClicked(data: [HierarchicalLists]) {
        self.tblView.reloadData()
    }
}

protocol ClickedOnData {
    func didClicked(data: [HierarchicalLists])
}

extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
