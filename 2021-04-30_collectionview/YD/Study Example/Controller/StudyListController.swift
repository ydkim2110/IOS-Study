//
//  StudyListController.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

private let reuseIdentifierList = "StudyListCell"
private let reuseIdentifierAdd = "StudyAddCell"

class StudyListController: UITableViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectos
    
    @objc func handleAddTapped() {
        goToMemberAddController()
    }
    
    // MARK: - Helpers
    
    fileprivate func goToMemberAddController() {
        let controller = MemberAddController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavigation()
        configureTableView()
    }
    
    func configureNavigation() {
        navigationItem.title = "Study Member" 
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleAddTapped))
    }
    
    func configureTableView() {
        tableView.register(StudyListCell.self, forCellReuseIdentifier: reuseIdentifierList)
        tableView.register(StudyAddCell.self, forCellReuseIdentifier: reuseIdentifierAdd)
        tableView.tableFooterView = UIView()
    }
}

extension StudyListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DefaultMemeber.members.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAdd, for: indexPath) as! StudyAddCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierList, for: indexPath) as! StudyListCell
        cell.member = DefaultMemeber.members[indexPath.row - 1]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            goToMemberAddController()
        } else {
            let member = DefaultMemeber.members[indexPath.row - 1]
            navigationController?.pushViewController(MemeberDetailController(member: member), animated: true)
        }
    }
}

extension StudyListController: MemberAddControllerDelegate {
    func saveMember() {
        print("DEBUG : List Controller")
        tableView.reloadData()
    }
}
