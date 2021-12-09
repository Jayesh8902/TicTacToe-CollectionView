

import UIKit

class Tictactoe: UIViewController {

    
    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private let winingcombination = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],[0,5,10,15],[3,6,9,12]]
    
        private var zeroflag = false
    
    private let mycollectionview : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let collectionview = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionview.backgroundColor = UIColor.clear
        return collectionview
    }()
    
    private let lblres : UITextView =
    {
            let lbl = UITextView()
            lbl.text = ""
            return lbl
    }()
    private let p1:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.borderWidth = 5
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.cornerRadius = 100
        img.clipsToBounds = true
        img.image = UIImage(named: "p1");
        return img
    }()
    private let p2:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.borderColor = UIColor.red.cgColor
        img.layer.cornerRadius = 100
        img.clipsToBounds = true
        img.image = UIImage(named: "p2");
        return img
    }()
    public let btnretsrat:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("RESTART", for: .normal)
        btn1.backgroundColor = .red
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(res), for: .touchUpInside)
        return btn1
        
    }()
    @objc public func res()
    {
        print("restart")
        restart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tiktak.jpg")!)
        view.addSubview(btnretsrat)
        view.addSubview(mycollectionview)
        view.addSubview(lblres)
//        view.addSubview(p1)
//        view.addSubview(p2)
        
        setupcollectionview()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mycollectionview.frame = view.bounds
         lblres.frame = CGRect(x: 20, y: 450, width: 330, height: 50)
        btnretsrat.frame = CGRect(x: 20, y: 520, width: 200, height: 30)
//        p2.frame = CGRect(x: 190, y: 450, width: 120, height: 120)
    }
   

}
extension Tictactoe : UICollectionViewDataSource,UICollectionViewDelegate
{
    private func setupcollectionview()
    {
        mycollectionview.dataSource = self
        mycollectionview.delegate = self
        mycollectionview.register(CollectionCell.self, forCellWithReuseIdentifier: "collectioncell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! CollectionCell
        cell.setupcell(with: state[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1
        {
            state.remove(at: indexPath.row)
            if zeroflag
            {
                state.insert(0, at: indexPath.row)
            }
            else
            {
                state.insert(1, at: indexPath.row)
            }
            zeroflag = !zeroflag
            DispatchQueue.main.async {
                collectionView.reloadSections(IndexSet(integer: 0))
            }
            checkwinner()
            
        }
    }
    private func checkwinner()
    {
        if !state.contains(2)
        {
            print("Draw")
            restart()
        }
        else
        {
            for i in winingcombination{
                if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ] && state[ i[2] ] == state[ i[3] ] && state[ i[0] ] != 2 {
                    print("\(state[ i[0] ])Won")
                    if(state[i[0]]==0)
                    {
                        lblres.text="Player O Won"
                    }
                    else
                    {
                        lblres.text="Player X Won"
                    }
                    break
                }
            }
            
        }
        
        
    }
    
    private func  restart()
    {
        print("re");
        state = [2,2,2,2,
          2,2,2,2,
          2,2,2,2,
          2,2,2,2]
        zeroflag = false
        mycollectionview.reloadData()
    }
    
}
