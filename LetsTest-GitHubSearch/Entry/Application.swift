//
//  Application.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

import UIKit

@main
final class Application {
    static func main() {
        let appDelegateClass: AnyClass = NSClassFromString("LetsTest_GitHubSearchTests.AppDelegateStub") ?? AppDelegate.self
        let appDelegateClassName = NSStringFromClass(appDelegateClass)

        UIApplicationMain(
            CommandLine.argc,
            CommandLine.unsafeArgv,
            nil,
            appDelegateClassName
        )
    }
}
