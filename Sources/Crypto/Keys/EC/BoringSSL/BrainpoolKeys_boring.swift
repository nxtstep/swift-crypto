//
// Created by Arjan Duijzer on 15/09/2020.
//

#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
@_exported import CryptoKit
#else
@_implementationOnly import CCryptoBoringSSL
@_implementationOnly import CCryptoBoringSSLShims
import Foundation

extension BrainpoolP256r1 {
    @usableFromInline
    struct CurveDetails: OpenSSLSupportedNISTCurve {
        @inlinable
        static var group: BoringSSLEllipticCurveGroup {
            do {
                return try BoringSSLEllipticCurveGroup(.brainpoolP256r1)
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
}

#endif // (os(macOS) || underlyingCoreCryptoErroros(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API