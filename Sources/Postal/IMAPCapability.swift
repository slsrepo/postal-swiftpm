//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Snips
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

public struct IMAPCapability: OptionSet {
    public let rawValue: Int64
    public init(rawValue: Int64) { self.rawValue = rawValue }
    
    public static let ACL =                    IMAPCapability(rawValue: 1 << 0)
    public static let Binary =                 IMAPCapability(rawValue: 1 << 1)
    public static let Catenate =               IMAPCapability(rawValue: 1 << 2)
    public static let Children =               IMAPCapability(rawValue: 1 << 3)
    public static let CompressDeflate =        IMAPCapability(rawValue: 1 << 4)
    public static let Condstore =              IMAPCapability(rawValue: 1 << 5)
    public static let Enable =                 IMAPCapability(rawValue: 1 << 6)
    public static let Idle =                   IMAPCapability(rawValue: 1 << 7)
    public static let Id =                     IMAPCapability(rawValue: 1 << 8)
    public static let LiteralPlus =            IMAPCapability(rawValue: 1 << 9)
    public static let Move =                   IMAPCapability(rawValue: 1 << 10)
    public static let MultiAppend =            IMAPCapability(rawValue: 1 << 11)
    public static let Namespace =              IMAPCapability(rawValue: 1 << 12)
    public static let QResync =                IMAPCapability(rawValue: 1 << 13)
    public static let Quota =                  IMAPCapability(rawValue: 1 << 14)
    public static let Sort =                   IMAPCapability(rawValue: 1 << 15)
    public static let StartTLS =               IMAPCapability(rawValue: 1 << 16)
    public static let ThreadOrderedSubject =   IMAPCapability(rawValue: 1 << 17)
    public static let ThreadReferences =       IMAPCapability(rawValue: 1 << 18)
    public static let UIDPlus =                IMAPCapability(rawValue: 1 << 19)
    public static let Unselect =               IMAPCapability(rawValue: 1 << 20)
    public static let XList =                  IMAPCapability(rawValue: 1 << 21)
    public static let AuthAnonymous =          IMAPCapability(rawValue: 1 << 22)
    public static let AuthCRAMMD5 =            IMAPCapability(rawValue: 1 << 23)
    public static let AuthDigestMD5 =          IMAPCapability(rawValue: 1 << 24)
    public static let AuthExternal =           IMAPCapability(rawValue: 1 << 25)
    public static let AuthGSSAPI =             IMAPCapability(rawValue: 1 << 26)
    public static let AuthKerberosV4 =         IMAPCapability(rawValue: 1 << 27)
    public static let AuthLogin =              IMAPCapability(rawValue: 1 << 28)
    public static let AuthNTLM =               IMAPCapability(rawValue: 1 << 29)
    public static let AuthOTP =                IMAPCapability(rawValue: 1 << 30)
    public static let AuthPlain =              IMAPCapability(rawValue: 1 << 31)
    public static let AuthSKey =               IMAPCapability(rawValue: 1 << 32)
    public static let AuthSRP =                IMAPCapability(rawValue: 1 << 33)
    public static let XOAuth2 =                IMAPCapability(rawValue: 1 << 34)
    public static let XYMHighestModseq =       IMAPCapability(rawValue: 1 << 35)
    public static let Gmail =                  IMAPCapability(rawValue: 1 << 36)
}

extension IMAPCapability: CustomStringConvertible {
    public var description: String {
        let flags: [(IMAPCapability, String)] = [
            (.ACL, "ACL"),
            (.Binary, "Binary"),
            (.Catenate, "Catenate"),
            (.Children, "Children"),
            (.CompressDeflate, "CompressDeflate"),
            (.Condstore, "Condstore"),
            (.Enable, "Enable"),
            (.Idle, "Idle"),
            (.Id, "Id"),
            (.LiteralPlus, "LiteralPlus"),
            (.Move, "Move"),
            (.MultiAppend, "MultiAppend"),
            (.Namespace, "Namespace"),
            (.QResync, "QResync"),
            (.Quota, "Quota"),
            (.Sort, "Sort"),
            (.StartTLS, "StartTLS"),
            (.ThreadOrderedSubject, "ThreadOrderedSubject"),
            (.ThreadReferences, "ThreadReferences"),
            (.UIDPlus, "UIDPlus"),
            (.Unselect, "Unselect"),
            (.XList, "XList"),
            (.AuthAnonymous, "AuthAnonymous"),
            (.AuthCRAMMD5, "AuthCRAMMD5"),
            (.AuthDigestMD5, "AuthDigestMD5"),
            (.AuthExternal, "AuthExternal"),
            (.AuthGSSAPI, "AuthGSSAPI"),
            (.AuthKerberosV4, "AuthKerberosV4"),
            (.AuthLogin, "AuthLogin"),
            (.AuthNTLM, "AuthNTLM"),
            (.AuthOTP, "AuthOTP"),
            (.AuthPlain, "AuthPlain"),
            (.AuthSKey, "AuthSKey"),
            (.AuthSRP, "AuthSRP"),
            (.XOAuth2, "XOAuth2"),
            (.XYMHighestModseq, "XYMHighestModseq"),
            (.Gmail, "Gmail")
        ]
        return representation(flags)
    }
}
