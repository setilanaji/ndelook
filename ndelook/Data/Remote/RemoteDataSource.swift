//
//  RemoteDataSource.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

final class RemoteDataSource: NSObject {
    typealias RemoteDataSourceInstance = (APIServiceManager) -> RemoteDataSource
    
    internal let manager: APIServiceManager
    
    private init(manager: APIServiceManager) {
        self.manager = manager
    }
    
    static let shared: RemoteDataSourceInstance = { serviceManager in
        RemoteDataSource(manager: serviceManager)
    }
}
