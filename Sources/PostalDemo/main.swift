import Foundation
import Postal

let configuration = Configuration.icloud(login: "", password: "")
let postal = Postal(configuration: configuration)
var messages: [FetchResult] = []

postal.logger = { log in
    print("log:"+log)
}

postal.connect(timeout: Postal.defaultTimeout) { result in
	switch result {
	case .success: // Fetch 50 last mails of the INBOX
		postal.fetchLast("INBOX", last: 50, flags: [ .internalDate, .flags, .body, .fullHeaders ], onMessage: { message in
			messages.insert(message, at: 0)
			
        }) { error in
				if let error = error {
					print("❌ FETCH ERROR: \(error)\n")
				} else {
					print("✅")
				}
        }
	case .failure(let error):
		print("❌ CONNECTION ERROR: \(error)\n")
        exit(1)
	}
}

print(messages.count)
print(messages)

dispatchMain()
