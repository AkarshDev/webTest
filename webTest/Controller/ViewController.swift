//
//  ViewController.swift
//  webTest
//
//  Created by Akarsh Ram on 15/07/22.
//

import UIKit

import Kingfisher
class ViewController: UIViewController {
    
    //MARK - Outlets
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    //MARK - Variables
    
    var homeManager = HomeManager()
    var homeItems = [HomeDatum]()
    var bannerDetails :[Value]?
    var categoryDetails :[Value]?
    var itemDetails :[Value]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeManager.delegate = self
        homeManager.apiCallForHomeList()
        uiSetup()
        
    }
    
    
    func uiSetup(){
        searchView.layer.cornerRadius = 10.0
    }
}

//MARK: - HomeManagerDelegate


extension ViewController: HomeManagerDelegate {
    
    
    
    func didUpdateHome(_ homeManager: HomeManager, home : [HomeDatum]) {
        DispatchQueue.main.async {
            self.actIndicator.stopAnimating()
            for item in home{
                if item.type == .banners{
                    self.bannerDetails = item.values
                    self.bannerCollectionView.reloadData()
                }else if item.type == .category{
                    self.categoryDetails = item.values
                    self.categoryCollectionView.reloadData()
                }else{
                    self.itemDetails = item.values
                    self.itemCollectionView.reloadData()
                }
            }
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.actIndicator.stopAnimating()
        }
        print(error)
    }
}

// MARK - CollectionView Methods

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return categoryDetails?.count ?? 0
        }
        else if collectionView == bannerCollectionView{
            return bannerDetails?.count ?? 0
        }
        else{
            return itemDetails?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
            if let _ = categoryDetails?[indexPath.row] {
                cell.categoryLabel.text = categoryDetails?[indexPath.row].name
                guard let imageURL = URL(string:(categoryDetails?[indexPath.row].imageURL)!) else { return cell }
                cell.categoryImage.kf.setImage(with: imageURL, placeholder: nil)
                
            }
            return cell
        }
        else if collectionView == bannerCollectionView{
            let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCell
            if let _ = bannerDetails?[indexPath.row] {
                guard let imageURL = URL(string:(bannerDetails?[indexPath.row].bannerURL)!) else { return cell }
                cell.banerImage.kf.setImage(with: imageURL, placeholder: nil)
                
            }
            
            return cell
            
        }
        
        else{
            let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCell
            if let _ = itemDetails?[indexPath.row] {
                
                cell.itemLabel.text = itemDetails![indexPath.row].name!
                
                if itemDetails?[indexPath.row].offer != 0 {
                    cell.offerLabel.text = "\(itemDetails![indexPath.row].offer!) % OFF"
                    cell.offerPrice.text = "\(itemDetails![indexPath.row].offerPrice!)"
                    let attributedText = NSAttributedString(
                        string: "\(itemDetails![indexPath.row].actualPrice!)",
                        attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
                    )
                    cell.oldPrice.attributedText = attributedText
                    
                    
                }else{
                    cell.offerPrice.text = "\(itemDetails![indexPath.row].offerPrice!)"
                    cell.offerView.isHidden = true
                }
                if let isExpress = itemDetails?[indexPath.row].isExpress {
                    if isExpress{
                        cell.expressIcon.isHidden = false
                    }else{
                        cell.expressIcon.isHidden = true
                        
                    }
                }
                
                
                guard let imageURL = URL(string:(itemDetails?[indexPath.row].image)!) else { return cell }
                cell.itemImage.kf.setImage(with: imageURL, placeholder: nil)
                
            }
            
            return cell
        }
        
    }
    
}
