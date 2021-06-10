//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Snips
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import libetpan

extension IMAPSession {

    func set(_ flag: MessageFlag, folder: String, uid: UInt) throws {
        guard let flagType = flag.mailimapType else {
            return
        }

        try select(folder)

        guard var flagList = try fetchFlags(folder, uid: uid) else {
            return
        }

        var flagSet = false

        var newFlagList = mailimap_flag_list_new_empty()
        defer { mailimap_flag_list_free(newFlagList) }

        sequence(&flagList, of: mailimap_flag_fetch.self).forEach {
            if flagType == Int($0.fl_flag.pointee.fl_type) {
                flagSet = true
            }

            mailimap_flag_list_add(newFlagList, $0.fl_flag)
        }

        guard flagSet == false else {
            return
        }

        guard let flag = mailimap_flag.makeFlag(with: flag) else {
            return
        }

        mailimap_flag_list_add(newFlagList, flag)

        try store(newFlagList, uid: uid)
    }

    func drop(_ flag: MessageFlag, folder: String, uid: UInt) throws {
        guard let flagType = flag.mailimapType else {
            return
        }

        try select(folder)

        guard var flagList = try fetchFlags(folder, uid: uid) else {
            return
        }

        var flagSet = false

        var newFlagList = mailimap_flag_list_new_empty()
        defer { mailimap_flag_list_free(newFlagList) }

        sequence(&flagList, of: mailimap_flag_fetch.self).forEach {
            guard flagType != Int($0.fl_flag.pointee.fl_type) else {
                flagSet = true
                return
            }
            mailimap_flag_list_add(newFlagList, $0.fl_flag)
        }

        guard flagSet else {
            return
        }

        try store(newFlagList, uid: uid)
    }

    private func fetchFlags(_ folder: String, uid: UInt) throws -> clist? {
        let indexSet = IndexSet(integer: Int(uid))
        let imapSet = indexSet.unreleasedMailimapSet
        defer { mailimap_set_free(imapSet) }

        let type = mailimap_fetch_type_new_fast()
        defer { mailimap_fetch_type_free(type) }

        var result: UnsafeMutablePointer<clist>?
        try mailimap_uid_fetch(imap, imapSet, type, &result).toIMAPError?.check()

        guard let attributes = result else {
            return clist_new()?.pointee
        }

        var flagsAttribute: mailimap_msg_att_item?
        for value in sequence(attributes, of: mailimap_msg_att.self) {
            for item in sequence(value.att_list, of: mailimap_msg_att_item.self) {
                if Int(item.att_type) == MAILIMAP_MSG_ATT_ITEM_DYNAMIC {
                    flagsAttribute = item
                    break
                }
            }

            if flagsAttribute != nil {
                break
            }
        }

        guard let attDyn = flagsAttribute?.att_data.att_dyn else {
            return clist_new()?.pointee
        }

        guard let attList = attDyn.pointee.att_list else {
            return clist_new()?.pointee
        }

        return attList.pointee
    }

    private func store(_ flags: UnsafeMutablePointer<mailimap_flag_list>?, uid: UInt) throws {
        let storeFlagsSet = mailimap_store_att_flags_new_set_flags_silent(flags)

        let indexSet = IndexSet(integer: Int(uid))
        let imapSet = indexSet.unreleasedMailimapSet
        defer { mailimap_set_free(imapSet) }

        try mailimap_uid_store(imap, imapSet, storeFlagsSet).toIMAPError?.check()
    }

}
