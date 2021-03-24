//
//  SearchController.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-08.
//

import UIKit

private let reuseIdentifier = "UserCell"
private let cellIdentifer = "ProfileCell"

class SearchController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private var users = [User]()
    private var filteredUsers = [User]()
    private var posts = [Post]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var inSearchMode: Bool{
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private lazy var colletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifer)
        cv.backgroundColor = .white
        return cv
    }()
    
    // MARKL: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureUI()
        fetchUsers()
    }
    
    // MARK: - API
    func fetchUsers(){
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.isHidden = true
        
        view.addSubview(colletionView)
        colletionView.fillSuperview()
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: - UITableViewDataSource

extension SearchController: UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchController: UITableViewDelegate{
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        colletionView.isHidden = true
        tableView.isHidden = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
        colletionView.isHidden = false
        tableView.isHidden = true
    }
}


// MARK: - UISearchResultsUpdating
extension SearchController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({$0.username.lowercased().contains(searchText) || $0.fullname.lowercased().contains(searchText)})
        
        self.tableView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension SearchController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath) as! ProfileCell
//        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension SearchController: UICollectionViewDelegate{
    
}

extension SearchController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 240)
//    }
}
