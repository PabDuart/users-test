//
//  UsersService.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

final class UsersService: BaseServices {
    func syncUsers(completion: @escaping(_ response: [User]?, _ error: Error?) -> ()) {
        BaseServices.requestGET(url: AppConstants.Url.users, responseType: [User].self) { (result, error) in
            guard error == nil,
                  let result = result as? [User] else {
                completion(nil, error)
                return
            }
            completion(result, nil)
        }
    }
}
