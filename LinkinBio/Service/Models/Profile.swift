//
//  InstagramProfile.swift
//  LinkinBio
//
//  Created by Paul Huynh on 2021-02-20.
//  Copyright © 2021 Ian MacKinnon. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let instagram_profiles: [ProfileInformation]
    let social_profiles: [ProfileInformation]
}


struct ProfileInformation: Codable {
    let id: Int
    let nickname: String
    let avatar_url: String
    let name: String
    let default_link: String
    let linkinbio_prompt: String
    let uid: String
}
