//
//  HomeViewController.swift
//  NewsApp
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    let everythingNews = News()
    var everythingArticles = [Article]()
    
    @IBOutlet weak var homeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchNewsFromEverything()
    }
    
    private func fetchNewsFromEverything() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        everythingNews.fetchNewsFromEverything() { result in
            switch result {
            case .success(let newsDetail):
                for article in newsDetail.articles {
                    if URL(string: article.urlToImage!) != nil {
                        self.everythingArticles.append(article)
                    }
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeTableView.deselectRow(at: indexPath, animated: true)
        
        let url = URL(string: everythingArticles[indexPath.row].url)!
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return everythingArticles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        let urlToImage = everythingArticles[indexPath.row].urlToImage
        
        let image = everythingNews.getNewsImage(from: urlToImage!)
        let title = everythingArticles[indexPath.row].title
        let date = everythingArticles[indexPath.row].publishedAt
        let source = everythingArticles[indexPath.row].source.name
        
        homeTableViewCell.imageOutlet.image = image
        homeTableViewCell.titleViewOutlet.text = title
        homeTableViewCell.dateLabelOutlet.text = date
        homeTableViewCell.sourceLabelOutlet.text = source
        
        return homeTableViewCell
    }
    
}
