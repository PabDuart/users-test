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
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBarTextField: UITextField!
    @IBOutlet private weak var loadingView: UIView!
    
    // MARK: Vars
    private var filteredUsers = [User]()
    private var isSearching = false
    private var viewModel: UserViewModelProtocol = UserViewModel()
    private var users: [User] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: ViewController Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AppConstants.String.mainTitle
        setupTableView()
        setupSearchBar()
        viewModel.delegate = self
        viewModel.syncUsers()
        showLoadingView(true)
    }
    
    // MARK: Functions
    private func setupTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: UserCollectionViewCell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: UserCollectionViewCell.self))
    }
    
    private func setupSearchBar() {
        searchBarTextField.delegate = self
        searchBarTextField.addTarget(self, action: #selector(searchText), for: .editingChanged)
    }
    
    @objc func searchText(sender: UITextField) {
        filteredUsers.removeAll()
        if searchBarTextField.text?.isEmpty ?? true {
            filteredUsers = users
            isSearching = false
        } else {
            isSearching = true
            for user in users {
                if let searchText = searchBarTextField.text {
                    let range = user.name.lowercased().range(of: searchText, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.filteredUsers.append(user)
                    }
                }
            }
        }
        collectionView.reloadData()
    }
    
    private func showLoadingView(_ show: Bool) {
        loadingView.isHidden = !show
    }
}

//MARK: - CollectionView Configuration
extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching ? filteredUsers.isEmpty : users.isEmpty {
            collectionView.setEmptyMessage(AppConstants.String.listEmpty)
            return 0
        }
        collectionView.restore()
        return isSearching ? filteredUsers.count : users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCollectionViewCell.self), for: indexPath) as! UserCollectionViewCell
        let users = isSearching ? filteredUsers : self.users
        cell.configureCell(with: users[indexPath.row], and: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(16)
    }
}

//MARK: - UserViewControllerProtocol
extension UserViewController: UserViewControllerProtocol {
    func didRetrieveUsers(_ users: [User]) {
        showLoadingView(false)
        self.users = users
    }
    
    func didFailRetrievingData(message: String) {
        DispatchQueue.main.async {
            self.showLoadingView(false)
            self.showToast(message: message)
        }
    }
}

//MARK: - UserCollectionViewCellDelegate
extension UserViewController: UserCollectionViewCellDelegate {
    func userCollectionView(_ userCollectionView: UserCollectionViewCell, didTapPostsButtonWith user: User) {
        let postViewController = PostViewController()
        postViewController.user = user
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension UserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarTextField.resignFirstResponder()
        return true
    }
}
