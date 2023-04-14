//
//  NetworkManager.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

// MARK: - Enums
enum RequestValue {
    case exampleSuccess
    case dynamicTrue
    case exampleError500
}

// MARK: - NetworkManager
class NetworkManager {
    
    // MARK: - Properties
    var requestValue: RequestValue = .dynamicTrue
    
    // MARK: - Private Properties
    private let urlString = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
    
    // MARK: - Methods
    func fetchData(successComplition: @escaping (Employees) -> Void, errorComplition: @escaping () -> Void) {
        let url = URL(string: urlString)
        guard let url = url else { return }
        
        var request = URLRequest(url: url)
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch requestValue {
        case .exampleSuccess:
            request.setValue("code=200, example=success", forHTTPHeaderField: "Prefer")
        case .dynamicTrue:
            request.setValue("code=200, dynamic=true", forHTTPHeaderField: "Prefer")
        case .exampleError500:
            request.setValue("code=500, example=error-500", forHTTPHeaderField: "Prefer")
        }
        
        session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
                
            do {
                let workers = try decoder.decode(Employees.self, from: data)
                successComplition(workers)
            } catch {
                errorComplition()
            }
        }.resume()
    }
    
    func downloadImage(url: String, complition: @escaping (_ image: UIImage)->()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    complition(image)
                }
            }
        }.resume()
    }
}
