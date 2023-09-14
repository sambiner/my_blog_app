//
//  ArticleEntry.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import SwiftUI

struct ArticleEntry: View {
    @EnvironmentObject var articleService: SlightlyMeatyBlogArticle
    
    @Binding var articles: [Article]
    @Binding var writing: Bool
    
    @State var title = ""
    @State var articleBody = ""
    @State var tagsString = ""
    
    func submitArticle() {
        let tags = tagsString.split(separator: " #").map(String.init).map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        let articleId = articleService.createArticle(article: Article(
            id: UUID().uuidString,
            title: title,
            date: Date(),
            body: articleBody,
            tags: tags
        ))
        articles.append(Article(
            id: articleId,
            title: title,
            date: Date(),
            body: articleBody,
            tags: tags
        ))
        
        writing = false
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    TextField("", text: $title)
                }
                
                Section(header: Text("Body")){
                    TextEditor(text: $articleBody)
                        .frame(minHeight: 250)
                }
                
                Section(header: Text("Tags (separated by a space and #)")) {
                    TextField("", text: $tagsString)
                }
            }
            .navigationTitle("New Article")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        submitArticle()
                    }
                    .disabled(title.isEmpty || articleBody.isEmpty)
                }
            }
        }
    }
}

struct ArticleEntry_Previews: PreviewProvider {
    @State static var articles: [Article] = []
    @State static var writing = true
    static var previews: some View {
        ArticleEntry(articles: $articles, writing: $writing)
            .environmentObject(SlightlyMeatyBlogArticle())
    }
}
