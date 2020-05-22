//
//  SpecificCategoryTableViewCell.swift
//  NewsApp
//

import UIKit

class SpecificCategoryTableViewCell: UITableViewCell {
    
    static let identifier = "specificCategoryTableViewCell"
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var titleViewOutlet: UITextView!
    
    @IBOutlet weak var dateLabelOutlet: UILabel!
    
    @IBOutlet weak var sourceLabelOutlet: UILabel!

}
