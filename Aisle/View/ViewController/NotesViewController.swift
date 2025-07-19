//
//  NotesViewController.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: - Bottom Tabs
    let discoverTab = TabBarItemView(image: UIImage(systemName: "square.grid.2x2")!, title: "Discover")
    let notesTab = TabBarItemView(image: UIImage(systemName: "envelope.fill")!, title: "Notes", badgeCount: "9")
    let matchesTab = TabBarItemView(image: UIImage(systemName: "bubble.left.and.bubble.right.fill")!, title: "Matches", badgeCount: "50+")
    let profileTab = TabBarItemView(image: UIImage(systemName: "person.fill")!, title: "Profile")

    // MARK: - Views
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    // MARK: - Data
    private var viewModel = AuthViewModel()
    private var invites: [InviteProfile] = []
    private var likes: [LikeProfile] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBottomTabBar()
        setupScrollView()
        setupStackView()
        fetchAndRenderNotes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }

    // MARK: - ScrollView Setup
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)

        // Pin scrollView to safe area, leaving space for tab bar
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70)
        ])
    }

    // MARK: - StackView Setup
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        // Layout inside scrollView with padding
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }

    // MARK: - API + Rendering
    func fetchAndRenderNotes() {
        // On success, update invites and likes, and render the UI
        viewModel.onNotesFetchSuccess = { [weak self] invites, likes in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.invites = invites
                self.likes = likes
                self.renderUI()
            }
        }

        // On error, show alert
        viewModel.onError = { [weak self] error in
            self?.showAlert(message: error)
        }

        viewModel.getNotesData()
    }

    func renderUI() {
        // Clear previous views
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add header
        let headerView = NotesHeaderView()
        stackView.addArrangedSubview(headerView)

        // Add main invite card (if exists)
        if let firstInvite = invites.first {
            let mainCard = MainNoteCardView()
            mainCard.translatesAutoresizingMaskIntoConstraints = false
            mainCard.configure(with: firstInvite)
            stackView.addArrangedSubview(mainCard)

            NSLayoutConstraint.activate([
                mainCard.heightAnchor.constraint(equalToConstant: 280)
            ])
        }

        // Add "Interested in You" view
        let interestedView = InterestedInYouView()
        interestedView.setContentHuggingPriority(.required, for: .vertical)
        interestedView.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.addArrangedSubview(interestedView)

        // Add likes carousel
        let likesCarousel = LikesCarouselView()
        likesCarousel.profiles = likes
        likesCarousel.translatesAutoresizingMaskIntoConstraints = false
        likesCarousel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.addArrangedSubview(likesCarousel)
    }

    // MARK: - Error Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - TabBar
extension NotesViewController {
    func setupBottomTabBar() {
        let tabStack = UIStackView(arrangedSubviews: [discoverTab, notesTab, matchesTab, profileTab])
        tabStack.axis = .horizontal
        tabStack.distribution = .fillEqually
        tabStack.translatesAutoresizingMaskIntoConstraints = false

        let tabBarContainer = UIView()
        tabBarContainer.backgroundColor = .white
        tabBarContainer.translatesAutoresizingMaskIntoConstraints = false
        tabBarContainer.layer.shadowColor = UIColor.black.cgColor
        tabBarContainer.layer.shadowOpacity = 0.2
        tabBarContainer.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBarContainer.layer.shadowRadius = 6
        tabBarContainer.layer.masksToBounds = false

        view.addSubview(tabBarContainer)
        tabBarContainer.addSubview(tabStack)

        // Pin tab bar to bottom
        NSLayoutConstraint.activate([
            tabBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarContainer.heightAnchor.constraint(equalToConstant: 70),

            tabStack.topAnchor.constraint(equalTo: tabBarContainer.topAnchor),
            tabStack.leadingAnchor.constraint(equalTo: tabBarContainer.leadingAnchor),
            tabStack.trailingAnchor.constraint(equalTo: tabBarContainer.trailingAnchor),
            tabStack.bottomAnchor.constraint(equalTo: tabBarContainer.bottomAnchor)
        ])

        // Add tap gestures for each tab
        [discoverTab, notesTab, matchesTab, profileTab].enumerated().forEach { index, tab in
            tab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
            tap.name = "\(index)"
            tab.addGestureRecognizer(tap)
        }

        // Highlight Notes tab
        notesTab.setSelected(true)
    }

    // Handle tab selection
    @objc func tabTapped(_ gesture: UITapGestureRecognizer) {
        guard let name = gesture.name, let index = Int(name) else { return }
        let tabs = [discoverTab, notesTab, matchesTab, profileTab]
        tabs.enumerated().forEach { i, tab in
            tab.setSelected(i == index)
        }
    }
}
