//
//  PostView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostView: View {
    
    var post: PostModel
    
    @State var isSpreadBtn: Bool = false
    @State var lineLimitNumber: Int = 2
    
    @State var likeCount: Int = 0
    @State var commentCount: Int = 0
    @State var rePostCount: Int = 0
    
    var body: some View {
        Group {
            TabView {
                ForEach(post.postImagePath, id: \.self) { imagePath in
                    AsyncImage(url: URL(string: imagePath)) { image in
                        image
                            .resizable()
                            .frame(height: 400)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 350)
            
                
            VStack(alignment: .leading) {
                HStack(alignment: .bottom, spacing: 10) {
                    Text("\(post.content)")
                        .font(.system(size: 16))
                        .lineLimit(lineLimitNumber)
                    Button {
                        isSpreadBtn.toggle()
                        lineLimitNumber = isSpreadBtn ? 10 : 2
                    } label: {
                        Text("\(isSpreadBtn ? "접기" : "더보기")")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                HStack() {
                    Text("\(post.createdAt)")
                    Spacer()
//                    Text("좋아요 \(post.numberOfLike)")
//                    Text("댓글 \(post.numberOfComments)")
//                    Text("퍼감 \(post.numberOfRepost)")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding()
            }
        }
        
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostView(post: PostModel(creator: "dsfdsf", privateSetting: false, content: "abcd", createdAt: "2023/5/30", location: "천안", postImagePath: [""], reportCount: 0))
        }
    }
}
