//
//  ArticleList.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import SwiftUI
import FirebaseFirestore


class FetchStatus: ObservableObject {
    @Published var isFetching = false
}

struct ArticleList: View {
    @EnvironmentObject var auth: SlightlyMeatyAuth
    @EnvironmentObject var articleService: SlightlyMeatyBlogArticle
    
    @Binding var requestLogin: Bool
    
    @State var articles: [Article]
    @State var error: Error?
    @StateObject var fetching = FetchStatus()
    @State var writing = false
    @State private var query = ""
    @State private var lastDocument: DocumentSnapshot?
    @State private var nextPageLastDocument: DocumentSnapshot?
    @State private var prevPageLastDocument: [DocumentSnapshot] = []
    @State var darkMode: Bool = false
    private let PAGE_LIMIT = 2
    private let images = ["slightly_meatier_bone", "stone", "cat"] // yes this is developer's chosen image to feature on the page, therefore hardcoded.
    @State private var selectedImageIndex = 0
    
    var filteredArticles: [Article] {
        guard !query.isEmpty else { return articles }
        return articles.filter { article in
            article.tags.contains { tag in
                tag.lowercased().contains(query.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack {
                    TabView(selection: $selectedImageIndex) {
                        ForEach(0..<images.count) { index in
                            Image(images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .background(darkMode ? .black : .white)
                                .tag(index)
                        }
                    }
                    .onAppear {
                        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                            if selectedImageIndex == images.count - 1 {
                                selectedImageIndex = 0
                            } else {
                                selectedImageIndex += 1
                            }
                        }
                        RunLoop.main.add(timer, forMode: .common)
                    }
                }
                VStack(alignment: .leading) {
                    if fetching.isFetching {
                        LoadingScreen()
                    } else if error != nil {
                        Text("Something went wrong... we wish we can say more")
                    } else if filteredArticles.count == 0 {
                        VStack {
                            Spacer()
                            Text("There are no articles.")
                            Spacer()
                        }
                    } else {
                        List(filteredArticles) { article in
                            NavigationLink {
                                ArticleDetail(article: article)
                            } label: {
                                ArticleMetadata(article: article)
                            }

                            
                        }
                        .refreshable {
                            await refreshArticles()
                        }
                    }
                    Toggle("Darkmode", isOn: $darkMode)
                        .padding()
                        .onTapGesture(count: 1, perform: {darkMode.toggle()})
                    HStack {
                        Button(action: {
                            Task {
                                await refreshArticles()
                            }
                        }) {
                            Text("Reset")
                        }
                        .disabled(fetching.isFetching)
                        Spacer()
                        Button(action: {
                            Task {
                                await fetchNextPage()
                            }
                        }) {
                            Text("Next")
                        }
                        .disabled(fetching.isFetching)
                    }
                    .padding()
                }
                .preferredColorScheme(darkMode ? .dark : .light)
                .navigationTitle("Slightly Meatier Blog")
                .searchable(text: $query, prompt: "Search by Tags")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if auth.user != nil {
                            Button("New Article") {
                                writing = true
                            }
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if auth.user != nil {
                            Button("Sign Out") {
                                do {
                                    try auth.signOut()
                                } catch {
                                    
                                }
                            }
                        } else {
                            Button("Sign In") {
                                requestLogin = true
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $writing) {
            ArticleEntry(articles: $articles, writing: $writing)
        }
        .task {
            await fetchNextPage()
        }
    }
    
    func fetchNextPage() async {
        fetching.isFetching = true
        do {
            let (newArticles, newLastDocument) = try await articleService.fetchArticles(query: query, startAfter: lastDocument, limit: PAGE_LIMIT)
            if newArticles.isEmpty {
                fetching.isFetching = false
                return
            }
            articles.append(contentsOf: newArticles)
            lastDocument = newLastDocument
            fetching.isFetching = false
        } catch {
            self.error = error
            fetching.isFetching = false
        }
        fetching.isFetching = false
    }
    
    func refreshArticles() async {
        fetching.isFetching = true
        lastDocument = nil
        do {
            (articles, lastDocument) = try await articleService.fetchArticles(query: query, startAfter: lastDocument, limit: PAGE_LIMIT)
            fetching.isFetching = false
        } catch {
            self.error = error
            fetching.isFetching = false
        }
        fetching.isFetching = false
    }
}

struct ArticleList_Previews: PreviewProvider {
    @State static var requestLogin = false
    static var previews: some View {
        ArticleList(requestLogin: $requestLogin, articles: [])
            .environmentObject(SlightlyMeatyAuth())
        
        ArticleList(requestLogin: $requestLogin, articles: [
            Article(
                id: "12345",
                title: "Preview",
                date: Date(),
                body: "Lorem ipsum dolor sit something something amet",
                tags: ["Funny", "Lorem", "Ipsum"]
            ),
            Article(
                id: "69420",
                title: "Some time ago",
                date: Date(timeIntervalSinceNow: TimeInterval(-604800)),
                body: "Duis diam isum, efficitur sit amet something somesit amet",
                tags: ["whaaaat", "nooooo", "waaaay"]
            )
        ])
        .environmentObject(SlightlyMeatyAuth())
        .environmentObject(SlightlyMeatyBlogArticle())
    }
}
