import UIKit
import CoreML

class UpdateViewController: UIViewController {
    
    // UI Outlets
    @IBOutlet weak var SampleType: UITextField!
    @IBOutlet weak var Age: UITextField!
    @IBOutlet weak var Pielou: UITextField!
    @IBOutlet weak var Shannon: UITextField!
    @IBOutlet weak var Faith: UITextField!
    @IBOutlet weak var Observed: UITextField!
    @IBAction func signOut(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    @IBAction func segmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "dashboard")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: false)
        } else if sender.selectedSegmentIndex == 1{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "update")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: false)
        } else if sender.selectedSegmentIndex == 2{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "result")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: false)
        }
    }
    let model = Endo1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Action triggered when the button is pressed
    @IBAction func predictButtonPressed(_ sender: UIButton) {
        
        do {
            // Safely unwrap the text fields and cast to the correct types
            guard let pielou = Double(Pielou.text ?? ""),
                  let faith = Double(Faith.text ?? ""),
                  let shannon = Double(Shannon.text ?? ""),
                  let observed = Int64(Observed.text ?? ""),
                  let age = Int64(Age.text ?? "") else {
                print("Error: Invalid input values.")
                return
            }
            
            
            let tissue = SampleType.text ?? "Endometrial Biopsy"
            
            let predictionInput = Endo1Input(
                pielou_evenness:  0.719347,
                observed_features: 991,
                faith_pd: 158.25,
                shannon_entropy: 7.15947,
                age: 33,
                tissue: "endometrial fluid"
            )
            let complicationInput = Endo2Input(
                pielou_evenness:  0.719347,
                observed_features: 991,
                faith_pd: 158.25,
                shannon_entropy: 7.15947,
                age: 33
            )
            let model = try Endo1()
            let model2 = try Endo2()
            let predictionOutput = try model.prediction(input: predictionInput)
            let complication = try model2.prediction(input: complicationInput)
            print("Prediction Result: \(predictionOutput.outcome)")
            print("Prediction Probability: \(predictionOutput.outcomeProbability)")
            print("Complication Result: \(complication.outcome)")
            print("Complication Probability: \(complication.outcomeProbability)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let resultVC = storyboard.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                        resultVC.predictionResult = predictionOutput.outcome
                        
                        resultVC.predictionProbability = "\(predictionOutput.outcomeProbability)"
                        resultVC.complicationResult = complication.outcome
                        resultVC.complicationProbability = "\(complication.outcomeProbability)"

                        resultVC.modalPresentationStyle = .overFullScreen
                        present(resultVC, animated: true)
                    }
            
        } catch {
                       print("Error creating prediction input: \(error)")
                   }

            
        }
        
    }

