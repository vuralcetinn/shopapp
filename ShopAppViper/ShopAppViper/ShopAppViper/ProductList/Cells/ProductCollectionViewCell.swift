//
//  ProductCollectionViewCell.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 16.06.2024.
//

import UIKit
import Cosmos

class ProductCollectionViewCell: UICollectionViewCell {
    
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
    
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
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
        setDiscountView()
        setSellerNameLabel()
        setCommentRatingView()
        setTitleLabel()
        setPriceLabels()
    }
    
    
    
    private func setImageView()  {
        mainContentView.addSubview(imageView)
        imageView.setTop(equalTo: mainContentView.topAnchor)
        imageView.setLeft(equalTo: mainContentView.leftAnchor)
        imageView.setRight(equalTo: mainContentView.rightAnchor)
        imageView.setHeight(height: 200)
    }
    
    private func setDiscountView() {
        mainContentView.addSubview(discountView)
        discountView.addSubview(discountLabel)
        discountView.setTop(equalTo: imageView.topAnchor, constant: 10)
        discountView.setLeft(equalTo: imageView.leftAnchor, constant: 10)
        discountView.setWidth(width: 40)
        discountView.setHeight(height: 20)
        
        discountLabel.setTop(equalTo: discountView.topAnchor)
        discountLabel.setLeft(equalTo: discountView.leftAnchor)
        discountLabel.setRight(equalTo: discountView.rightAnchor)
        discountLabel.setBottom(equalTo: discountView.bottomAnchor)
    }
    
    private func setSellerNameLabel() {
        mainContentView.addSubview(sellerNameLabel)
        sellerNameLabel.setTop(equalTo: imageView.bottomAnchor,constant: 10)
        sellerNameLabel.setRight(equalTo: mainContentView.rightAnchor)
        sellerNameLabel.setLeft(equalTo: mainContentView.leftAnchor)
    }
    
    private func setCommentRatingView() {
        mainContentView.addSubview(commentRatingView)
        commentRatingView.setHeight(height: 15)
        commentRatingView.setLeft(equalTo: mainContentView.leftAnchor)
        commentRatingView.setRight(equalTo: mainContentView.rightAnchor)
        commentRatingView.setTop(equalTo: sellerNameLabel.bottomAnchor,constant: 10)
    }
    
    private func setTitleLabel() {
        mainContentView.addSubview(titleLabel)
        titleLabel.setTop(equalTo: commentRatingView.bottomAnchor,constant: 0)
        titleLabel.setRight(equalTo: mainContentView.rightAnchor)
        titleLabel.setLeft(equalTo: mainContentView.leftAnchor)
        titleLabel.setHeight(height: 40)
    }
    
    private func setPriceLabels() {
        let priceStackView = UIStackView()
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        priceStackView.distribution = .fill
        priceStackView.spacing = 5
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainContentView.addSubview(priceStackView)
        priceStackView.setTop(equalTo: titleLabel.bottomAnchor, constant: 10)
        priceStackView.setLeft(equalTo: mainContentView.leftAnchor)
        priceStackView.setRight(equalTo: mainContentView.rightAnchor)
        priceStackView.setBottom(equalTo: mainContentView.bottomAnchor)
        
        priceStackView.addArrangedSubview(oldPriceLabel)
        priceStackView.addArrangedSubview(newPriceLabel)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with product: Product) {
        titleLabel.text = product.title
        setPriceLabels(product: product)
        commentRatingView.rating = product.rate ?? 0.0
        let formattedDiscount = String(format: "%.0f%%", product.getDiscountRate())
        discountLabel.text = formattedDiscount
        setDiscountViewVisibilty(discountRate: product.getDiscountRate())
        sellerNameLabel.text = product.sellerName ?? ""
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
