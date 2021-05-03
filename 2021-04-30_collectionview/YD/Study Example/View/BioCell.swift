//
//  NameCell.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

class BioCell: UITableViewCell {
    
    var bio: String? {
        didSet {
            configureUI()
        }
    }
    
    private let bioTitleLable: UILabel = {
        let label = UILabel()
        label.setWidth(80)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "알림글"
        return label
    }()
    
    private let bioLable: UILabel = {
        let tf = UILabel()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.text = "홍길동"
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [bioTitleLable, bioLable])
        stack.axis = .horizontal
        stack.spacing = 20
        
        
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        bioLable.text = bio
    }
    
}
