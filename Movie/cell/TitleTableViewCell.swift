//
//  TitleTableViewCell.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    var delegate: OnTapFilter?
    
    var lblTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.textPink
        title.font = .systemFont(ofSize: 18, weight: .medium)
        return title
    }()
    
    var imgNavigate: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right")
        img.tintColor = .iconGray
        return img
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgNavigate)
        contentView.addSubview(lblTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgNavigate.frame = CGRect(x: contentView.frame.width - 32, y: 16, width: 16, height: 16)
        lblTitle.frame = CGRect(x: 16, y: imgNavigate.frame.midY - ("".heightOfString(usingFont: .systemFont(ofSize: 18, weight: .medium))) / 2, width: imgNavigate.frame.origin.x - 16, height: "".heightOfString(usingFont: .systemFont(ofSize: 18, weight: .medium)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
