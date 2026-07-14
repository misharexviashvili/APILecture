//
//  FunFactAPIManager.swift
//  APILecture
//
//  Created by Misha on 13.07.2026.
//

import Foundation

protocol FunFactAPIManagerProtocol {
    func fetchFunFact(completion: @escaping (FunFact) -> Void)
}

class FunFactAPIManager: FunFactAPIManagerProtocol {
    func fetchFunFact(completion: @escaping (FunFact) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error {
                print(error)
            }
            
            guard let data else { return }
            
            print(data)
            
            do {
                let decodedFunFact = try JSONDecoder().decode(FunFact.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedFunFact)
                }
                print(decodedFunFact)
            } catch {
              print(error)
            }
        }.resume()
    }
}
