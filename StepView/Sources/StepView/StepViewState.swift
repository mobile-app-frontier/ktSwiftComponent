//
//  StepViewState.swift
//  
//
//  Copyright (c) 2016 kt corp. All rights reserved.
//  This is a proprietary software of kt corp, and you may not use this file
//  except in compliance with license agreement with kt corp. Any redistribution
//  or use of this software, with or without modification shall be strictly
//  prohibited without prior written approval of kt corp, and the copyright
//  notice above does not evidence any actual or intended publication of such
//  software.
//

import Foundation


/// StepView 의 상태로
/// start : 시작상태
/// inprogress: 동작중인 상태
/// complete: 마지막 content 에서 다음 Content로 이동 요청시
/// exit : 처음 Content에서 이전 content로 이동 요청시
public enum StepViewState {
    case start
    case inprogress
    case complete
    case exit
}
