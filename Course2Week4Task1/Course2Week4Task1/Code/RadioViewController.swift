

import UIKit

import AVFoundation

class RadioViewController: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = .black
        label.text = "Aerosmith - Hole In My Soul"
        return label
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        
        slider.frame = CGRect(x: 0, y: 0, width: 200, height: 31)
        return slider
        
    }()
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.setProgress(0.5, animated: false)
        return progress
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "pic.jpeg")
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // Constraints
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var changedConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(slider)
        self.view.addSubview(imageView)
        self.view.addSubview(progressView)
        
        NSLayoutConstraint.activate(compactConstraints)
        
        changedConstraints.append(contentsOf: [
            nameLabel.centerYAnchor.constraint(equalTo: progressView.bottomAnchor, constant: yPositionForLabel())
        ])
        
        NSLayoutConstraint.activate(changedConstraints)
        self.view.layoutIfNeeded()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints + compactConstraints + changedConstraints)
            }
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.deactivate(changedConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            self.view.layoutIfNeeded()
            
            changedConstraints.removeAll()
            
            changedConstraints.append(contentsOf: [
                nameLabel.centerYAnchor.constraint(equalTo: progressView.bottomAnchor, constant: yPositionForLabel())
            ])
            
            NSLayoutConstraint.activate(changedConstraints)

        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints + regularConstraints + changedConstraints)
            }
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.deactivate(changedConstraints)
            
            NSLayoutConstraint.activate(regularConstraints)
            self.view.layoutIfNeeded()
            
            changedConstraints.removeAll()
            
            changedConstraints.append(contentsOf: [
                
                nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Offset.leading),
                
                nameLabel.centerYAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 124)
                
            ])
            
            NSLayoutConstraint.activate(changedConstraints)
        }
    }
}


extension RadioViewController {
    struct Offset {
        static let leading: CGFloat = 16.0
        static let trailing: CGFloat = -16.0
        static let top: CGFloat = 8.0
        static let bottom: CGFloat = -24.0
    }
}

extension RadioViewController {
    func yPositionForLabel () -> (CGFloat){
        self.view.layoutIfNeeded()
        
        let pointProgress = progressView.convert(CGPoint(x: progressView.bounds.maxX, y: progressView.bounds.maxY), to: self.view)
        let pointSlider = slider.convert(CGPoint(x: slider.bounds.maxX, y: slider.bounds.minY), to: self.view)
        print(pointProgress)
        print(pointSlider)
        return (pointSlider.y - pointProgress.y) / 2
    }
}

extension RadioViewController {
    func setConstraints() {
        compactConstraints.append(contentsOf: [
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Offset.leading),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Offset.trailing),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Offset.top),
            
            slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Offset.bottom),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Offset.leading),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Offset.trailing),
            
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Offset.leading),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Offset.trailing),
            progressView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Offset.trailing),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Offset.leading)
        ])
        regularConstraints.append(contentsOf: [
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Offset.leading),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Offset.trailing),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Offset.leading),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Offset.trailing),

            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
           

            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -71),
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
 
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Offset.trailing)
            
        ])
    }
}


