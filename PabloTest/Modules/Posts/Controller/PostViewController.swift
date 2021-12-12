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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet private weak var collectionViewPost: UICollectionView!
    
    // MARK: Vars
    var user: User?
    private var viewModel: PostViewModelProtocol = PostViewModel()
    private var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionViewPost.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupValues()
        setupView()
        viewModel.delegate = self
        if let userId = user?.id {
            viewModel.syncPosts(userId: userId)
        }
    }
    
    func setupCollectionView() {
        collectionViewPost.delegate = self
        collectionViewPost.dataSource = self
        collectionViewPost.register(UINib(nibName: String(describing: PostCollectionViewCell.self),bundle: nil), forCellWithReuseIdentifier: String(describing: PostCollectionViewCell.self))
    }
    
    private func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "iconAtras"),
            style: .done, target: self,
            action: #selector(didTapGoBackButton))
    }
    
    private func setupValues() {
        nameLabel.text = user?.name
        phoneLabel.text = user?.phone
        mailLabel.text = user?.email
    }
}

extension PostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PostCollectionViewCell.self), for: indexPath) as! PostCollectionViewCell
        cell.configureCell(with: posts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}

extension PostViewController: PostViewControllerProtocol {
    func didRetrievePosts(_ posts: [Post]) {
        self.posts = posts
    }
    
    func didFailRetrievingData(message: String) {
        self.showToast(message: message)
    }
    
    @objc private func didTapGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
