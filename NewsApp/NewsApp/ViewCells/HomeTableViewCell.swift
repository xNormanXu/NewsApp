//
//  HomeTableViewCell.swift
//  NewsApp
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let identifier = "homeTableViewCell"
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var titleViewOutlet: UITextView!
    
    @IBOutlet weak var dateLabelOutlet: UILabel!
    
    @IBOutlet weak var sourceLabelOutlet: UILabel!

}
