//
//  MemberAddController.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

private let reuseIdentifierAddNameCell = "AddNameCell"
private let reuseIdentifierAddBioCell = "AddBioCell"
private let reuseIdentifierAddImageCell = "AddImageCell"

protocol MemberAddControllerDelegate: class {
    func saveMember()
}

class MemberAddController: UITableViewController {
    
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private var addNameCell: AddNameCell?
    private var addBioCell: AddBioCell?
    
    weak var delegate: MemberAddControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleSaveTapped() {
        guard
            let addNameCell = addNameCell,
            let addBioCell = addBioCell
        else { return }
        
        guard addNameCell.nameTextField.text?.isEmpty == false else {
            showAlertMessage("이름을 입력해주세요.")
            return
        }
        
        guard addBioCell.bioTextField.text?.isEmpty == false else {
            showAlertMessage("알림글을 입력해주세요.")
            return
        }
        
        guard profileImage != nil else {
            showAlertMessage("사진을 선택해주세요.")
            return
        }
        
        let member = Member(name: addNameCell.nameTextField.text!, bio: addBioCell.bioTextField.text!, image: profileImage)

        MemberService.shared.saveMember(forMember: member) {
            self.delegate?.saveMember()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleImagePicker() {
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
            ? .camera
            : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // MARK: - Helpers
    
    func showAlertMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureUI() {
        navigationItem.title = "Add Member"
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "camera.fill"), style: .plain, target: self, action: #selector(handleImagePicker)),
            UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(handleSaveTapped))
        ]
        
        tableView.register(AddNameCell.self, forCellReuseIdentifier: reuseIdentifierAddNameCell)
        tableView.register(AddBioCell.self, forCellReuseIdentifier: reuseIdentifierAddBioCell)
        tableView.register(AddImageCell.self, forCellReuseIdentifier: reuseIdentifierAddImageCell)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
}

extension MemberAddController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            addNameCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAddNameCell, for: indexPath) as! AddNameCell
            addNameCell!.nameTextField.delegate = self
            return addNameCell!
        case 1:
            addBioCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAddBioCell, for: indexPath) as! AddBioCell
            addBioCell!.bioTextField.delegate = self
            return addBioCell!
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAddImageCell, for: indexPath) as! AddImageCell
            cell.delegate = self
            cell.profileImage = profileImage
            return cell
        }
    }
    
}

extension MemberAddController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let addNameCell = addNameCell,
            let addBioCell = addBioCell
        else {
            return false
        }
        
        if textField == addNameCell.nameTextField {
            return addBioCell.bioTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
        return true
    }
    
}

extension MemberAddController: AddImageCellDelegate {
    func handleSelectImageTapped() {
        print("DEBUG : Click!!")
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
            ? .camera
            : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
}

extension MemberAddController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        profileImage = image
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)

    }
    
}
