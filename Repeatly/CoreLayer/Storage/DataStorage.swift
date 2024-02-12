//
//  DataStorage.swift
//  Repeatly
//
//  Created by Nikita Koruts on 11.02.2024.
//

import Foundation
import Combine
import CoreData
//
//class HomeViewModel: ObservableObject {
//    @Published var activeCourses: [Note] = []
//    @Published var overallGpa: Double = 0
//    @Published var courses: [Note] = [] {
//        willSet {
//            print("Updating courses to: \(newValue)")
//            //            activeCourses = newValue.filter { $0.score == 0 }
//            //            let scoreSum = newValue.map { $0.score }.filter { $0 != 0 }
//            //            let passedCourses = newValue.filter { $0.score != 0 }.count
//            //            overallGpa = scoreSum / passedCourses
//        }
//    }
//    
//    private var cancellable: AnyCancellable?
//    init(coursePublisher: AnyPublisher<[Note], Never> = CourseStorage.shared.courses.eraseToAnyPublisher()) {
//        cancellable = coursePublisher.sink { courses in
//            print( "Updating courses")
//            self.courses = courses
//        }
//    }
//}
//
//class CourseStorage: NSObject, ObservableObject {
//    var courses = CurrentValueSubject<[Note], Never>([])
//    private let courseFetchController: NSFetchedResultsController<Note>
//    
//    
//    // SINGELTON INSTANCE
//    static let shared: CourseStorage = CourseStorage()
//    
//    private override init() {
//        courseFetchController = NSFetchedResultsController(
//            fetchRequest: Note.fetchRequest(),
//            managedObjectContext: CoreDataManager().viewContext,
//            sectionNameKeyPath: nil, cacheName: nil)
//        super.init()
//        
//        courseFetchController.delegate = self
//        do {
//            try courseFetchController.performFetch()
//            courses.value = courseFetchController.fetchedObjects ?? []
//        } catch {
//            NSLog("Error: could not fetch objects")
//        }
//    }
//    
//    func add() { }
//    func update(withId id: UUID) { }
//    func delete(id: UUID) { }
//}
//
//extension CourseStorage: NSFetchedResultsControllerDelegate {
//    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
//        guard let courses = controller.fetchedObjects as? [Note] else { return }
//        print("Context has changed, reloading courses")
//        self.courses.value = courses
//    }
//}
