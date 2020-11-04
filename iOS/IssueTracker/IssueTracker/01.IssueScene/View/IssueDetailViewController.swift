//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController, UICollectionViewDelegate {
    static let identifier = "IssueDetailViewController"
    private var cellData = [
        "레이블 전체 목록을 볼 수 있는게 어떨까요 전체 설명이 보여야 선택할 수 있으니까 마크다운 문법을 지원하고 HTML 형태로 보여줘야 할까요",
        "긍정적인 기능이네요 댓글은 한 줄",
        "아 힘드렁",
        "Where does it come from? Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    let addCommentViewController = AddCommentViewController()
    private var currentIndexPath: IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let currentIndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return nil }
        return currentIndexPath
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        configureBackButton()
        configureCollectionView()
        addBottomSheetView()
    }
    
    private func configureBackButton() {
        self.navigationItem.hidesBackButton = true
        let customButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(self.backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = customButton
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: IssueDetailHeaderView.identifier, bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IssueDetailHeaderView.identifier)
        collectionView.register(type: IssueDetailCellView.self)
    }
    
    private func addBottomSheetView() {
        addCommentViewController.upButtonTapped = { [weak self] in
            guard let `self` = self,
                let currentIndexPath = self.currentIndexPath,
                currentIndexPath.item > 0
                else { return }
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndexPath.item - 1, section: 0), at: .centeredVertically, animated: true)
        }
        
        addCommentViewController.downButtonTapped = { [weak self] in
            guard let `self` = self,
                let currentIndexPath = self.currentIndexPath,
                currentIndexPath.item < self.cellData.count - 1
                else { return }
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndexPath.item + 1, section: 0), at: .centeredVertically, animated: true)
        }
        
        self.view.addSubview(addCommentViewController.view)
        let height = view.frame.height
        let width  = view.frame.width
        addCommentViewController.view.frame = CGRect(x: 0, y: self.view.frame.maxY * 0.85, width: width, height: height)
    }
    
    private func setupCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        let width = self.view.frame.width
        let headerHeight = self.view.frame.height * 0.2
        
        flowLayout.estimatedItemSize = CGSize(width: width, height: headerHeight)
        flowLayout.headerReferenceSize = CGSize(width: width, height: headerHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = flowLayout
    }
}
// MARK: - UICollectionViewDataSource implementation

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: IssueDetailCellView = collectionView.dequeueCell(at: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: cellData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IssueDetailHeaderView.identifier, for: indexPath) as? IssueDetailHeaderView else { return UICollectionReusableView() }
        
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
