//
//  SpecificCategoryViewController.swift
//  NewsApp
//

import UIKit
import SafariServices

class SpecificCategoryViewController: UIViewController {
    
    let headlineNewsInSpecificCategory = News()
    var topHeadlinesArticlesInSpecificCategory = [Article]()
    var selectedCategory = String()
    
    @IBOutlet weak var specificCategoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchNewsFromTopHeadlinesInSpecificCategory(category: selectedCategory)
    }
    
    private func fetchNewsFromTopHeadlinesInSpecificCategory(category: String) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        headlineNewsInSpecificCategory.fetchNewsFromTopHeadlinesInSpecificCategory(category: category) { result in
            switch result {
            case .success(let newsDetail):
                for article in newsDetail.articles {
                    if article.urlToImage != nil {
                        self.topHeadlinesArticlesInSpecificCategory.append(article)
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

extension SpecificCategoryViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        specificCategoryTableView.deselectRow(at: indexPath, animated: true)
        
        let url = URL(string: topHeadlinesArticlesInSpecificCategory[indexPath.row].url)!
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
    
}

extension SpecificCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topHeadlinesArticlesInSpecificCategory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let specificCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: SpecificCategoryTableViewCell.identifier, for: indexPath) as! SpecificCategoryTableViewCell
        
        let urlToImage = topHeadlinesArticlesInSpecificCategory[indexPath.row].urlToImage
        
        let image = headlineNewsInSpecificCategory.getNewsImage(from: urlToImage!)
        let title = topHeadlinesArticlesInSpecificCategory[indexPath.row].title
        let date = topHeadlinesArticlesInSpecificCategory[indexPath.row].publishedAt
        let source = topHeadlinesArticlesInSpecificCategory[indexPath.row].source.name
        
        specificCategoryTableViewCell.imageOutlet.image = image
        specificCategoryTableViewCell.titleViewOutlet.text = title
        specificCategoryTableViewCell.dateLabelOutlet.text = date
        specificCategoryTableViewCell.sourceLabelOutlet.text = source
        
        return specificCategoryTableViewCell
    }
    
}
