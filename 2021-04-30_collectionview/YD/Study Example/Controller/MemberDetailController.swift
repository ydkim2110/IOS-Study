//
//  DetailViewController.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

private let reuseIdentifierNameCell = "NameCell"
private let reuseIdentifierBioCell = "BioCell"
private let reuseIdentifierImageCell = "ImageCell"

class MemeberDetailController: UITableViewController {
    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    
    private var member: Member
    
    init(member: Member) {
        self.member = member
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        tableView.register(NameCell.self, forCellReuseIdentifier: reuseIdentifierNameCell)
        tableView.register(BioCell.self, forCellReuseIdentifier: reuseIdentifierBioCell)
        tableView.register(ImageCell.self, forCellReuseIdentifier: reuseIdentifierImageCell)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
}

extension MemeberDetailController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierNameCell, for: indexPath) as! NameCell
            cell.name = member.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierBioCell, for: indexPath) as! BioCell
            cell.bio = member.bio
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierImageCell, for: indexPath) as! ImageCell
            cell.delegate = self
            cell.profileImage = member.image
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 2 ? 300 : 45
    }
    
}

extension MemeberDetailController: ImageCellDelegate {
    func handleSelectImageTapped() {
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
            ? .camera
            : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
}

extension MemeberDetailController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }

        member.image = selectedImage
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
}
