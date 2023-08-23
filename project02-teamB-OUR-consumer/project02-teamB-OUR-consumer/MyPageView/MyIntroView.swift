//
//  MyIntroView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyIntroView: View {
    @ObservedObject var resumeStore: ResumeStore = ResumeStore()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("자기소개")
                    .font(.system(size: 16))
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    // 자기소개 편집
                } label: {
                    Image(systemName: "pencil")
                }
            }
            .padding(.vertical, 5)
            
            Text(resumeStore.resume.introduction ?? "자기소개를 입력하세요")
                .font(.system(size: 14))
        }
        .padding()
        .foregroundColor(.black)
    }
}

struct MyIntroView_Previews: PreviewProvider {
    static var previews: some View {
        MyIntroView()
    }
}
