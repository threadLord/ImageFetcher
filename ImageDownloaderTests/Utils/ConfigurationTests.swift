//
//  ConfigurationTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 7.8.24..
//

import XCTest
@testable import ImageDownloader

import XCTest

class ConfigurationTests: XCTestCase {
    func testValueForExistingKey() {
        // Given
        let key = ConfigKeys.baseUrl.rawValue
        let expectedValue: String = "zipoapps-storage-test.nyc3.digitaloceanspaces.com/"

        // When
        do {
            let value: String = try Configuration.value(for: key)

            // Then
            XCTAssertEqual(value, expectedValue, "Value should match the expected value")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testValueForMissingKey() {
        // Given
        let missingKey = "NonExistentKey"

        // When
        do {
            let _: String = try Configuration.value(for: missingKey)

            // Then
            XCTFail("Expected missing key error")
        } catch {
            XCTAssertTrue(error is Configuration.Error, "Error should be of type Configuration.Error")
            XCTAssertEqual(error as? Configuration.Error, .missingKey, "Error should be .missingKey")
        }
    }

    func testValueForInvalidValue() {
        // Given
        let key = ConfigKeys.baseUrl.rawValue

        // When
        do {
            let _: Double = try Configuration.value(for: key)

            // Then
            XCTFail("Expected invalid value error")
        } catch {
            XCTAssertTrue(error is Configuration.Error, "Error should be of type Configuration.Error")
            XCTAssertEqual(error as? Configuration.Error, .invalidValue, "Error should be .invalidValue")
        }
    }
}
