//
//  ProductDetailView.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 15.06.2024.
//

import UIKit
import Cosmos

protocol ProductDetailViewProtocol: AnyObject {
    func showProductDetail(_ productDetail: ProductDetail)
    func showError(_ message: String)
}

class ProductDetailViewController: UIViewController {
    var presenter: ProductDetailPresenterProtocol?
    var productDetail: ProductDetail?

    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
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
    
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        setCollectionView()
        setPageControl()
        setCommentRatingView()
        setTitleLabel()
        setSellerNameLabel()
        setDescriptionLabel()
        setPriceLabels()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ProductImageCollectionViewCell.self, forCellWithReuseIdentifier: "ProductImageCell")
        
       
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)

        collectionView.setTop(equalTo: view.safeAreaLayoutGuide.topAnchor)
        collectionView.setLeft(equalTo: view.leftAnchor)
        collectionView.setRight(equalTo: view.rightAnchor)
        collectionView.setHeight(height: 200)
    }
    
    private func setPageControl() {
        view.addSubview(pageControl)

        pageControl.setTop(equalTo: collectionView.bottomAnchor, constant: 10)
        pageControl.setCenterX(equalTo: view.centerXAnchor)
    }
    
    private func setCommentRatingView() {
        view.addSubview(commentRatingView)
        commentRatingView.setHeight(height: 20)
        commentRatingView.setTop(equalTo: pageControl.bottomAnchor, constant: 10)
        commentRatingView.setCenterX(equalTo: view.centerXAnchor)
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)

        titleLabel.setTop(equalTo: commentRatingView.bottomAnchor, constant: 10)
        titleLabel.setLeft(equalTo: view.leftAnchor, constant: 20)
        titleLabel.setRight(equalTo: view.rightAnchor, constant: -20)
    }
    
    private func setSellerNameLabel() {
        view.addSubview(sellerNameLabel)
        sellerNameLabel.setTop(equalTo: titleLabel.bottomAnchor, constant: 10)
        sellerNameLabel.setLeft(equalTo: view.leftAnchor,constant: 20)
    }
    
    private func setDescriptionLabel() {
        view.addSubview(descriptionLabel)

        descriptionLabel.setTop(equalTo: sellerNameLabel.bottomAnchor, constant: 10)
        descriptionLabel.setLeft(equalTo: view.leftAnchor, constant: 20)
        descriptionLabel.setRight(equalTo: view.rightAnchor, constant: -20)
    }
    
    private func setPriceLabels() {
        let priceStackView = UIStackView()
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        priceStackView.distribution = .fill
        priceStackView.spacing = 5
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(priceStackView)
        priceStackView.setTop(equalTo: descriptionLabel.bottomAnchor, constant: 10)
        priceStackView.setLeft(equalTo: view.leftAnchor, constant: 20)
        priceStackView.setRight(equalTo: view.rightAnchor)
        
        priceStackView.addArrangedSubview(oldPriceLabel)
        priceStackView.addArrangedSubview(newPriceLabel)
    }
    
    
}



extension ProductDetailViewController: ProductDetailViewProtocol {
    func showProductDetail(_ productDetail: ProductDetail) {
        self.productDetail = productDetail
        
        DispatchQueue.main.async { [self] in
            self.titleLabel.text = productDetail.title
            setPriceLabels(product: productDetail)
            self.sellerNameLabel.text = "Seller Name: \(productDetail.sellerName ?? "")"
            self.commentRatingView.rating = productDetail.rate ?? 0.0
            if let images = productDetail.images {
                self.pageControl.numberOfPages = images.count
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setPriceLabels(product: ProductDetail) {
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

    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as! ProductImageCollectionViewCell
        
        if let imageUrlString = productDetail?.images?[indexPath.item], let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let pageWidth = scrollView.frame.width
        
        var rawPageIndex = contentOffsetX / pageWidth
        
        if rawPageIndex.isNaN || !rawPageIndex.isFinite {
            rawPageIndex = 0.0
        }
        let pageIndex = Int(round(max(rawPageIndex, 0)))
        pageControl.currentPage = pageIndex
    }



}
