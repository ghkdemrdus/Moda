//
//  LottieAnimation+ModaData.swift
//  ModaResource
//
//  Created by 황득연 on 10/12/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import Lottie

extension LottieAnimation {
    static func from(asset: ModaResourceData) -> LottieAnimation? {
        return try? JSONDecoder().decode(LottieAnimation.self, from: asset.data.data)
    }
}
