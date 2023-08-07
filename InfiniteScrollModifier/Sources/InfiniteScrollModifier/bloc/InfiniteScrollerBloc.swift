//
//  InfiniteScrollerBloc.swift
//  
//
//  Created by kimrlyunah on 2023/04/18.
//
//
import Foundation

@MainActor
class InfiniteScrollerBloc : ObservableObject {
    @Published var status: ScrollStatus
    
    init() {
        self.status = ScrollStatus.idle
    }
    
    var isLoading: Bool {
        get {
            return self.status ==  ScrollStatus.onGoing || self.status == ScrollStatus.refreshing
        }
    }
    
    var canRefresh: Bool {
        get {
            return !isLoading
        }
    }
    
    var isRefreshing: Bool {
        get {
            return self.status == ScrollStatus.refreshing
        }
    }
    
    var isOnGoing: Bool {
        get {
            return self.status == ScrollStatus.onGoing
        }
    }
    
    func setIdle() {
        status = ScrollStatus.idle
    }
    
    func setRefresh() {
        status = ScrollStatus.refreshing
    }
    
    func setOnGoing() {
        status = ScrollStatus.onGoing
    }
}
