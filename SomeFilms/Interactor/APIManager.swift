//
//  APIManager.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 10.07.2024.
//

import Foundation
import SwiftUI
import UIKit

class APIManager {
    
    //https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&sortField=votes.await&sortType=-1&type=&lists=planned-to-watch-films
    
 //   let APIkey = "WR9MF4J-Y8ZMKJK-KXMJ9TH-ARBR78D"
    let APIkey = "BFBG4PE-K14M78Z-HH07520-KZVBKW7"
    let urlMain = "https://api.kinopoisk.dev/v1.4/"
    
    //MARK: - Get films list
    
    func getWaitingFilms(completion: @escaping (([Doc]?) -> Void?)) {
    
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&sortField=votes.await&sortType=-1&type=&lists=planned-to-watch-films"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("ERROR: URL FAILED")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(APIkey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let decodedData = try decoder.decode(Pages.self, from: data)
                
                completion(decodedData.docs)
                
            } catch {
                print("error to decode")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    
    func getPopularFilms(completion: @escaping (([Doc]?) -> Void?)) {
    
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=50&notNullFields=id&sortField=votes.kp&sortType=-1&lists=popular-films"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("ERROR: URL FAILED")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(APIkey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()

                let decodedData = try decoder.decode(Pages.self, from: data)
                print(decodedData)
                
                completion(decodedData.docs)
                
            } catch {
                print("error to decode")
                completion(nil)
            }
         
        }
        
        task.resume()
    }
    
    func getPopularSerials(completion: @escaping (([Doc]?) -> Void?)) {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=50&notNullFields=id&sortField=votes.kp&sortType=-1&lists=series-top250"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("ERROR: URL FAILED")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(APIkey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()

                let decodedData = try decoder.decode(Pages.self, from: data)
                completion(decodedData.docs)
                
            } catch {
                print("error to decode")
                completion(nil)
            }
         
        }
        
        task.resume()
    }
    
    
    func get250(completion: @escaping (([Doc]?) -> Void?)) {
    
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&sortField=rating.kp&sortType=-1&lists=top250"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("ERROR: URL FAILED")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(APIkey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()

                let decodedData = try decoder.decode(Pages.self, from: data)
                completion(decodedData.docs)
                
            } catch {
                print("error to decode")
                completion(nil)
            }
         
        }
        
        task.resume()
    }
    
    func getRandomPopular(completion: @escaping (([Doc]?) -> Void?)) {
    
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=250&sortField=&sortType=1&type=movie&rating.kp=7-10&lists=popular-films"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("ERROR: URL FAILED")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(APIkey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()

                let decodedData = try decoder.decode(Pages.self, from: data)
                
                var arrayRandom : [Doc] = []
                
                if let docData = decodedData.docs {
                    for i in 0..<20 {
                        let randomNumber = Int.random(in: 0..<docData.count)
                        arrayRandom.append(docData[randomNumber])
                    }
                }
                
                print("arrayRandom")
                
                arrayRandom = deleteWithoutImageFromDoc(doc: arrayRandom)
            
                
                completion(arrayRandom)
                
            } catch {
                print("error to decode")
                completion(nil)
            }
         
        }
        
        task.resume()
    }
    
    
    //MARK: - Get film by ID
    
    func getByID(id: Int, completion: @escaping ((Doc?) -> Void?)) {
    
        let urlString = "https://api.kinopoisk.dev/v1.4/movie/\(id)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("ERROR: URL FAILED")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(APIkey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Doc.self, from: data)
                completion(decodedData)
                
            } catch {
                print("error to decode")
                completion(nil)
            }
         
        }
        
        task.resume()
    }
    
    
    
    //MARK: - Get Feedbacks
    func getFeedbacks(_ id: Int, completion: @escaping (([Feedback]?) -> Void?)) {
    
        let urlString = "https://api.kinopoisk.dev/v1.4/review?page=1&limit=10&movieId=\(id)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("ERROR: URL FAILED")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(APIkey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()

                let decodedData = try decoder.decode(FeedbackPages.self, from: data)
                
                completion(decodedData.docs)
                
            } catch {
                print("error to decode")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    //MARK: - Get images
    
    func loadImage(urlString: String, completion: @escaping ((UIImage) -> Void?)) {
        
        var mainImage = UIImage(named: "image1")!
        
        guard let url = URL(string: urlString) else {
            print("ERROR: URL FAILED")
            completion(mainImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    mainImage = image
                    completion(mainImage)
                 
                }
            }
        }.resume()
    }
}
