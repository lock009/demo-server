import Vapor
import JWT
import Foundation

struct JSONWebTokenAuthenticator : AsyncRequestAuthenticator {
    
    func authenticate(request : Request) async throws {
        try await request.jwt.verify(as : AuthPayload.self)
    }
}
