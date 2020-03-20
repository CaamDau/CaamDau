//Created  on 2020/3/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * PencilKit image drawing
 * PencilKit 的图片编辑器
 * 注意：AppDelegate 不要对 window 重新初始化，否则 PKToolPicker 工具板不显示
 */

import UIKit
import PencilKit

@available(iOS 13.0, *)
@objc public class CD_PencilDraw: NSObject {
    @objc public class func show(_ image:UIImage, drawing:PKDrawing = PKDrawing(), margin:CGFloat = 0, minZoomScale:CGFloat = 0.2, maxZoomScale:CGFloat = 4, callback:((PKDrawing, UIImage)->Void)? = nil) {
        let vc = VC_PencilDraw()
        vc.margin = margin
        vc.zoomScale = (minZoomScale, maxZoomScale)
        vc.image = image
        vc.drawing = drawing
        vc.callback = callback
        guard let nvc = CD.visibleVC?.navigationController else {
            let nvc = UINavigationController(rootViewController: vc)
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: vc, action: #selector(vc.backAction(_:)))
            nvc.modalTransitionStyle = .crossDissolve
            nvc.modalPresentationStyle = .fullScreen
            CD.present(nvc, animated: true)
            return
        }
        vc.hidesBottomBarWhenPushed = true
        nvc.pushViewController(vc, animated: true)
    }
}

@available(iOS 13.0, *)
fileprivate class VC_PencilDraw: UIViewController {
    var margin:CGFloat = 0
    var zoomScale:(CGFloat, CGFloat) = (0.2, 4)
    var callback:((PKDrawing, UIImage)->Void)?
    var image:UIImage!
    var drawing:PKDrawing = PKDrawing()
    lazy var canvasView: PKCanvasView = {
        let pk = PKCanvasView()
        pk.isOpaque = false
        pk.delegate = self
        pk.alwaysBounceVertical = false
        pk.allowsFingerDrawing = false
        pk.bounces = true
        pk.drawing = drawing
        pk.showsVerticalScrollIndicator = false
        pk.showsHorizontalScrollIndicator = false
        pk.minimumZoomScale = zoomScale.0
        pk.maximumZoomScale = zoomScale.1
        pk.setZoomScale(1, animated: false)
        return pk
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var editItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction(_:)))
    }()
    
    lazy var cancelItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(_:)))
    }()
    
    lazy var doneItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction(_:)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(canvasView)
        canvasView.insertSubview(imageView, at: 0)
        canvasView.contentSize = imageView.frame.size
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
        navigationItem.rightBarButtonItems = [doneItem, editItem]
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            canvasView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            canvasView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        updateLayer(self.view.bounds.size)
        
        if let window = parent?.view.window, let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            toolPicker.addObserver(self)
            canvasView.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateLayer(size)
    }
    
    func updateLayer(_ size:CGSize) {
        var left:CGFloat = margin
        var top:CGFloat = margin
        if imageView.bounds.width < size.width-2*margin {
            left = (size.width - 2*margin - imageView.bounds.width)/2
        }
        if imageView.bounds.height < size.height-2*margin {
            top = (size.height - 2*margin - imageView.bounds.height)/2
        }
        canvasView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
    }
}

@available(iOS 13.0, *)
extension VC_PencilDraw: PKToolPickerObserver {
    func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
    }
    
    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
    }
}

//MARK:--- Action ----------
@available(iOS 13.0, *)
extension VC_PencilDraw {
    @objc func backAction(_ sender:Any) {
        CD.dismiss()
    }
    
    @objc func editAction(_ sender:Any) {
        canvasView.allowsFingerDrawing.toggle()
        navigationItem.rightBarButtonItems = [doneItem, cancelItem]
    }
    
    @objc func cancelAction(_ sender:Any) {
        canvasView.allowsFingerDrawing.toggle()
        navigationItem.rightBarButtonItems = [doneItem, editItem]
    }
    
    @objc func doneAction(_ sender:Any) {
        canvasView.setZoomScale(1, animated: false)
        let img = jointImage(image, canvasView.drawing.image(from: imageView.frame, scale: 1))
        callback?(canvasView.drawing, img)
        guard let _ = navigationController?.popViewController(animated: true) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
}

@available(iOS 13.0, *)
extension VC_PencilDraw: PKCanvasViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width*scrollView.zoomScale, height: image.size.height*scrollView.zoomScale)
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width*scale, height: image.size.height*scale)
        scrollView.setZoomScale(scale, animated: false)
        updateLayer(self.view.bounds.size)
    }
}


@available(iOS 13.0, *)
extension VC_PencilDraw {
    func jointImage(_ image1:UIImage, _ image2:UIImage) -> UIImage {
        UIGraphicsBeginImageContext(image2.size)
        image1.draw(in: CGRect(x: 0, y: 0, width: image1.size.width, height: image1.size.height))
        image2.draw(in: CGRect(x: 0, y: 0, width: image2.size.width, height: image2.size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? image1
    }
}
