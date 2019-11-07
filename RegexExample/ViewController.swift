//
//  ViewController.swift
//  RegexExample
//
//  Created by 박성원 on 01/11/2019.
//  Copyright © 2019 kakao. All rights reserved.
//

import UIKit

extension String {
    /*
     ^ : 문자의 시작
     [a-z0-9] : 소문자 숫자가 포함된 문자만 찾는다
     {4,15} : 텍스트가 4개 이상 15이하인 문자만 찾는다
     $ : 문자의 끝
     
     조건: 문자의 시작과 끝이 소문자와 숫자로 이루어져 있으며, 문자 길이가 4개 이상 15이하인 문자를 찾아라
     */
    func checkValidId() -> Bool {
        return self.range(of: "^[a-z0-9]{4,15}$", options: .regularExpression) != nil
    }

    func checkValidPassword() -> Bool {
        // 조건1: 숫자가 포함되어야하고
        if (self.range(of: "\\d", options: .regularExpression) == nil) {
            return false
        }
        
        // 조건2: 공백이 아닌 문자도 포함되어야 하며 \S: 공백이 아닌 모든 문자
        if (self.range(of: "\\S", options: .regularExpression) == nil) {
            return false
        }
        
        // 조건3: 특수문자도 포함되어야한다 \W : 낱말이 아닌 문자
        if (self.range(of: "\\W", options: .regularExpression) == nil) {
            return false
        }
        
        // 조건4: 패스워드 길이는 8자에서 20자 이하
        if (self.count <= 7 || self.count >= 21) {
            return false
        }

        /*
         . : 1개의 문자와 일치한다. 단일행 모드에서는 새줄 문자를 제외한다.
         * : 0개 이상의 문자를 포함한다. "a*b"는 "b", "ab", "aab", "aaab"를 포함한다.
         [a-zA-Z0-9] : 소문자, 대문자, 숫자가 포함된 문자만 찾는다
         ^\S : 공백이 아닌 모든 문자 (^가 앞에 붙으면 반대의 의미를 갖게 됨)
         (): 그룹화
         
         \1: 첫번째 그룹에서 일치한 결과값을 참조할 수 있게 하는 역참조
                아래 조건에 있는 .*([a-zA-Z0-9^\S])에서 'a'라는 캐릭터결과가 나왔을때 해당 값을 참고하여 \1 이벤트 발생시 a라는 조건이 또 나오면 만족시킴 'aa'
                \1\1로 하면 첫번째 조건에서 찾았던 'a'라는 결과가 2번더 나와야 조건 일치 'aaa'

         
           조건5: 같은 문자또는 숫자가 3번 이상 반복되면 안됨
        */
        if (self.range(of: ".*([a-zA-Z0-9^\\S])\\1\\1", options: .regularExpression) != nil) {
            return false
        }

        return true
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: Actions
    
    @IBAction func checkUserIdAction(_ sender: Any) {
        print(userIdTextField.text?.checkValidId() ?? false)
    }
    
    @IBAction func checkUserPasswordAction(_ sender: Any) {
        print(userPasswordTextField.text?.checkValidPassword() ?? false)
    }
    
}


