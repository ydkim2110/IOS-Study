//
//  AddImageCell.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

protocol AddImageCellDelegate: class {
    func handleSelectImageTapped()
}

class AddImageCell: UITableViewCell {
    
    // MARK: - Properties
    
    var profileImage: UIImage? {
        didSet { configureUI() }
    }
    
    weak var delegate: AddImageCellDelegate?
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(height: 200, width: 200)
        iv.layer.cornerRadius = 200 / 2
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private lazy var selectImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 선택하기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSelectImageTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stack = UIStackView(arrangedSubviews: [selectImageButton, profileImageView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 32

        contentView.addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: topAnchor, paddingTop: 32)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleSelectImageTapped() {
        print("DEBUG : button click!!")
        delegate?.handleSelectImageTapped()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.profileImageView.image = profileImage
        
        self.profileImageView.layer.cornerRadius = 200 / 2
        self.profileImageView.layer.masksToBounds = true
    }
    
}
