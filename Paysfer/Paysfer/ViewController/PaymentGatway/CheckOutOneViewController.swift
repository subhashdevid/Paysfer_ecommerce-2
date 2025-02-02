//
//  CheckOutOneViewController.swift
//  Paysfer
//
//  Created by SUBHASH KUMAR on 20/09/20.
//  Copyright © 2020 VISHAL VERMA. All rights reserved.
//

import UIKit
import Stripe


class CheckOutOneViewController: UIViewController {
  var paymentIntentClientSecret: String?

  let service = ServerHandler()
    
  lazy var cardTextField: STPPaymentCardTextField = {
    let cardTextField = STPPaymentCardTextField()
    return cardTextField
  }()

  lazy var payButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.cornerRadius = 5
    button.backgroundColor = .systemBlue
    button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
    button.setTitle("Pay now", for: .normal)
    button.addTarget(self, action: #selector(pay), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
   

    view.backgroundColor = .white
    let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
      view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
    ])
    startCheckout()
  }

  func displayAlert(title: String, message: String, restartDemo: Bool = false) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel))
      self.present(alert, animated: true, completion: nil)
    }
  }

  func startCheckout() {
    // Create a PaymentIntent as soon as the view loads
//    let url = URL(string: backendUrl + "create-payment-intent")!
//    let json: [String: Any] = [
//      "items": [
//          ["id": "xl-shirt"]
//      ]
//    ]
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpBody = try? JSONSerialization.data(withJSONObject: json)
//    let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
//      guard let response = response as? HTTPURLResponse,
//        response.statusCode == 200,
//        let data = data,
//        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
//        let clientSecret = json["clientSecret"] as? String else {
//            let message = error?.localizedDescription ?? "Failed to decode response from server."
//            self?.displayAlert(title: "Error loading page", message: message)
//            return
//      }
//      print("Created PaymentIntent")
//      self?.paymentIntentClientSecret = clientSecret
//    })
//    task.resume()
    
    

        
        
        
        let params : [String:Any] = [
            "amount":"100",
            "currency":"usd"
            ]
        
        
        service.getResponseFromServerByPostMethod(parametrs: params, url: "stripe_payment/generate_token.php?") { (results) in
            
            let clientSecret = results["clientSecret"] as? String ?? ""
            self.paymentIntentClientSecret = clientSecret
            
        }
    
    
    
  }

  @objc
  func pay() {
    guard let paymentIntentClientSecret = paymentIntentClientSecret else {
        return;
    }
    // Collect card details
    let cardParams = cardTextField.cardParams
    let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
    let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
    paymentIntentParams.paymentMethodParams = paymentMethodParams

    // Submit the payment
    let paymentHandler = STPPaymentHandler.shared()
    paymentHandler.confirmPayment(withParams: paymentIntentParams, authenticationContext: self) { (status, paymentIntent, error) in
      switch (status) {
      case .failed:
          self.displayAlert(title: "Payment failed", message: error?.localizedDescription ?? "")
          break
      case .canceled:
          self.displayAlert(title: "Payment canceled", message: error?.localizedDescription ?? "")
          break
      case .succeeded:
          self.displayAlert(title: "Payment succeeded", message: paymentIntent?.description ?? "")
          break
      @unknown default:
          fatalError()
          break
      }
    }
  }
}

extension CheckOutOneViewController: STPAuthenticationContext {
  func authenticationPresentingViewController() -> UIViewController {
      return self
  }
}
