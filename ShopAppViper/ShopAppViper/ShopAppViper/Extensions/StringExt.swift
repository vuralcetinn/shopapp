//
//  StringExt.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 18.06.2024.
//

import Foundation

extension String {

func strikeThrough() -> NSAttributedString {
  let attributeString = NSMutableAttributedString(string: self)
  attributeString.addAttribute(
    NSAttributedString.Key.strikethroughStyle,
    value: 1,
    range: NSRange(location: 0, length: attributeString.length))
    return attributeString
   }
 }
