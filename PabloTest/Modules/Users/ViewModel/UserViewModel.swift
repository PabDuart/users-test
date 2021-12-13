//
//  UsersViewModel.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import UIKit

protocol UserViewModelProtocol: AnyObject {
    var delegate: UserViewControllerProtocol? { get set }
    func syncUsers()
}

final class UserViewModel: UserViewModelProtocol {
    weak var delegate: UserViewControllerProtocol?
    private var service: UsersService
    
    init() {
        service = .init()
    }
    
    func syncUsers() {
        let localUsers = CoreDataService.shared.retrieve(User.self)
        if localUsers.isEmpty {
            service.syncUsers { [weak self] users, error in
                guard error == nil,
                      let users = users else {
                    self?.delegate?.didFailRetrievingData(message: AppConstants.String.errorMessage)
                    return
                }
                DispatchQueue.main.async {
                    CoreDataService.shared.create(users)
                    self?.delegate?.didRetrieveUsers(users)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.delegate?.didRetrieveUsers(localUsers)
            }
        }
    }
}
