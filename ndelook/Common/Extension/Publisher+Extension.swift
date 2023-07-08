//
//  Publisher+Extension.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

extension Publisher {
    public func convertToResultPublisher() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map { .success($0) }
            .catch { error in
                Just(.failure(error))
            }.eraseToAnyPublisher()
    }
}
