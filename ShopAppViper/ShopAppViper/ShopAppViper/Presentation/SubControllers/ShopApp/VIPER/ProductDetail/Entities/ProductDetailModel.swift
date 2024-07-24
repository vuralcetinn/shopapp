import Foundation

// MARK: - ProductDetail
struct ProductDetail: Codable {
    let title, description: String?
    let images: [String]?
    let price, instantDiscountPrice: Int?
    let rate: Double?
    let sellerName: String?
    
    func getDiscountRate() -> Double {
        if price != nil &&  instantDiscountPrice != nil {
            return Double(((price! - instantDiscountPrice!) / price!) * 100)
        }else {
            return 0.0
        }
    }
}
