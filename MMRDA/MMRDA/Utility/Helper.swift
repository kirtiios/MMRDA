//
//  Helper.swift
//  MMRDA
//
//  Created by Kirti Chavda on 22/08/22.
//

import UIKit
import CommonCrypto


class Helper: NSObject {
    
    static let shared = Helper()
    var objloginData:LoginDataModel?
    
    func passwordEncryptedsha256(str: String) -> String {
     
        if let strData = str.data(using: String.Encoding.utf8) {
            /// #define CC_SHA256_DIGEST_LENGTH     32
            /// Creates an array of unsigned 8 bit integers that contains 32 zeros
            var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
     
            /// CC_SHA256 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
            /// Takes the strData referenced value (const unsigned char *d) and hashes it into a reference to the digest parameter.
            strData.withUnsafeBytes {
                // CommonCrypto
                // extern unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)  -|
                // OpenSSL                                                                             |
                // unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)        <-|
                CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
            }
     
            var sha256String = ""
            /// Unpack each byte in the digest array and add them to the sha256String
            for byte in digest {
                sha256String += String(format:"%02x", UInt8(byte))
            }
     
            return sha256String
        }
        return ""
    }
}
