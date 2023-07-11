//
//  MainViewModel.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import Foundation
import RxSwift
import RxRelay

class MainViewModel {
    
    var list: [HierarchicalLists?] = []
    var loadCategoryData: Bool = false
    var loadMovie: Bool = false
    var category: MainList = .None
    var categoryData = ""
    var delegate: ClickedOnData?
    
    func getMainHirarchy() {
        var list: [HierarchicalLists] = []
        list.append(HierarchicalLists(title: MainList.Year.rawValue, type: .Year))
        list.append(HierarchicalLists(title: MainList.Genre.rawValue, type: .Genre))
        list.append(HierarchicalLists(title: MainList.Directors.rawValue, type: .Directors))
        list.append(HierarchicalLists(title: MainList.Actors.rawValue, type: .Actors))
        self.list = list
        delegate?.didClicked(data: list)
    }
    
    func getCategoryHirarchy(data: [Movies?]?, type: MainList) {
        var list: [HierarchicalLists] = []
        switch type {
        case .Year:
            var year = Set<String>()
            data?.forEach({
                year.insert($0?.Year ?? "")
            })
            Array(year).forEach { year in
                list.append(HierarchicalLists(title: year))
            }
        case .Genre:
            var set = Set<String>()
            data?.forEach({
                getData(str: $0?.Genre ?? "").forEach {
                    set.insert($0 ?? "")
                }
            })
            Array(set).forEach { item in
                list.append(HierarchicalLists(title: item))
            }
        case .Directors:
            var set = Set<String>()
            data?.forEach({
                getData(str: $0?.Director ?? "").forEach {
                    set.insert($0 ?? "")
                }
            })
            Array(set).forEach { item in
                list.append(HierarchicalLists(title: item))
            }
        case .Actors:
            var set = Set<String>()
            data?.forEach({
                getData(str: $0?.Actors ?? "").forEach {
                    set.insert($0 ?? "")
                }
            })
            Array(set).forEach { item in
                list.append(HierarchicalLists(title: item))
            }
        case .None:
            break
        }
        self.list = list
        self.category = type
        delegate?.didClicked(data: list)
    }
    
    func loadData() -> [Movies?]?  {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json")
        else {
            print("Json file not found")
            return nil
        }
        
        let data = try? Data(contentsOf: url)
        let users = try? JSONDecoder().decode([Movies].self, from: data!)
        return users
    }
    
    func getData(str: String) -> Set<String?> {
        let data = str.components(separatedBy: ", ")
        return Set(data)
    }
    
    func setCategory(value: MainList) {
        self.category = value
    }
    
    func setCategoryData(value: String) {
        self.categoryData = value
    }
    
    func findMovies(data: [Movies?]?, search: String) {
        var list: [HierarchicalLists] = []
        data?.forEach({ movie in
            if (movie?.Title?.lowercased() ?? "").contains(search.lowercased()) || (movie?.Actors?.lowercased() ?? "").contains(search.lowercased()) || (movie?.Genre?.lowercased() ?? "").contains(search.lowercased()) || (movie?.Director?.lowercased() ?? "").contains(search.lowercased())  {
                list.append(HierarchicalLists(title: movie?.Title ?? "", poster: movie?.Poster, language: movie?.Language,year: movie?.Year, plot: movie?.Plot, cast: nil, releasedDate:  movie?.Released,genre: movie?.Genre, rating: movie?.Ratings))
            }
        })
        self.list = list
        delegate?.didClicked(data: list)
    }
    
    func findMoviesFilter(data: [Movies?]?) {
        var list: [HierarchicalLists] = []
        switch category {
        case .Year:
            data?.forEach({ movie in
                if (movie?.Year ?? "") == categoryData {
                    list.append(HierarchicalLists(title: movie?.Title ?? "", poster: movie?.Poster, language: movie?.Language,year: movie?.Year, plot: movie?.Plot, cast: nil, releasedDate:  movie?.Released,genre: movie?.Genre, rating: movie?.Ratings))
                }
            })
        case .Genre:
            data?.forEach({ movie in
                if (movie?.Genre?.lowercased() ?? "").contains(categoryData.lowercased()) {
                    list.append(HierarchicalLists(title: movie?.Title ?? "", poster: movie?.Poster, language: movie?.Language,year: movie?.Year, plot: movie?.Plot, cast: nil, releasedDate:  movie?.Released,genre: movie?.Genre, rating: movie?.Ratings))
                }
            })
        case .Directors:
            data?.forEach({ movie in
                if (movie?.Director?.lowercased() ?? "").contains(categoryData.lowercased()) {
                    list.append(HierarchicalLists(title: movie?.Title ?? "", poster: movie?.Poster, language: movie?.Language,year: movie?.Year, plot: movie?.Plot, cast: nil, releasedDate:  movie?.Released,genre: movie?.Genre, rating: movie?.Ratings))
                }
            })
        case .Actors:
            data?.forEach({ movie in
                if (movie?.Actors?.lowercased() ?? "").contains(categoryData.lowercased()) {
                    list.append(HierarchicalLists(title: movie?.Title ?? "", poster: movie?.Poster, language: movie?.Language,year: movie?.Year, plot: movie?.Plot, cast: nil, releasedDate:  movie?.Released,genre: movie?.Genre, rating: movie?.Ratings))
                }
            })
        case .None:
            break
        }
        self.list = list
        delegate?.didClicked(data: list)
    }
}
