//
//  StubPost.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/20/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

@testable import TransferWiseDemo

class StubPost:Post {

   static func dummyPost() -> StubPost  {
      return StubPost(userID: 1, id: 1, title: "Dummy Title", body: "Dummy Body")
    }
}
