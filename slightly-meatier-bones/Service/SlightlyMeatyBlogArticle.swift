//
//  SlightlyMeatyBlogArticle.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import Foundation

import Firebase
import FirebaseFirestore

let COLLECTION_NAME = "articles"
let PAGE_LIMIT = 20
private var searchTerm = ""

enum ArticleServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

class SlightlyMeatyBlogArticle: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var error: Error?
    
    func createArticle(article: Article) -> String {
        var ref: DocumentReference? = nil
        ref = db.collection(COLLECTION_NAME).addDocument(data: [
            "title": article.title,
            "date": article.date,
            "body": article.body,
            "tags": article.tags
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
        return ref?.documentID ?? ""
    }
    
    func fetchArticles(query: String, startAfter: DocumentSnapshot? = nil, limit: Int = PAGE_LIMIT) async throws -> ([Article], DocumentSnapshot?) {
        var articleQuery: Query = db.collection(COLLECTION_NAME)
            .order(by: "date", descending: true)
        
        if let lastDoc = startAfter {
            articleQuery = articleQuery.start(afterDocument: lastDoc)
        }
        articleQuery = articleQuery.limit(to: limit)
        
        let querySnapshot = try await articleQuery.getDocuments()
        
        let articles = try querySnapshot.documents.map {
            guard let title = $0.get("title") as? String,
                  let dateAsTimestamp = $0.get("date") as? Timestamp,
                  let body = $0.get("body") as? String,
                  let tags = $0.get("tags") as? [String] else {
                throw ArticleServiceError.mismatchedDocumentError
            }
            return Article(
                id: $0.documentID,
                title: title,
                date: dateAsTimestamp.dateValue(),
                body: body,
                tags: tags
            )
        }
        
        let lastDocument = querySnapshot.documents.last
        
        return (articles, lastDocument)
    }
}
