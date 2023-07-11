//
//  DetailViewController.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        return sv
    }()
    
    private var img: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var lblCast: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var lblRelease: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var lblGenre: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var btnRatings: UIButton = {
        let btn = UIButton()
        btn.setTitle("View ratings", for: .normal)
        btn.backgroundColor = .blue
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    var data: HierarchicalLists?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(img)
        scrollView.addSubview(lblTitle)
        scrollView.addSubview(lblCast)
        scrollView.addSubview(lblRelease)
        scrollView.addSubview(lblGenre)
        scrollView.addSubview(btnRatings)
        
        guard let data = data else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        img.load(urlString: data.poster ?? "")
        lblTitle.text = data.title
        lblCast.text = "Plot: \(data.plot ?? "")"
        lblRelease.text = "Released: \(data.releasedDate ?? "")"
        lblGenre.text = "Genre: \(data.genre ?? "")"
        
        btnRatings.addTarget(self, action: #selector(onRatingClicked), for: .touchUpInside)
        
    }
    
    @objc private func onRatingClicked() {
        let vc = RatingViewController()
        vc.arrRatings = data?.rating ?? []
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let heightOfTitle = ceil((lblTitle.text?.widthOfString(usingFont: .systemFont(ofSize: 20, weight: .bold)) ?? 20) / (self.view.frame.size.width) < 1 ? 1 : (lblTitle.text?.widthOfString(usingFont: .systemFont(ofSize: 20, weight: .bold)) ?? 20) / (self.view.frame.size.width)) * (lblTitle.text?.heightOfString(usingFont: .systemFont(ofSize: 20, weight: .bold)) ?? 20) + 28
        let heightOfCast = ceil((lblCast.text?.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)) ?? 20) / (self.view.frame.size.width) < 1 ? 1 : (lblCast.text?.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)) ?? 20) / (self.view.frame.size.width)) * (lblCast.text?.heightOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)) ?? 16) + 48
        let heightOfRelease = ceil((lblRelease.text?.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)) ?? 20) / (self.view.frame.size.width) < 1 ? 1 : (lblRelease.text?.widthOfString(usingFont: .systemFont(ofSize: 20, weight: .medium)) ?? 20) / (self.view.frame.size.width)) * (lblRelease.text?.heightOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)) ?? 16) + 28
        let heightOfGenre = ceil((lblGenre.text?.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)) ?? 20) / (self.view.frame.size.width) < 1 ? 1 : (lblGenre.text?.widthOfString(usingFont: .systemFont(ofSize: 20, weight: .medium)) ?? 20) / (self.view.frame.size.width))  * (lblGenre.text?.heightOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)) ?? 16) + 28
        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: heightOfTitle + heightOfCast + heightOfRelease + heightOfGenre + 84 + 180 + 48 + 60)
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        img.frame = CGRect(x: view.center.x - 90, y: 84, width: 180, height: 180)
        lblTitle.frame = CGRect(x: 16, y: 264 + 16, width: view.frame.width - 32, height: heightOfTitle)
        lblCast.frame = CGRect(x: 16, y: lblTitle.frame.origin.y + lblTitle.frame.height + 8, width: view.frame.width - 32, height: heightOfCast)
        lblRelease.frame = CGRect(x: 16, y: lblCast.frame.origin.y + lblCast.frame.height + 8, width: view.frame.width - 32, height: heightOfRelease)
        lblGenre.frame = CGRect(x: 16, y: lblRelease.frame.origin.y + lblRelease.frame.height + 8, width: view.frame.width - 32, height: heightOfGenre)
        btnRatings.frame = CGRect(x: 16, y: lblGenre.frame.origin.y + lblGenre.frame.height + 16, width: view.frame.width - 32, height: 48)
    }

}
