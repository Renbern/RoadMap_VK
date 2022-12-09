// GetDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Операция получения данных из сети
final class GetDataOperation: AsyncOperation {
    // MARK: - Public properties

    var data: Data?

    // MARK: - Private properties

    private var request: DataRequest

    // MARK: - Initializer

    init(request: DataRequest) {
        self.request = request
    }

    // MARK: - Public methods

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }

    override func cancel() {
        request.cancel()
        super.cancel()
    }
}
