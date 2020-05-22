//
//  MenuTableViewController.swift
//  NewsApp
//

import UIKit
import SafariServices

class MenuTableViewController: UITableViewController {
    
    var newsSources = ["CNN", "Reuters", "BBC News", "Fox News", "NBC News", "Bloomberg News", "Google News", "Yahoo News", "New York Times", "Huffington Post", "Washington Post", "The Guardian"]
    var currentNewsSources = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentNewsSources = newsSources
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNewsSources.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! MenuTableViewCell

        menuTableViewCell.newsSourceLabelOutlet.text = currentNewsSources[indexPath.row]

        return menuTableViewCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newsSource = currentNewsSources[indexPath.row]
        
        navigateToNewsSource(sourceName: newsSource)
    }
    
    private func navigateToNewsSource(sourceName: String) {
        var url = String()
        
        switch sourceName {
        case "CNN":
            url = "https://www.cnn.com"
        case "Reuters":
            url = "https://www.reuters.com"
        case "BBC News":
            url = "https://www.bbc.com/news"
        case "Fox News":
            url = "https://www.foxnews.com"
        case "NBC News":
            url = "https://www.nbcnews.com"
        case "Bloomberg News":
            url = "https://www.bloomberg.com"
        case "Google News":
            url = "https://news.google.com"
        case "Yahoo News":
            url = "https://news.yahoo.com"
        case "New York Times":
            url = "https://www.nytimes.com"
        case "Huffington Post":
            url = "https://www.huffpost.com"
        case "Washington Post":
            url = "https://www.washingtonpost.com"
        case "The Guardian":
            url = "https://www.theguardian.com"
        default:
            break
        }
        
        let safariViewController = SFSafariViewController(url: URL(string: url)!)
        present(safariViewController, animated: true)
    }

}

extension MenuTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentNewsSources = newsSources.filter({ newsSource -> Bool in
            if searchText.isEmpty {
                return true
            }
            return newsSource.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        currentNewsSources = newsSources
        tableView.reloadData()
    }
    
}
