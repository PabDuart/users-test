//
//  UserDetailsViewController.swift
//  PabloTest
//
//  Created by Pablo Duarte on 11/12/21.
//

import UIKit

protocol UserDetailsViewControllerProtocol: AnyObject {
    func didRetrieveUsers(_ posts: [Post])
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
    private var viewModel: DetailsViewModelProtocol = DetailsViewModel()
    private var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionViewPost.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupValues()
        viewModel.delegate = self

    }

    private func SetupValues() {
        nameLabel.text = user?.name
        phoneLabel.text = user?.phone
        mailLabel.text = user?.email
    }
}

extension PostViewController: UserDetailsViewControllerProtocol {
    func didRetrieveUsers(_ posts: [Post]) {
        self.posts = posts
    }
    
    func didFailRetrievingData(message: String) {
        self.showToast(message: message)
    }

}
