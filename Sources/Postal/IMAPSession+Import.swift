//
//  IMAPSession+Import.swift
//  Postal
//
//  Created by Viacheslav Savchenko on 7/23/18.
//  Copyright © 2018 snips. All rights reserved.
//

import Foundation
import libetpan

extension IMAPSession {
    func appendMessage(fileAt url: URL, toFolder: String) throws -> Int {
        try select(toFolder)

        let data = try Data(contentsOf: url)

        var validity: UInt32 = 0
        var uid: UInt32 = 0
        var status = MAILIMAP_ERROR_APPEND

        data.withUnsafeBytes { (pointer: UnsafePointer<Int8>) in
            let bytes = UnsafePointer<Int8>(OpaquePointer(pointer))
            status = Int(
                mailimap_uidplus_append(imap, toFolder.unreleasedUTF8CString, nil, nil, bytes, data.count, &validity, &uid)
            )
        }

        guard status == MAILIMAP_NO_ERROR else {
            throw PostalError.appendError(status)
        }

        return Int(uid)
    }
}
