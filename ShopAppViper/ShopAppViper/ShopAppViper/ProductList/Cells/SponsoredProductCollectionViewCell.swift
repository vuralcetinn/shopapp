//
//  SponsoredProductCollectionViewCell.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 18.06.2024.
//

import Foundation
import UIKit
import Cosmos

class SponsoredProductCollectionViewCell: UICollectionViewCell {
    
    private let mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var commentRatingView: CosmosView = {
        let view = CosmosView()
        view.settings.starSize = 15
        view.settings.filledColor = .yellow
        view.settings.emptyBorderColor = .black
        view.settings.filledBorderColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let productDetailContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let additionalDiscountView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let additionalDiscountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8, weight: .bold)
        label.textColor = .white
        label.text = "Sepette Ek İndirim"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setMainContentView()
    }
    
    private func setMainContentView() {
        contentView.addSubview(mainContentView)
        mainContentView.setLeft(equalTo: leftAnchor)
        mainContentView.setRight(equalTo: rightAnchor)
        mainContentView.setTop(equalTo: topAnchor)
        mainContentView.setBottom(equalTo: bottomAnchor)
        setImageView()
        setCommentRatingView()
        setProductDetailContentView()
    }
    
    private func setImageView() {
        mainContentView.addSubview(imageView)
        imageView.setTop(equalTo: mainContentView.topAnchor)
        imageView.setLeft(equalTo: mainContentView.leftAnchor)
        imageView.setHeight(height: 140)
        imageView.setWidth(width: 120)
    }
    
    private func setCommentRatingView() {
        mainContentView.addSubview(commentRatingView)
        commentRatingView.setHeight(height: 20)
        commentRatingView.setTop(equalTo: imageView.bottomAnchor, constant: 10)
        commentRatingView.setLeft(equalTo: mainContentView.leftAnchor)
        commentRatingView.setRight(equalTo: imageView.rightAnchor)
    }
    
    private func setProductDetailContentView() {
        mainContentView.addSubview(productDetailContentView)
        productDetailContentView.setTop(equalTo: imageView.topAnchor)
        productDetailContentView.setLeft(equalTo: imageView.rightAnchor, constant: 10)
        productDetailContentView.setRight(equalTo: mainContentView.rightAnchor, constant: -10)
        setTitleLabel()
        setSellerNameLabel()
        setDiscountView()
        setPriceLabels()
        setAdditionalDiscountView()
    }
    
    private func setTitleLabel() {
        productDetailContentView.addSubview(titleLabel)
        titleLabel.setTop(equalTo: productDetailContentView.topAnchor, constant: 10)
        titleLabel.setLeft(equalTo: productDetailContentView.leftAnchor)
        titleLabel.setRight(equalTo: productDetailContentView.rightAnchor)
    }
    
    private func setSellerNameLabel() {
        productDetailContentView.addSubview(sellerNameLabel)
        sellerNameLabel.setTop(equalTo: titleLabel.bottomAnchor, constant: 10)
        sellerNameLabel.setLeft(equalTo: productDetailContentView.leftAnchor)
    }
    
    private func setDiscountView() {
        productDetailContentView.addSubview(discountView)
        discountView.addSubview(discountLabel)
        discountView.setTop(equalTo: sellerNameLabel.bottomAnchor, constant: 10)
        discountView.setLeft(equalTo: productDetailContentView.leftAnchor, constant: 10)
        discountView.setWidth(width: 40)
        discountView.setHeight(height: 20)
        
        discountLabel.setTop(equalTo: discountView.topAnchor)
        discountLabel.setLeft(equalTo: discountView.leftAnchor)
        discountLabel.setRight(equalTo: discountView.rightAnchor)
        discountLabel.setBottom(equalTo: discountView.bottomAnchor)
    }
    
    private func setPriceLabels() {
        let priceStackView = UIStackView()
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        priceStackView.distribution = .fill
        priceStackView.spacing = 5
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        productDetailContentView.addSubview(priceStackView)
        priceStackView.setTop(equalTo: sellerNameLabel.bottomAnchor, constant: 10)
        priceStackView.setLeft(equalTo: discountView.rightAnchor, constant: 10)
        priceStackView.setRight(equalTo: productDetailContentView.rightAnchor)
        
        priceStackView.addArrangedSubview(oldPriceLabel)
        priceStackView.addArrangedSubview(newPriceLabel)
    }
    
    private func setAdditionalDiscountView() {
        productDetailContentView.addSubview(additionalDiscountView)
        additionalDiscountView.addSubview(additionalDiscountLabel)
        additionalDiscountView.setTop(equalTo: newPriceLabel.bottomAnchor, constant: 10)
        additionalDiscountView.setLeft(equalTo: productDetailContentView.leftAnchor)
        additionalDiscountView.setHeight(height: 20)
        additionalDiscountView.setWidth(width: 120)
        
        additionalDiscountLabel.setTop(equalTo: additionalDiscountView.topAnchor)
        additionalDiscountLabel.setLeft(equalTo: additionalDiscountView.leftAnchor)
        additionalDiscountLabel.setRight(equalTo: additionalDiscountView.rightAnchor)
        additionalDiscountLabel.setBottom(equalTo: additionalDiscountView.bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title!
        sellerNameLabel.text = product.sellerName ?? "Seller Empty"
        commentRatingView.rating = product.rate ?? 0.0
        setPriceLabels(product: product)
        let formattedDiscount = String(format: "%.0f%%", product.getDiscountRate())
        discountLabel.text = formattedDiscount
        setDiscountViewVisibilty(discountRate: product.getDiscountRate())
        
        if let imageUrl = product.image, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    private func setDiscountViewVisibilty(discountRate: Double) {
        discountView.isHidden = discountRate == 0
    }
    
    private func setPriceLabels(product: Product) {
        if product.getDiscountRate() != 0 {
            oldPriceLabel.attributedText = "\(product.price!) TL".strikeThrough()
            oldPriceLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)

            newPriceLabel.text = "\(product.instantDiscountPrice!) TL"
        }else {
            oldPriceLabel.text = "\(product.price!) TL"
            oldPriceLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
            newPriceLabel.text = ""

        }
    }
}
