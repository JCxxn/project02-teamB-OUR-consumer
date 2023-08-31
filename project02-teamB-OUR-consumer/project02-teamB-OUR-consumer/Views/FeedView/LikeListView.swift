//
//  LikeListView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/29.
//

import SwiftUI

struct LikeListView: View {
    
    var post: Post
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    var postFireService: PostFireService = PostFireService()
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    
    @Binding var isToggle: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(postViewModel.postModel.likedUsers) { like in
                    HStack{
                        Image("OUR_Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 40)
                            .padding(.trailing, 10)
                        Text("\(like.name)")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        
//                        Button {
//                            postModel.
//                        } label: {
//                            if !postModel. {
//                                FollowButtonView()
//                            } else {
//                                FollowingButtonView()
//                            }
//                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Like List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isToggle.toggle()
                    } label: {
                        Text("닫기")
                            .foregroundColor(Color(hex: 0x090580))
                    }
                }
            }
            .onAppear {
                postViewModel.getPost(of: post) { post in
                    self.postModel = post
                }
            }
        }
        
    }
}

struct LikeListView_Previews: PreviewProvider {
    static var previews: some View {
        LikeListView(post: Post.samplePost, isToggle: .constant(true))
            .environmentObject(PostViewModel())
    }
}
