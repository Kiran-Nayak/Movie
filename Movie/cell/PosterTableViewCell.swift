//
//  PosterTableViewCell.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import UIKit

class PosterTableViewCell: UITableViewCell {
    
    var imageview: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    var lblTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    var lblLanguage: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    var lblYear: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageview)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblLanguage)
        contentView.addSubview(lblYear)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.frame = CGRect(x: 16, y: 16, width: 60, height: 60)
        lblTitle.frame = CGRect(x: imageview.frame.origin.x + imageview.frame.width + 16, y: 4, width: contentView.frame.width - 60 - 64, height: "".heightOfString(usingFont: .systemFont(ofSize: 18, weight: .semibold)))
        lblLanguage.frame = CGRect(x: imageview.frame.origin.x + imageview.frame.width + 16, y: 8 + "".heightOfString(usingFont: .systemFont(ofSize: 18, weight: .semibold)) + 4, width: contentView.frame.width - 60 - 64, height: "".heightOfString(usingFont: .systemFont(ofSize: 14, weight: .medium)))
        lblYear.frame = CGRect(x: imageview.frame.origin.x + imageview.frame.width + 16, y: lblLanguage.frame.origin.y + lblLanguage.frame.height + 8, width: contentView.frame.width - 60 - 64, height: "".heightOfString(usingFont: .systemFont(ofSize: 14, weight: .medium)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
