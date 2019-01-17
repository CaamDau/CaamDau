//Created  on 2018/12/13  by LCD :https://github.com/liucaide .





public extension UIFont {
    public static var cd_fontFitSize:CGFloat = 0
    func fit() -> UIFont {
        return self.withSize(self.pointSize+UIFont.cd_fontFitSize)
    }
}
