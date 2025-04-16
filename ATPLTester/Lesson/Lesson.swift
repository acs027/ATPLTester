//
//  Lesson.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import Foundation

enum Lesson: Int, CaseIterable {
    case airLaw = 10
    case agk = 21
    case instrument = 22
    case mass = 31
    case performance = 32
    case flightPlan = 33
    case humanPerformance = 40
    case meteorology = 50
    case genNav = 61
    case insNav = 62
    case operational = 70
    case flightPrinciples = 81
    case vfr = 91
    case ifr = 92
    
    var name: String {
        switch self {
        case .airLaw:
            return "Air Law"
        case .agk:
            return "Aircraft General Knowledge"
        case .instrument:
            return "Instrumentation"
        case .mass:
            return "Mass and Balance"
        case .performance:
            return "Performance"
        case .flightPlan:
            return "Flight Planning and Monitoring"
        case .humanPerformance:
            return "Human Performance and Limitations"
        case .meteorology:
            return "Meteorology"
        case .genNav:
            return "General Navigation"
        case .insNav:
            return "Radio Navigation"
        case .operational:
            return "Operational Procedures"
        case .flightPrinciples:
            return "Principles of Flight"
        case .vfr:
            return "Visual Flight Rules (VFR) Communications"
        case .ifr:
            return "Instrument Flight Rules (IFR) Communications"
        }
    }
}
