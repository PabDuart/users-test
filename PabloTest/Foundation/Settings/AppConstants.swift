//
//  AppConstants.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

struct AppConstants {
    struct Url {
        static let baseUrl = "https://jsonplaceholder.typicode.com/"
        static let users = "users"
        static let posts = "posts?userId=%@"
    }
    
    struct String {
        static let mainTitle = "Prueba de Ingreso"
        static let listEmpty = "List is empty"
        static let errorMessage = "Error al cargar"
        static let postsTitle = "Posts de %@"
    }
}
