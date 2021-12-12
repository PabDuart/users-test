//
//  UsersViewController.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import UIKit

protocol UserViewControllerProtocol: AnyObject {
    func didRetrieveUsers(_ users: [User])
    func didFailRetrievingData(message: String)
}

final class UserViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtSearchBar: UITextField!
    
    // MARK: Vars
    private var filteredUsers = [User]()
    private var searching = false
    private var viewModel: UserViewModelProtocol = UserViewModel()
    private var users: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: ViewController Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(searchText), for: .editingChanged)
        title = AppConstants.String.AppNavigationTitle
        setupTableView()
        viewModel.delegate = self
        viewModel.syncUsers()
    }
    
    @objc func searchText(sender: UITextField) {
        self.filteredUsers.removeAll()
        let searchData: Int = txtSearchBar.text!.count
        if searchData != 0 {
            searching = true
            var i:Int = 0
            for search in users {
                if let userToSearch = txtSearchBar.text {
                    let range = search.name.lowercased().range(of: userToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.filteredUsers.append(search)
                    }
                }
                i = i + 1
            }
        } else {
            filteredUsers = users
            searching = false
        }
        collectionView.reloadData()
    }

    func setupTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: UserCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: UserCollectionViewCell.self))
    }
}

extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return filteredUsers.count
        } else {
            return users.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCollectionViewCell.self), for: indexPath) as! UserCollectionViewCell
        if searching {
            cell.configureCell(with: filteredUsers[indexPath.row], and: self)
        } else {
            cell.configureCell(with: users[indexPath.row], and: self)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(16)
    }
}

extension UserViewController: UserViewControllerProtocol {
    func didRetrieveUsers(_ users: [User]) {
        self.users = users
    }
    
    func didFailRetrievingData(message: String) {
        self.showToast(message: message)
    }
}

extension UserViewController: UserCollectionViewCellDelegate {
    
    func userCollectionView(_ userCollectionView: UserCollectionViewCell, didTapPostsButtonWith user: User) {
        let postViewController = PostViewController()
        postViewController.user = user
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

extension UserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }
}
