//
//  News.swift
//  NewsApp
//

import UIKit

class News {
    
    func fetchNewsFromEverything(completion: @escaping (Result<NewsDetail, Error>) -> Void) {
        // https://newsapi.org/v2/everything?domains=bbc.com,nytimes.com,wsj.com&apiKey=2e4982372ed74ef2a330c78564f132d8
        let endpoint = Endpoints().everything + "?domains=bbc.com,nytimes.com,wsj.com&" + Constants.newsAPIKey
        guard let url = URL(string: endpoint) else {
            fatalError("invalid url")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                fatalError("error")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("invalid response")
            }
            guard let data = data else {
                fatalError("invalid data")
            }
            do {
                let newsDetail = try JSONDecoder().decode(NewsDetail.self, from: data)
                completion(.success(newsDetail))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchNewsFromTopHeadlines(completion: @escaping (Result<NewsDetail, Error>) -> Void) {
        // https://newsapi.org/v2/top-headlines?language=en&apiKey=2e4982372ed74ef2a330c78564f132d8
        let endpoint = Endpoints().topHeadlines + "?language=en&" + Constants.newsAPIKey
        guard let url = URL(string: endpoint) else {
            fatalError("invalid url")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                fatalError("error")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("invalid response")
            }
            guard let data = data else {
                fatalError("invalid data")
            }
            do {
                let newsDetail = try JSONDecoder().decode(NewsDetail.self, from: data)
                completion(.success(newsDetail))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchNewsFromTopHeadlinesInSpecificCategory(category: String, completion: @escaping (Result<NewsDetail, Error>) -> Void) {
        // e.g. https://newsapi.org/v2/top-headlines?category=business&apiKey=2e4982372ed74ef2a330c78564f132d8
        let endpoint = Endpoints().topHeadlines + "?category=\(category)&" + Constants.newsAPIKey
        guard let url = URL(string: endpoint) else {
            fatalError("invalid url")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                fatalError("error")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("invalid response")
            }
            guard let data = data else {
                fatalError("invalid data")
            }
            do {
                let newsDetail = try JSONDecoder().decode(NewsDetail.self, from: data)
                completion(.success(newsDetail))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchNewsFromYouTube(completion: @escaping (Result<VideoDetail, Error>) -> Void) {
        //https://www.googleapis.com/youtube/v3/search?part=snippet&q=news&maxResults=50&key=AIzaSyBCcjHkAYC-kShs36cAGhJoNZoRKji-c9s
        let endpoint = Endpoints().videosSearch + "?part=snippet&q=news&maxResults=50&" + Constants.youTubeAPIKey
        guard let url = URL(string: endpoint) else {
            fatalError("invalid url")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                fatalError("error")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("invalid response")
            }
            guard let data = data else {
                fatalError("invalid data")
            }
            do {
                let videoDetail = try JSONDecoder().decode(VideoDetail.self, from: data)
                completion(.success(videoDetail))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchNewsFromSearch(q: String, endpointType: String, completion: @escaping (Result<NewsDetail, Error>) -> Void) {
        // e.g. https://newsapi.org/v2/everything?q=bitcoin&apiKey=2e4982372ed74ef2a330c78564f132d8
        let endpoint = endpointType + "?q=\(q)&" + Constants.newsAPIKey
        guard let url = URL(string: endpoint) else {
            fatalError("invalid url")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                fatalError("error")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("invalid response")
            }
            guard let data = data else {
                fatalError("invalid data")
            }
            do {
                let newsDetail = try JSONDecoder().decode(NewsDetail.self, from: data)
                completion(.success(newsDetail))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getNewsImage(from string: String) -> UIImage? {
        guard let url = URL(string: string) else {
            fatalError("Unable to create URL")
        }

        var image: UIImage?
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }
    
}
