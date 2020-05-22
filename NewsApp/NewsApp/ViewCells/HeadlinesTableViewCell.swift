//
//  HeadlinesTableViewCell.swift
//  NewsApp
//

import UIKit

class HeadlinesTableViewCell: UITableViewCell {

    static let identifier = "headlinesTableViewCell"
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var titleLabelOutlet: UILabel!
    
    @IBOutlet weak var sourceLabelOutlet: UILabel!
    
    @IBOutlet weak var thumbsUpButtonOutlet: UIButton!
    
    @IBOutlet weak var thumbsDownButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeButtonImage()
    }
    
    @IBAction func thumbsUpButtonAction(_ sender: Any) {

        if thumbsUpButtonOutlet.image(for: .normal) == UIImage(systemName: "hand.thumbsup") {
            thumbsUpButtonOutlet.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }
        else {
            thumbsUpButtonOutlet.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }

    }

    @IBAction func thumbsDownButtonAction(_ sender: Any) {

        if thumbsDownButtonOutlet.image(for: .normal) == UIImage(systemName: "hand.thumbsdown") {
            thumbsDownButtonOutlet.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
        }
        else {
            thumbsDownButtonOutlet.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        }

    }
    
    private func initializeButtonImage() {

        thumbsUpButtonOutlet.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        thumbsDownButtonOutlet.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)

    }
    
}
