//
//  CategoryViewController.swift
//  NewsApp
//

import UIKit

class CategoryViewController: UIViewController {
    
    var selectedCategory = String()
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationViewController = segue.destination as! SpecificCategoryViewController
            destinationViewController.selectedCategory = selectedCategory
        }
    }

}

extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryCollectionView.deselectItem(at: indexPath, animated: true)
        selectedCategory = Constants.categoryNames[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.categoryNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCollectionViewCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        let image = UIImage(named: Constants.categoryImages[indexPath.row])
        let category = Constants.categoryNames[indexPath.row]
        
        categoryCollectionViewCell.imageOutlet.image = image
        categoryCollectionViewCell.titleLabelOutlet.text = category
        
        return categoryCollectionViewCell
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 182, height: 212)
    }
    
}
