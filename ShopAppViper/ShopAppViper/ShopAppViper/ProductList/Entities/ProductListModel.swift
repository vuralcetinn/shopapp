import Foundation

// MARK: - ProductListModel
struct ProductListModel: Codable {
    let page, nextPage, publishedAt: String?
    let sponsoredProducts, products: [Product]?

    enum CodingKeys: String, CodingKey {
        case page, nextPage
        case publishedAt = "published_at"
        case sponsoredProducts, products
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, image: String?
    let price, instantDiscountPrice, rate: Double?
    let sellerName: String?
    
    func getDiscountRate() -> Double {
        if price != nil &&  instantDiscountPrice != nil {
            return ((price! - instantDiscountPrice!) / price!) * 100
        }else {
            return 0.0
        }
    }
}
