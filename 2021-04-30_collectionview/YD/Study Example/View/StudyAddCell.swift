//
//  StudyAddCell.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

class StudyAddCell: UITableViewCell {
    
    private let addImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "face.smiling")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 40, width: 40)
        iv.layer.cornerRadius = 40 / 2
        
        return iv
    }()
    
    private let addLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemRed
        label.text = "멤버 추가하기"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(addImageView)
        addImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(addLabel)
        addLabel.centerY(inView: self)
        addLabel.anchor(left: addImageView.rightAnchor, paddingLeft: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
