//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Андрей Фокин on 28.10.21.
//

import Foundation
import UIKit

class PhotoInfoController {
    
    enum PhotoInfoError: Error, LocalizedError {
        case imageDataMissign
    }
    
    func fetchFotoInfo(completion: @escaping(Result<PhotoInfo, Error>) -> Void) {
        var nasaUrl = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        let queries = ["api_key": "DEMO_KEY"]
        
        nasaUrl.queryItems = queries.map{URLQueryItem(name: $0.key, value: $0.value)}
        
        let nasaTask = URLSession.shared.dataTask(with: nasaUrl.url!) { data, responce, error in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let photoInfo = try jsonDecoder.decode(PhotoInfo.self, from: data)
                    completion(.success(photoInfo))
                } catch {
                    completion(.failure(error))
                }
                
            }
            
        }
        nasaTask.resume()
    }
    
    func fetchPhoto(my url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, responce, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(PhotoInfoError.imageDataMissign))
            }
        })
        task.resume()
    }
}
