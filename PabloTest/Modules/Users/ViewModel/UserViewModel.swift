//
//  UsersViewModel.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

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
        service.syncUsers { [weak self] users, error in
            guard error == nil,
                  let users = users else {
                self?.delegate?.didFailRetrievingData(message: AppConstants.String.errorMessage)
                return
            }
            self?.delegate?.didRetrieveUsers(users)
        }
    }
}
