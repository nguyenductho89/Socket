import UIKit
import SwiftSocket

class ViewController: UIViewController {
  
  @IBOutlet weak var textView: UITextView!
  
  let host = "192.168.14.5"
  let port = 12345
  var client: UDPClient?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    client = UDPClient(address: host, port: Int32(port))
  }
  
  @IBAction func sendButtonAction() {
    guard let client = client else { return }
    
      client.send(string: "thond")
  }
  
  private func sendRequest(string: String, using client: TCPClient) -> String? {
    appendToTextField(string: "Sending data ... ")
    
    switch client.send(string: string) {
    case .success:
      return readResponse(from: client)
    case .failure(let error):
      appendToTextField(string: String(describing: error))
      return nil
    }
  }
  
  private func readResponse(from client: TCPClient) -> String? {
    guard let response = client.read(1024*10) else { return nil }
    
    return String(bytes: response, encoding: .utf8)
  }
  
  private func appendToTextField(string: String) {
    print(string)
    textView.text = textView.text.appending("\n\(string)")
  }

}
