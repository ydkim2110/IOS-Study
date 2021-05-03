//
//  Member.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

import UIKit

struct Member {
    let name: String
    let bio: String
    
    var image: UIImage?
}

enum DefaultMemeber {
    static var members: [Member] = [
        Member(name: "홍길동", bio: "자바, 스프링 개발자 될래요."),
        Member(name: "이순신", bio: "안드로이드, IOS 개발 가능합니다..."),
        Member(name: "신사임당", bio: "React, NodeJs 개발자"),
        Member(name: "단군할아버지", bio: "프리랜서 입니다.")
    ]
}
