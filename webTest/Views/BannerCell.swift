//
//  BannerCell.swift
//  webTest
//
//  Created by Akarsh Ram on 15/07/22.
//

import UIKit

class BannerCell: UICollectionViewCell {
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var banerImage: UIImageView!
    
    override func awakeFromNib() {
        bannerView.layer.cornerRadius = 5
    }
}
