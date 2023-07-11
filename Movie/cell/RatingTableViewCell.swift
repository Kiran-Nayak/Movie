//
//  RatingTableViewCell.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    
    var lblTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = .systemFont(ofSize: 18, weight: .medium)
        return title
    }()
    
    var lblRatings: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = .systemFont(ofSize: 18, weight: .bold)
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblRatings)
        contentView.addSubview(lblTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblRatings.frame = CGRect(x: contentView.frame.width - 32 - (lblRatings.text?.widthOfString(usingFont: .systemFont(ofSize: 18, weight: .bold)) ?? 20), y: 8, width: (lblRatings.text?.widthOfString(usingFont: .systemFont(ofSize: 18, weight: .bold)) ?? 20), height: (lblRatings.text?.heightOfString(usingFont: .systemFont(ofSize: 18, weight: .bold)) ?? 20))
        lblTitle.frame = CGRect(x: 16, y: 8, width: lblRatings.frame.origin.x - 16, height: "".heightOfString(usingFont: .systemFont(ofSize: 18, weight: .medium)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
