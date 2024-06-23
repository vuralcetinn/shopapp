//
//  ProductListView.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 14.06.2024.
//

import UIKit

protocol ProductViewProtocol: AnyObject {
    func showProducts(_ products: [Product])
    func showError(_ message: String)
    func showSponsoredProducts(_ products: [Product])
}

class ProductViewController: UIViewController {
    var presenter: ProductPresenterProtocol?
    var products: [Product] = []
    var sponsoredProducts: [Product] = []
    var paging = 1

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sponsoredProductsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sponsorlu Ürünler"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 340)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollectionView.register(SponsoredProductCollectionViewCell.self, forCellWithReuseIdentifier: "SponsoredProductCell")
        horizontalCollectionView.backgroundColor = .clear
        return horizontalCollectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter?.viewDidLoad(paging:paging)
    }

    private func setupUI() {
        view.addSubview(sponsoredProductsLabel)
        sponsoredProductsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        sponsoredProductsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.topAnchor.constraint(equalTo: sponsoredProductsLabel.bottomAnchor, constant: 10).isActive = true
        horizontalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 10).isActive = true
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }

}

extension ProductViewController: ProductViewProtocol {
    func showProducts(_ products: [Product]) {
        for product in products {
            self.products.append(product)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print(self.products.count)
            self.contentView.setHeight(height: CGFloat(((self.products.count / 2) * 340 + 400)))
            self.view.layoutIfNeeded()
            self.contentView.layoutIfNeeded()
            self.scrollView.delegate = self
        }
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showSponsoredProducts(_ products: [Product]) {
        self.sponsoredProducts = products
        DispatchQueue.main.async {
            self.pageControl.numberOfPages = products.count
            self.horizontalCollectionView.reloadData()
        }
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return products.count
        } else if collectionView == self.horizontalCollectionView {
            return sponsoredProducts.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
            let product = products[indexPath.item]
            cell.configure(with: product)
            return cell
        } else if collectionView == self.horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsoredProductCell", for: indexPath) as! SponsoredProductCollectionViewCell
            let product = sponsoredProducts[indexPath.item]
            cell.configure(with: product)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let selectedProduct = products[indexPath.item]
            if let productId = selectedProduct.id {
                print(productId)
                presenter?.didSelectProduct(productId)
            }
        } else if collectionView == self.horizontalCollectionView {
            let selectedSponsoredProduct = sponsoredProducts[indexPath.item]
            if let productId = selectedSponsoredProduct.id {
                presenter?.didSelectProduct(productId)
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.horizontalCollectionView {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            self.pageControl.currentPage = Int(pageIndex)
        }else if scrollView == self.collectionView {
            let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
            if bottomEdge >= scrollView.contentSize.height {
                if paging < 3 {
                    paging = paging + 1
                    self.presenter?.fetchPaging(paging: paging)
                    print(paging)
                    print("test")
                }
            }
        }
    }    
}

