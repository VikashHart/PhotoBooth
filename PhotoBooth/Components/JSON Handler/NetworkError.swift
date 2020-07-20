import Foundation

enum NetworkError: Error {
    case jsonDecoding(Error)
    case networkError
    case clientError
    case serverError
    case unknownError
}
