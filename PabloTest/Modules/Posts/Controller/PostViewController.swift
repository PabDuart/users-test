//
//  UserDetailsViewController.swift
//  PabloTest
//
//  Created by Pablo Duarte on 11/12/21.
//

import UIKit

protocol PostViewControllerProtocol: AnyObject {
    func didRetrievePosts(_ posts: [Post])
    func didFailRetrievingData(message: String)
}

final class PostViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var mailLabel: UILabel!
    @IBOutlet private weak var postsTitleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Vars
    var user: User?
    private var viewModel: PostViewModelProtocol = PostViewModel()
    private var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: ViewController Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user?.name
        setupTableView()
        setupValues()
        viewModel.delegate = self
        if let userId = user?.id {
            viewModel.syncPosts(userId: userId)
        }
        showLoadingIndicator(true)
    }
    
    // MARK: Functions
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: PostTableViewCell.self))
    }
    
    private func setupValues() {
        phoneLabel.text = user?.phone
        mailLabel.text = user?.email
        postsTitleLabel.text = String(format: AppConstants.String.postsTitle, user?.name ?? "")
    }
    
    private func showLoadingIndicator(_ show: Bool) {
        loadingIndicator.isHidden = !show
    }
}

//MARK: - TableView Configuration
extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.configureCell(with: posts[indexPath.row])
        return cell
    }
}

//MARK: - PostViewControllerProtocol
extension PostViewController: PostViewControllerProtocol {
    func didRetrievePosts(_ posts: [Post]) {
        DispatchQueue.main.async {
            self.showLoadingIndicator(false)
            self.posts = posts
        }
    }
    
    func didFailRetrievingData(message: String) {
        DispatchQueue.main.async {
            self.showLoadingIndicator(false)
            self.showToast(message: message)
        }
    }
}
