import Foundation
import Vapor
import JWT

struct AuthPayload : JWTPayload {
    var subject : SubjectClaim
    var expiration : ExpirationClaim
    var userId : UUID
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try expiration.verifyNotExpired()
    }

    
    
}