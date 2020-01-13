struct Secrets {

    private static let salt: [UInt8] = [
        0x11, 0x66, 0x36, 0x2d, 0x8a, 0x8b, 0x02, 0x31,
        0x19, 0x10, 0xcb, 0x31, 0x1b, 0x18, 0x05, 0xe0,
        0xa2, 0x03, 0xb2, 0xd9, 0x24, 0xfa, 0xc5, 0xcc,
        0xdd, 0x5e, 0x32, 0x21, 0x6d, 0x25, 0x4b, 0x35,
        0x39, 0x4e, 0x32, 0x50, 0x5e, 0x60, 0x44, 0x75,
        0x41, 0xca, 0xbc, 0xf9, 0xf0, 0xb4, 0x21, 0x58,
        0xcf, 0xa7, 0xef, 0x0a, 0x7e, 0x94, 0x45, 0x09,
        0xee, 0xd4, 0x81, 0xb1, 0xa5, 0x2f, 0x1f, 0xb3
    ]

    static var apiKey: String {
        let encoded: [UInt8] = [
            0x29, 0x50, 0x0f, 0x14, 0xb9, 0xe9, 0x67, 0x01,
            0x21, 0x25, 0xf9, 0x57, 0x2f, 0x7c, 0x30, 0x81,
            0xc3, 0x62, 0xd1, 0xe1, 0x12, 0xce, 0xa0, 0xfc,
            0xe4, 0x66, 0x01, 0x40, 0x5a, 0x1d, 0x72, 0x02
        ]
        return decode(encoded, cipher: salt)
    }

    static func decode(_ encoded: [UInt8], cipher: [UInt8]) -> String {
        String(decoding: encoded.enumerated().map { (offset, element) in
            element ^ cipher[offset % cipher.count]
        }, as: UTF8.self)
    }

}
