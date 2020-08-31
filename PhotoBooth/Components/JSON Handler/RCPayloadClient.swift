import Foundation

protocol RCPayloadRetrievable {
    func getPayload(data: NSData, completion: @escaping (Result<[RCPayload], NetworkError>) -> Void)
}

class RCPayloadClient: RCPayloadRetrievable {
    func getPayload(data: NSData, completion: @escaping (Result<[RCPayload], NetworkError>) -> Void) {
        getPayloadData(data: data, completion: completion)
    }

    private func getPayloadData(data: NSData, completion: @escaping (Result<[RCPayload], NetworkError>) -> Void) {
        do {
            print("data marker")
            print(data)
            let payloadModel = try JSONDecoder().decode(configPayload.self, from: data as Data)
            completion(.success(payloadModel))
        } catch {
            completion(.failure(NetworkError.jsonDecoding(error)))
            print(NetworkError.jsonDecoding(error))
        }
    }
}
