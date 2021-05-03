//
//  NameCell.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

class AddNameCell: UITableViewCell {
    
    var name: String? {
        didSet {
            configureUI()
        }
    }
    
    private let nameTitleLable: UILabel = {
        let label = UILabel()
        label.setWidth(80)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "이름"
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이름을 입력해주세요."
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [nameTitleLable, nameTextField])
        stack.axis = .horizontal
        stack.spacing = 20
        
        
        contentView.addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
    }
    
}
