//
//  PostsService.swift
//  PabloTest
//
//  Created by Pablo Duarte on 11/12/21.
//

final class PostsService: BaseServices {
    func syncPosts(userId: String, completion: @escaping(_ response: [Post]?, _ error: Error?) -> ()) {
        BaseServices.requestGET(url: String(format: AppConstants.Url.posts, userId), responseType: [Post].self) { (result, error) in
            guard error == nil,
                  let result = result as? [Post] else {
                completion(nil, error)
                return
            }
            completion(result, nil)
        }
    }
}
