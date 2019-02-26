//
//  StubComments.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/20/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

@testable import TransferWiseDemo

class StubComments:Comment {

   static func dummyComment() -> StubComments  {
    return StubComments(postID: 1, id: 1, name: "Dummy Title", email: "a@abc.com", body: "")
    }
}
