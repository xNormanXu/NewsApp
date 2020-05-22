//
//  VideoViewController.swift
//  NewsApp
//

import UIKit
import SafariServices

class VideoViewController: UIViewController {
    
    let youTubeNews = News()
    var newsVideos = [Item]()
    
    @IBOutlet weak var videoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchNewsFromYouTube()
    }
    
    private func fetchNewsFromYouTube() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        youTubeNews.fetchNewsFromYouTube() { result in
            switch result {
            case .success(let videoDetail):
                for item in videoDetail.items {
                    self.newsVideos.append(item)
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
    }

}

extension VideoViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoTableView.deselectRow(at: indexPath, animated: true)
        
        let videoID = newsVideos[indexPath.row].id.videoID!
        let url = URL(string: "https://www.youtube.com/watch?v=" + videoID)!
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
    
}

extension VideoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsVideos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoTableViewCell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as! VideoTableViewCell
        
        let url = newsVideos[indexPath.row].snippet.thumbnails.high.url
        
        let image = youTubeNews.getNewsImage(from: url)
        let title = newsVideos[indexPath.row].snippet.snippetDescription
        let source = newsVideos[indexPath.row].snippet.channelTitle
        
        videoTableViewCell.imageOutlet.image = image
        videoTableViewCell.titleLabelOutlet.text = title
        videoTableViewCell.titleLabelOutlet.numberOfLines = 0
        videoTableViewCell.sourceLabelOutlet.text = source
        
        return videoTableViewCell
    }
    
}
