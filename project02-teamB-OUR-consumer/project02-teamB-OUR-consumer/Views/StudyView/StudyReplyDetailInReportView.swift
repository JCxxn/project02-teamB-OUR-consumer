//
//  StudyReplyDetailInReportView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/25.
//

import SwiftUI

struct StudyReplyDetailInReportView: View {
    
    var comment: StudyGroupComment
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    //해당 프로필 시트 올려주는 ~
                } label: {
                    Image("OUR_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                        .clipShape(Circle())
                }
                
                
                VStack(alignment: .leading, spacing: 5){
                    HStack {
                        Text(comment.userId)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Text(comment.createdAt)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                    }
                    Text(comment.content)
                        .font(.system(size: 14))
                    
                }
                Spacer()
                
                Image(systemName: "ellipsis")
                    .padding()
                    .foregroundColor(.gray)
            }
            
        }
        
    }
}

struct StudyReplyDetailInReportView_Previews: PreviewProvider {
    static var previews: some View {
        StudyReplyDetailInReportView(comment: StudyGroupComment(userId: "1", content: "diudididi", createdAt: "2022-11"))
    }
}
