//Created  on 2019/3/4 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation

//MARK:--- 计时模型 ----------
/// 计时模型 应用类型以保持前后变更一致
public class M_CDTime {
    var year:Int = 0
    var month:Int = 0
    var day:Int = 0
    var hour:Int = 0
    var minute:Int = 0
    var second:Int = 0
    var millisecond:Int = 0
    
    enum Style {
        case remainTime(_ time:TimeInterval)
        case timestamp(_ now:TimeInterval, _ end:TimeInterval)
    }
    var style:Style?
    
    private init(){}
    init(style:Style) {
        self.style = style
    }
    
    
    var remainTime:Int = 0
    var nowTime:TimeInterval = 0
    var endTime:TimeInterval = 0
}


public class CD_CountDown {
    enum Style {
        case delegate
        case notification(_ name:String)
        case block(_ b:((M_CDTime)->Void))
    }
    
    private init(){}
    public static let shared:CD_CountDown = CD_CountDown()
    ///时间倒计时标识存储，预防重复创建同一计时线程
    var tags:[String] = []
}

public extension CD_CountDown {
    //MARK:--- 时间倒计时 ----------
    ///时间倒计时
    static func addCountDown(_ model:M_CDTime, nowTimestamp:TimeInterval, endTimestamp:TimeInterval, second:Double = 0.1) {
        //以model 地址为标识，不必重复创建
        let tag = String(format: "%p", model as! CVarArg)
        if CD_CountDown.shared.tags.contains(tag) {return}
        CD_CountDown.shared.tags.append(tag)
        
        
        //结束时间
        let endDate:Date = Date(timeIntervalSince1970: model.endTime)
        //当前时间
        let nowDate:Date = Date(timeIntervalSince1970: model.nowTime)
        
        //当前时间与系统时间差
        let nowDateDiffer:TimeInterval = nowDate.timeIntervalSinceNow
        
        
        //时间间隔 ^ 毫秒
        var aTime:TimeInterval = endDate.timeIntervalSince(Date()) * 10
        var bTime:Int = 999
        
        var saveSecond:Int  = 59
        
        // 创建一个时间源
        let queue = DispatchQueue(label: tag)
        let timer = DispatchSource.makeTimerSource(queue:queue)
        
        //循环执行，马上开始，间隔为 ms
        timer.schedule(deadline: .now(), repeating: .milliseconds(Int(second*1000)), leeway: .milliseconds(10))
        
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            //计算剩余时间
            let gregorian = Calendar(identifier: .gregorian)
            let cmps = gregorian.dateComponents(
                [.year,
                 .month,
                 .day,
                 .hour,
                 .minute,
                 .second],
                from: Date(timeIntervalSince1970:Date().timeIntervalSince1970 + nowDateDiffer),
                to: endDate)
            
            aTime = endDate.timeIntervalSince(Date(timeIntervalSince1970: Date().timeIntervalSince1970 + nowDateDiffer)) * 10
            
            bTime = saveSecond != cmps.second ? 999 : (bTime <= 0 ? 999 : bTime - Int(second*1000))
            
            saveSecond = cmps.second ?? 59
            
            if aTime <= 0 {
                timer.cancel()
                DispatchQueue.main.async(execute: { [weak model] in
                    //print("通知\(aTime)毫秒")
                    model?.year = 0
                    model?.month = 0
                    model?.day = 0
                    model?.hour = 0
                    model?.minute = 0
                    model?.second = 0
                    model?.millisecond = 0
                    CD_CountDown.shared.tags.removeAll{$0 == tag}
                })
            } else {
                DispatchQueue.main.async(execute: {[weak model] in
                    model?.year = cmps.year ?? 0
                    model?.month = cmps.month ?? 0
                    model?.day = cmps.day ?? 0
                    model?.hour = cmps.hour ?? 0
                    model?.minute = cmps.minute ?? 0
                    model?.second = cmps.second ?? 0
                    model?.millisecond = bTime*10+Int(aTime)
                })
                
            }
        })
        // 启动时间源
        timer.resume()
    }
}

public extension CD_CountDown {
    //MARK:--- 验证码、秒表倒计时 ----------
    ///验证码秒表倒计时
    static func addVerifyCode(_ model:M_CDTime, maxTime: Int = 60) {
        //以model 地址为标识，不必重复创建
        let tag = String(format: "%p", model as! CVarArg)
        if CD_CountDown.shared.tags.contains(tag) {return}
        CD_CountDown.shared.tags.append(tag)
        
        let toTime = Date().timeIntervalSince1970 + TimeInterval(maxTime)
        var aTime = maxTime
        let queue = DispatchQueue(label: tag)
        // 创建一个时间源
        let timer = DispatchSource.makeTimerSource(queue:queue)
        
        //循环执行，马上开始，间隔为1s, 误差允许10微秒
        timer.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(10))
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            aTime = Int(toTime - Date().timeIntervalSince1970)
            if aTime <= 0 {
                //timer.suspend()
                timer.cancel()
                DispatchQueue.main.async { [weak model] in
                    //print("通知\(aTime)毫秒")
                    model?.year = 0
                    model?.month = 0
                    model?.day = 0
                    model?.hour = 0
                    model?.minute = 0
                    model?.second = 0
                    model?.millisecond = 0
                    CD_CountDown.shared.tags.removeAll{$0 == tag}
                }
            }else{
                DispatchQueue.main.async {[weak model] in
                    model?.second = aTime
                }
            }
        })
        // 启动时间源
        timer.resume()
    }
}


//MARK:--- 延时执行 ----------
public extension CD_CountDown {
    static func after(_ time:Double, _ block:@escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: block)
        /*
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            
        }*/
    }
}
