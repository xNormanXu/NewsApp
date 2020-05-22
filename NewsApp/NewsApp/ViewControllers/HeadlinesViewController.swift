//
//  HeadlinesViewController.swift
//  NewsApp
//

import UIKit
import SafariServices

class HeadlinesViewController: UIViewController {
    
    let headlineNews = News()
    var topHeadlinesArticles = [Article]()
    
    @IBOutlet weak var headlinesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchNewsFromTopHeadlines()
    }
    
    private func fetchNewsFromTopHeadlines() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        headlineNews.fetchNewsFromTopHeadlines() { result in
            switch result {
            case .success(let newsDetail):
                for article in newsDetail.articles {
                    if article.urlToImage != nil {
                        self.topHeadlinesArticles.append(article)
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

extension HeadlinesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        headlinesTableView.deselectRow(at: indexPath, animated: true)
        
        let url = URL(string: topHeadlinesArticles[indexPath.row].url)!
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
    
}

extension HeadlinesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topHeadlinesArticles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headlinesTableViewCell = tableView.dequeueReusableCell(withIdentifier: HeadlinesTableViewCell.identifier, for: indexPath) as! HeadlinesTableViewCell
        
        let urlToImage = topHeadlinesArticles[indexPath.row].urlToImage
        
        let image = headlineNews.getNewsImage(from: urlToImage!)
        let title = topHeadlinesArticles[indexPath.row].title
        let source = topHeadlinesArticles[indexPath.row].source.name
        
        headlinesTableViewCell.imageOutlet.image = image
        headlinesTableViewCell.titleLabelOutlet.text = title
        headlinesTableViewCell.titleLabelOutlet.numberOfLines = 0
        headlinesTableViewCell.sourceLabelOutlet.text = source
        
        return headlinesTableViewCell
    }
    
}

