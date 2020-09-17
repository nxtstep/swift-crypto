import DataKit
import XCTest

#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
// Skip tests that require @testable imports of CryptoKit.
#else
#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
@testable import CryptoKit
#else
@testable import Crypto
#endif

final class ECDHSharedSecretBrainpoolP256r1Tests: XCTestCase {
    func testDeriveSharedSecretFromBrainpoolP256r1() throws {
        let pubkeyraw = try orFail { try Data(hex: "048634212830DAD457CA05305E6687134166B9C21A65FFEBF555F4E75DFB04888866E4B6843624CBDA43C97EA89968BC41FD53576F82C03EFA7D601B9FACAC2B29") }
        let privateKeyRaw = try orFail { try Data(hex: "83456d98dea3435c166385a4e644ebca588e8a0aa7c811f51fcc736368630206") }
        let expectedSharedSecret = try orFail { try Data(hex: "29aaa0349b1a3aa99501ea0d087e05f0e7a51c356693be5ba010ca615c7bb5fd") }
        let pubKey = try orFail {  try BrainpoolP256r1.KeyAgreement.PublicKey(x963Representation: pubkeyraw) }
        let privateKey = try orFail { try BrainpoolP256r1.KeyAgreement.PrivateKey(rawRepresentation: privateKeyRaw) }
        let sharedSecret = try orFail { try privateKey.sharedSecretFromKeyAgreement(with: pubKey) }
        let sharedSecretData = sharedSecret.withUnsafeBytes { ptr in
            Data(bytes: ptr.baseAddress!, count: ptr.count)
        }

        XCTAssertNotEqual(privateKey.publicKey.rawRepresentation, pubKey.rawRepresentation)
        XCTAssertEqual(expectedSharedSecret, sharedSecretData)
    }

    func testDeriveSharedSecretFromBrainpoolP256r12() throws {
        let pubkeyraw = try Data(hex: "048634212830DAD457CA05305E6687134166B9C21A65FFEBF555F4E75DFB04888866E4B6843624CBDA43C97EA89968BC41FD53576F82C03EFA7D601B9FACAC2B29")
        let privateKeyRaw = try Data(hex: "5bbba34d47502bd588ed680dfa2309ca375eb7a35ddbbd67cc7f8b6b687a1c1d")
        let expectedSharedSecret = try Data(hex: "9656c2b4b3da81d0385f6a1ee60e93b91828fd90231c923d53ce7bbbcd58ceaa")
        let pubKey = try BrainpoolP256r1.KeyAgreement.PublicKey(x963Representation: pubkeyraw)
        let privateKey = try BrainpoolP256r1.KeyAgreement.PrivateKey(rawRepresentation: privateKeyRaw)
        let sharedSecret = try orFail { try privateKey.sharedSecretFromKeyAgreement(with: pubKey) }
        let sharedSecretData = sharedSecret.withUnsafeBytes { ptr in
            Data(bytes: ptr.baseAddress!, count: ptr.count)
        }

        XCTAssertNotEqual(privateKey.publicKey.rawRepresentation, pubKey.rawRepresentation)
        XCTAssertEqual(expectedSharedSecret, sharedSecretData)
    }
}

#endif