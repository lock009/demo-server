//
//  JSONWebTokenAuthenticator.swift
//  Demo-Server
//
//  Created by Rajveer Mann on 09/02/26.
//



import Vapor
import JWT
import Foundation

struct JSONWebTokenAuthenticator : AsyncRequestAuthenticator {
    
    func authenticate(request : Request) async throws {
        try await request.jwt.verify(as : AuthPayload.self)
    }
}
