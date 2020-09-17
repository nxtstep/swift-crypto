//
// Created by Arjan Duijzer on 15/09/2020.
//

import Foundation

#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
@_exported import CryptoKit
#else

protocol BrainpoolPublicKey: ECPublicKey {
    init<Bytes: ContiguousBytes>(compactRepresentation: Bytes) throws
    init<Bytes: ContiguousBytes>(x963Representation: Bytes) throws

    var compactRepresentation: Data? { get }
    var x963Representation: Data { get }
}

protocol BrainpoolPrivateKey: ECPrivateKey where PublicKey: BrainpoolPublicKey {
    init <Bytes: ContiguousBytes>(rawRepresentation: Bytes) throws
    var rawRepresentation: Data { get }
}

/// The BrainpoolP256r1 Elliptic Curve.
public enum BrainpoolP256r1 { }

#endif // Linux or !SwiftPM