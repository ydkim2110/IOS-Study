//
//  MemberService.swift
//  Study Example
//
//  Created by 김용대 on 2021/04/15.
//

struct MemberService {
    static let shared = MemberService()
    
    func saveMember(forMember member: Member, completion: @escaping () -> Void) {
        DefaultMemeber.members.append(member)
        completion()
    }
}
