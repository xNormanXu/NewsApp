//
//  SearchViewController.swift
//  NewsApp
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {
    
    let searchNews = News()
    var searchArticles = [Article]()
    var timer: Timer?
    
    @IBOutlet weak var searchCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func fetchNewsFromSearch(q: String, endpointType: String) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        searchNews.fetchNewsFromSearch(q: q, endpointType: endpointType) { result in
            switch result {
            case .success(let newsDetail):
                for article in newsDetail.articles {
                    if URL(string: article.urlToImage!) != nil {
                        self.searchArticles.append(article)
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

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchCollectionView.deselectItem(at: indexPath, animated: true)
        
        let url = URL(string: searchArticles[indexPath.row].url)!
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let searchCollectionViewCell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell()
        }

        let urlToImage = searchArticles[indexPath.row].urlToImage

        let image = searchNews.getNewsImage(from: urlToImage!)
        let title = searchArticles[indexPath.row].title

        searchCollectionViewCell.imageOutlet.image = image
        searchCollectionViewCell.titeLabelOutlet.text = title
        searchCollectionViewCell.titeLabelOutlet.numberOfLines = 0

        return searchCollectionViewCell
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 182, height: 150)
    }
    
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.searchArticles.removeAll()
            if !searchText.isEmpty {
                self.fetchNewsFromSearch(q: searchText, endpointType: Endpoints().everything)
                self.searchCollectionView.reloadData()
            }
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchArticles.removeAll()
        searchCollectionView.reloadData()
    }
    
}
