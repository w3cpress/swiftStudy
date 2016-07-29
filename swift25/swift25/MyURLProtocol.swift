import UIKit
import CoreData

//记录请求数量
var requestCount = 0

class MyURLProtocol: NSURLProtocol , NSURLSessionDataDelegate, NSURLSessionTaskDelegate{
    
    //NSURLSession数据请求任务
    var dataTask:NSURLSessionDataTask?
    //url请求响应
    var urlResponse: NSURLResponse?
    //url请求获取到的数据
    var receivedData: NSMutableData?
    
    
    //判断这个 protocol 是否可以处理传入的 request
    override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        //对于已处理过的请求则跳过，避免无限循环标签问题
        if NSURLProtocol.propertyForKey("MyURLProtocolHandledKey", inRequest: request) != nil {
            return false
        }
        return true
    }
    
    //回规范化的请求（通常只要返回原来的请求就可以）
    override class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
        return request
    }
    
    //判断两个请求是否为同一个请求，如果为同一个请求那么就会使用缓存数据。
    //通常都是调用父类的该方法。我们也不许要特殊处理。
    override class func requestIsCacheEquivalent(aRequest: NSURLRequest, toRequest bRequest: NSURLRequest) -> Bool {
        return super.requestIsCacheEquivalent(aRequest, toRequest:bRequest)
    }
    
    //开始处理这个请求
    override func startLoading() {
        requestCount+=1
        print("Request请求\(requestCount): \(request.URL!.absoluteString)")
        //判断是否有本地缓存
        let possibleCachedResponse = self.cachedResponseForCurrentRequest()
        if let cachedResponse = possibleCachedResponse {
            print("----- 从缓存中获取响应内容 -----")
            
            //从本地缓中读取数据
            let data = cachedResponse.valueForKey("data") as! NSData!
            let mimeType = cachedResponse.valueForKey("mimeType") as! String!
            let encoding = cachedResponse.valueForKey("encoding") as! String!
            
            //创建一个NSURLResponse 对象用来存储数据。
            let response = NSURLResponse(URL: self.request.URL!, MIMEType: mimeType, expectedContentLength: data.length, textEncodingName: encoding)
            
            //将数据返回到客户端。然后调用URLProtocolDidFinishLoading方法来结束加载。
            //（设置客户端的缓存存储策略.NotAllowed ，即让客户端做任何缓存的相关工作）
            self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
            self.client!.URLProtocol(self, didLoadData: data)
            self.client!.URLProtocolDidFinishLoading(self)
        } else {
            //请求网络数据
            print("===== 从网络获取响应内容 =====")
            
            let newRequest = self.request.mutableCopy() as! NSMutableURLRequest
            //NSURLProtocol接口的setProperty()方法可以给URL请求添加自定义属性。
            //（这样把处理过的请求做个标记，下一次就不再处理了，避免无限循环请求）
            NSURLProtocol.setProperty(true, forKey: "MyURLProtocolHandledKey", inRequest: newRequest)
            
            //使用NSURLSession从网络获取数据
            let defaultConfigObj = NSURLSessionConfiguration.defaultSessionConfiguration()
            let defaultSession = NSURLSession(configuration: defaultConfigObj, delegate: self, delegateQueue: nil)
            self.dataTask = defaultSession.dataTaskWithRequest(newRequest)
            self.dataTask!.resume()
        }
    }
    
    //结束处理这个请求
    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask       = nil
        self.receivedData   = nil
        self.urlResponse    = nil
    }
    
    //NSURLSessionDataDelegate相关的代理方法
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        
        self.client?.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
        self.urlResponse = response
        self.receivedData = NSMutableData()
        completionHandler(.Allow)
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.client?.URLProtocol(self, didLoadData: data)
        self.receivedData?.appendData(data)
    }
    
    //NSURLSessionTaskDelegate相关的代理方法
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil && error!.code != NSURLErrorCancelled {
            self.client?.URLProtocol(self, didFailWithError: error!)
        } else {
            //保存获取到的请求响应数据
            saveCachedResponse()
            self.client?.URLProtocolDidFinishLoading(self)
        }
    }
    
    //保存获取到的请求响应数据
    func saveCachedResponse () {
        print("+++++ 将获取到的数据缓存起来 +++++")
        
        //获得Core Data的NSManagedObjectContext
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        //创建NSManagedObject的实例，来匹配在.xcdatamodeld 文件中所对应的数据模型。
        let cachedResponse = NSEntityDescription
            .insertNewObjectForEntityForName("CachedURLResponse", inManagedObjectContext: context) as NSManagedObject
        cachedResponse.setValue(self.receivedData, forKey: "data")
        cachedResponse.setValue(self.request.URL!.absoluteString, forKey: "url")
        cachedResponse.setValue(NSDate(), forKey: "timestamp")
        cachedResponse.setValue(self.urlResponse?.MIMEType, forKey: "mimeType")
        cachedResponse.setValue(self.urlResponse?.textEncodingName, forKey: "encoding")
        
        //保存（Core Data数据要放在主线程中保存，要不并发是容易崩溃）
        dispatch_async(dispatch_get_main_queue(), {
            do {
                try context.save()
            } catch {
                print("不能保存：\(error)")
            }
        })
    }
    
    //检索缓存请求
    func cachedResponseForCurrentRequest() -> NSManagedObject? {
        //获得managedObjectContext
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        //创建一个NSFetchRequest，通过它得到对象模型实体：CachedURLResponse
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("CachedURLResponse", inManagedObjectContext: context)
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate(format:"url == %@", self.request.URL!.absoluteString)
        fetchRequest.predicate = predicate
        
        //执行获取到的请求
        do {
            let possibleResult = try context.executeFetchRequest(fetchRequest)
                as? Array<NSManagedObject>
            if let result = possibleResult {
                if !result.isEmpty {
                    return result[0]
                }
            }
        }
        catch {
            print("获取缓存数据失败：\(error)")
        }
        return nil
    }
}