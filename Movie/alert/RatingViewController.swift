//
//  ViewController.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import UIKit

class RatingViewController: UIViewController {
    
    
    private var tblView: UITableView = {
        let tbl = UITableView()
        tbl.register(cellWithClass: RatingTableViewCell.self)
        return tbl
    }()
    
    var arrRatings: [Rating?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Ratings"
        if arrRatings.isEmpty {
            self.navigationController?.popViewController(animated: true)
        }
        tblView.dataSource = self
        tblView.delegate = self
        
        [tblView].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tblView.frame = view.bounds
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as? RatingTableViewCell
        cell?.lblTitle.text = arrRatings[indexPath.row]?.Source ?? ""
        cell?.lblRatings.text = arrRatings[indexPath.row]?.Value ?? ""
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
