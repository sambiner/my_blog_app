//
//  Articles.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import Foundation

struct Article: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var date: Date
    var body: String
    var tags: [String]
}
