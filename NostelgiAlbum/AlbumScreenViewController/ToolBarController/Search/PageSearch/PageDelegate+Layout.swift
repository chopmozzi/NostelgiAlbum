import UIKit

// Layout
// CollectionView
extension PageSearchViewController {
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    func configureCollectionView() -> PageCollectionView {
        let layout = createLayout()
        let collectionView = PageCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = true
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: PageCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.canCancelContentTouches = true
        
        return collectionView
    }
}

// StackView
extension PageSearchViewController {
    func configureHierarcy() {
        stackView = UIStackView(frame: view.bounds)
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        //stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true


        collectionView = configureCollectionView()
        stackView.addArrangedSubview(collectionView)

        button = configureButton()
        stackView.addArrangedSubview(button)

        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// Button & Label
extension PageSearchViewController {
    func configureButton() -> PageButton {
        let button = PageButton()
        button.heightAnchor.constraint(equalToConstant: stackView.frame.size.height/1.3).isActive = true
        button.addTarget(self, action: #selector(bottomButtonTapped(_:)), for: .touchUpInside)
        firstPicture.translatesAutoresizingMaskIntoConstraints = false
        secondPicture.translatesAutoresizingMaskIntoConstraints = false
        firstPicture.numberOfLines = 0
        secondPicture.numberOfLines = 0
        firstPicture.textColor = UIColor.white
        secondPicture.textColor = UIColor.white
        firstPicture.layer.cornerRadius = 20
        secondPicture.layer.cornerRadius = 20
        firstPicture.clipsToBounds = true
        secondPicture.clipsToBounds = true
        firstPicture.isHidden = true
        secondPicture.isHidden = true
        button.addSubview(firstPicture)
        button.addSubview(secondPicture)
        NSLayoutConstraint.activate([
            firstPicture.topAnchor.constraint(equalTo: button.topAnchor, constant: 15),
            firstPicture.bottomAnchor.constraint(equalTo: secondPicture.topAnchor, constant: -20),
            firstPicture.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.45),
            firstPicture.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7),
            firstPicture.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            secondPicture.topAnchor.constraint(equalTo: firstPicture.bottomAnchor, constant: 1),
            secondPicture.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            secondPicture.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.45),
            secondPicture.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7),
            secondPicture.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        ])
        fpTitle.numberOfLines = 0
        fpContent.numberOfLines = 0
        fpTitle.translatesAutoresizingMaskIntoConstraints = false
        fpContent.translatesAutoresizingMaskIntoConstraints = false
        fpTitle.textColor = UIColor.black
        fpContent.textColor = UIColor.black
        fpTitle.clipsToBounds = true
        fpContent.clipsToBounds = true
        fpTitle.layer.cornerRadius = 7
        fpContent.layer.cornerRadius = 7
        fpTitle.textAlignment = .center
        fpContent.verticalAlignment = .top
        fpTitleText.numberOfLines = 1
        fpContentText.numberOfLines = 0
        fpTitleText.translatesAutoresizingMaskIntoConstraints = false
        fpContentText.translatesAutoresizingMaskIntoConstraints = false
        fpTitleText.text = "제목"
        fpContentText.text = "내용"
        firstPicture.addSubview(fpTitleText)
        firstPicture.addSubview(fpContentText)
        firstPicture.addSubview(fpTitle)
        firstPicture.addSubview(fpContent)
        NSLayoutConstraint.activate([
            fpTitle.leadingAnchor.constraint(equalTo: firstPicture.leadingAnchor, constant: CGFloat(20)),
            fpTitle.trailingAnchor.constraint(equalTo: firstPicture.trailingAnchor, constant: -CGFloat(20)),
            fpTitle.topAnchor.constraint(equalTo: fpTitleText.bottomAnchor, constant: CGFloat(10)),
            fpTitle.bottomAnchor.constraint(equalTo: fpContentText.topAnchor, constant: -CGFloat(20)),
            fpTitle.heightAnchor.constraint(equalTo: firstPicture.heightAnchor, multiplier: 0.15),
            
            fpContent.leadingAnchor.constraint(equalTo: firstPicture.leadingAnchor, constant: CGFloat(20)),
            fpContent.trailingAnchor.constraint(equalTo: firstPicture.trailingAnchor, constant: -CGFloat(20)),
            fpContent.topAnchor.constraint(equalTo: fpContentText.bottomAnchor, constant: CGFloat(5)),
            fpContent.bottomAnchor.constraint(equalTo: firstPicture.bottomAnchor, constant: -CGFloat(15)),

            fpTitleText.topAnchor.constraint(equalTo: firstPicture.topAnchor, constant: CGFloat(10)),
            fpTitleText.bottomAnchor.constraint(equalTo: fpTitle.topAnchor, constant: -CGFloat(5)),
            fpTitleText.heightAnchor.constraint(equalTo: firstPicture.heightAnchor, multiplier: 0.1),
            fpTitleText.centerXAnchor.constraint(equalTo: firstPicture.centerXAnchor),
            
            fpContentText.topAnchor.constraint(equalTo: fpTitle.bottomAnchor, constant: CGFloat(10)),
            fpContentText.bottomAnchor.constraint(equalTo: fpContent.topAnchor, constant: -CGFloat(5)),
            fpContentText.heightAnchor.constraint(equalTo: firstPicture.heightAnchor, multiplier: 0.1),
            fpContentText.centerXAnchor.constraint(equalTo: firstPicture.centerXAnchor)
        ])
        
        spTitle.numberOfLines = 0
        spContent.numberOfLines = 0
        spTitle.translatesAutoresizingMaskIntoConstraints = false
        spContent.translatesAutoresizingMaskIntoConstraints = false
        spTitle.textColor = UIColor.black
        spContent.textColor = UIColor.black
        spTitle.clipsToBounds = true
        spContent.clipsToBounds = true
        spTitle.layer.cornerRadius = 7
        spContent.layer.cornerRadius = 7
        spTitle.textAlignment = .center
        spContent.verticalAlignment = .top
        spTitleText.numberOfLines = 1
        spContentText.numberOfLines = 0
        spTitleText.translatesAutoresizingMaskIntoConstraints = false
        spContentText.translatesAutoresizingMaskIntoConstraints = false
        spTitleText.text = "제목"
        spContentText.text = "내용"

        secondPicture.addSubview(spTitle)
        secondPicture.addSubview(spContent)
        secondPicture.addSubview(spTitleText)
        secondPicture.addSubview(spContentText)
        NSLayoutConstraint.activate([
            spTitle.leadingAnchor.constraint(equalTo: secondPicture.leadingAnchor, constant: CGFloat(20)),
            spTitle.trailingAnchor.constraint(equalTo: secondPicture.trailingAnchor, constant: -CGFloat(20)),
            spTitle.topAnchor.constraint(equalTo: spTitleText.bottomAnchor, constant: CGFloat(10)),
            spTitle.bottomAnchor.constraint(equalTo: spContentText.topAnchor, constant: -CGFloat(20)),
            spTitle.heightAnchor.constraint(equalTo: secondPicture.heightAnchor, multiplier: 0.15),
            
            spContent.leadingAnchor.constraint(equalTo: secondPicture.leadingAnchor, constant: CGFloat(20)),
            spContent.trailingAnchor.constraint(equalTo: secondPicture.trailingAnchor, constant: -CGFloat(20)),
            spContent.topAnchor.constraint(equalTo: spContentText.bottomAnchor, constant: CGFloat(5)),
            spContent.bottomAnchor.constraint(equalTo: secondPicture.bottomAnchor, constant: -CGFloat(15)),

            spTitleText.topAnchor.constraint(equalTo: secondPicture.topAnchor, constant: CGFloat(10)),
            spTitleText.bottomAnchor.constraint(equalTo: spTitle.topAnchor, constant: -CGFloat(5)),
            spTitleText.heightAnchor.constraint(equalTo: secondPicture.heightAnchor, multiplier: 0.1),
            spTitleText.centerXAnchor.constraint(equalTo: secondPicture.centerXAnchor),
            
            spContentText.topAnchor.constraint(equalTo: spTitle.bottomAnchor, constant: CGFloat(10)),
            spContentText.bottomAnchor.constraint(equalTo: spContent.topAnchor, constant: -CGFloat(5)),
            spContentText.heightAnchor.constraint(equalTo: secondPicture.heightAnchor, multiplier: 0.1),
            spContentText.centerXAnchor.constraint(equalTo: secondPicture.centerXAnchor)
        ])
        return button
    }
}

//DataSource
extension PageSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (pageCount + 5)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reuseIdentifier, for: indexPath) as! PageCell
        cell.button.setTitle("\(indexPath.item - 1)", for: .normal)
        cell.button.titleLabel?.textColor = .white
        cell.button.pageNum = indexPath.item - 2
        cell.button.indexPath = indexPath
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.index = index
//        cell.button.layer.cornerRadius = collectionView.bounds.height/24.0
        cell.setFont()
        if indexPath.item < 2 || indexPath.item > pageCount + 2 {
            cell.button.isHidden = true
            cell.layer.isHidden = true
        } else {
            pageButtonList.append(cell.button)
        }
        let HomeSettingInfo = realm.objects(HomeSetting.self).first!
        
        if previousButton == cell.button.pageNum {
            if let ThemeColorSet = getColorSet(color: HomeSettingInfo.themeColor) {
                cell.button.backgroundColor = ThemeColorSet["subColor_4"]
            }
        }
        return cell
    }
}

// Delegate
extension PageSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size for each item at the specified index path
        return CGSize(width: collectionView.bounds.width/6.0, height: collectionView.bounds.width/6.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Return the section insets for the specified section
        return UIEdgeInsets(top: collectionView.bounds.height/1.5, left: 17, bottom: 35, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Return the minimum line spacing for the specified section
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Return the minimum interitem spacing for the specified section
        return 10
    }
}

// MARK: - PageDelegate
extension PageSearchViewController: PageDelegate{
    func scrollCenter() {
        let indexPath = IndexPath(item: currentPageNum + 2, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        loadPageInfo(btnPageNum: currentPageNum)
    }
}

// MARK: - CollectionViewDelegate
extension PageSearchViewController: UICollectionViewDelegate {
    // Check Scroll act
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        didScroll = false
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        initPageInfo()
    }
}
