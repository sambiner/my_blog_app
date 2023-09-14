//
//  ArticleDetail.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import SwiftUI

struct ArticleDetail: View {
    var article: Article
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ArticleMetadata(article: article)
                    .padding(.horizontal, 16)
                    .frame(height: 150.0)
                
                Text(article.body)
                    .font(.body)
                    .padding(.horizontal, 16)
                    .frame(height: 200.0)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                
                HStack {
                    Text("Tags:\(article.tags.joined(separator: " #"))")
                        .padding([.leading, .trailing])
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                Spacer()
            }
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: Article(
            id: "12345",
            title: "Preview",
            date: Date(),
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel odio neque. Aliquam erat volutpat. Duis volutpat urna vitae velit bibendum, eget convallis sem vehicula. In hac habitasse platea dictumst. Fusce dignissim odio at tincidunt aliquam. Sed vitae libero non odio sollicitudin venenatis. Etiam nec mauris sed purus tempor facilisis at at mauris. Suspendisse et convallis ante. In bibendum est ac sapien commodo feugiat. Quisque ut nibh libero.",
            tags: ["what", "is", "happening"]
        ))
    }
}
