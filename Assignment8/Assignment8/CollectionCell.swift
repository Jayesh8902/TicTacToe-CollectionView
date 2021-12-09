//
//  CollectionCellCollectionViewCell.swift
//  Assignment8
//
//  Created by DCS on 06/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell
{
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupcell(with status : Int){
        contentView.addSubview(myImageView)
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        myImageView.frame = CGRect(x: 8, y: 7,width: 45,height: 45)
        let name = status == 0 ? "circle" : status == 1 ? "cross" : ""
        myImageView.image = UIImage(named : name)
    }
}
