//
//  LinkinBioPost.swift
//  LinkinBio
//
//  Created by Paul Huynh on 2021-02-20.
//  Copyright © 2021 Ian MacKinnon. All rights reserved.
//

import Foundation

struct LinkinBioPost: Codable {
    let linkinbio_posts: [Post]
}

struct Post: Codable {
    let image_url: String
    let link_url: String
}
