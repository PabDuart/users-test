//
//  DetailsViewModel.swift
//  PabloTest
//
//  Created by Pablo Duarte on 11/12/21.
//

import Foundation

protocol PostViewModelProtocol: AnyObject {
    var delegate: PostViewControllerProtocol? { get set }
    func syncPosts(userId: Int)
}

final class PostViewModel: PostViewModelProtocol {
    weak var delegate: PostViewControllerProtocol?
    private var service: PostsService
    
    init() {
        service = .init()
    }
    
    func syncPosts(userId: Int) {
        service.syncPosts(userId: "\(userId)") { [weak self] posts, error in
            guard error == nil,
                  let posts = posts else {
                self?.delegate?.didFailRetrievingData(message: AppConstants.String.errorMessage)
                return
            }
            self?.delegate?.didRetrievePosts(posts)
        }
    }
}
