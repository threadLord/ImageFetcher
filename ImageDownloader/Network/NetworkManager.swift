//
//  NetworkManager.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import Foundation

struct NetworkManager: NetworkManagerProtocol {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func upload<T>(request: URLRequest, data: Data, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        do {
            let (data, response) = try await session.upload(for: request, from: data)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let response: T = try JSONDecoder().decode(T.self, from: data)
                return response
            } catch {
                throw NetworkError.decodingError
            }
            
        } catch {
            throw NetworkError.requestFailed
        }
    }
    
    func download<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let response: T = try JSONDecoder().decode(T.self, from: data)
                return response
            } catch {
                throw NetworkError.decodingError
            }
            
        } catch {
            throw NetworkError.requestFailed
        }
    }
}
