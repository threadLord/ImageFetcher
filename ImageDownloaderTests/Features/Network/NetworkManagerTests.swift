//
//  NetworkManagerTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 7.8.24..
//

import XCTest
@testable import ImageDownloader

final class NetworkManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testDownloadFunctionality_ImageModelNetwork_ReturnEqualDecodedImage() async throws {
        let toEncode = ImageModelNetwork(id: 1, imageUrl: "http://")
        let encodedData = try JSONEncoder().encode(toEncode)
        
        let session = URLSessionProvider.customNewtorkManagerk(response: HTTPURLResponse(), data: encodedData)
        let request = URLRequest(url: URL(string: "http://example.com/")!)
        
        
        let networkManager = NetworkManager(session: session)
        let imageNetworkModel: ImageModelNetwork = try await networkManager.download(request: request, type: ImageModelNetwork.self)
        
        XCTAssertEqual(imageNetworkModel.imageUrl, toEncode.imageUrl)
    }
    
    func testNetworkManager_DataNil_ShouldReturnDecodeError() async throws {
        
        let session = URLSessionProvider.customNewtorkManagerk(response: HTTPURLResponse(), data: nil)
        let request = URLRequest(url: URL(string: "http://example.com/")!)
        
        
        let networkManager = NetworkManager(session: session)
        do {
            let imageNetworkModel: ImageModelNetwork = try await networkManager.download(request: request, type: ImageModelNetwork.self)
            XCTFail("Expected an error, but received a successful response: \(imageNetworkModel)")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.requestFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testNetworkManager_Response401_ShouldReturnDecodeError() async throws {
        let url = URL(string: "http://example.com/")!
        guard 
            let response: HTTPURLResponse = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: nil)
        else {
            XCTFail()
            return
        }
        
        let session = URLSessionProvider.customNewtorkManagerk(response: response, data: nil)
        let request = URLRequest(url: url)
        
        let networkManager = NetworkManager(session: session)
        do {
            let imageNetworkModel: ImageModelNetwork = try await networkManager.download(request: request, type: ImageModelNetwork.self)
            XCTFail("Expected an error, but received a successful response: \(imageNetworkModel)")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.requestFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    // upload functionality
    
    
    func testUploadFunctionality_ImageModelNetwork_ReturnEqualDecodedImage() async throws {
        let toEncode = ImageModelNetwork(id: 1, imageUrl: "http://")
        let encodedData = try JSONEncoder().encode(toEncode)
        
        let session = URLSessionProvider.customNewtorkManagerk(response: HTTPURLResponse(), data: encodedData)
        
        let request = URLRequest(url: URL(string: "http://example.com/")!)
        
        
        let networkManager = NetworkManager(session: session)
        let imageNetworkModel: ImageModelNetwork = try await networkManager.upload(request: request, data: encodedData, type: ImageModelNetwork.self)
        
        XCTAssertEqual(imageNetworkModel.imageUrl, toEncode.imageUrl)
    }
    
    func testNetworkManagerUploadFunction_DataNil_ShouldReturnDecodeError() async throws {
        let toEncode = ImageModelNetwork(id: 1, imageUrl: "http://")
        let encodedData = try JSONEncoder().encode(toEncode)
        
        let session = URLSessionProvider.customNewtorkManagerk(response: HTTPURLResponse(), data: nil)
        let request = URLRequest(url: URL(string: "http://example.com/")!)
        
        let networkManager = NetworkManager(session: session)
        do {
            let imageNetworkModel: ImageModelNetwork = try await networkManager.upload(request: request, data: encodedData, type: ImageModelNetwork.self)
            XCTFail("Expected an error, but received a successful response: \(imageNetworkModel)")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.requestFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testNetworkManagerUpload_Response401_ShouldReturnDecodeError() async throws {
        let url = URL(string: "http://example.com/")!
        guard
            let response: HTTPURLResponse = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: nil)
        else {
            XCTFail()
            return
        }
        
        let session = URLSessionProvider.customNewtorkManagerk(response: response, data: nil)
        let request = URLRequest(url: url)
        
        
        let networkManager = NetworkManager(session: session)
        do {
            let imageNetworkModel: ImageModelNetwork = try await networkManager.download(request: request, type: ImageModelNetwork.self)
            XCTFail("Expected an error, but received a successful response: \(imageNetworkModel)")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.requestFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
