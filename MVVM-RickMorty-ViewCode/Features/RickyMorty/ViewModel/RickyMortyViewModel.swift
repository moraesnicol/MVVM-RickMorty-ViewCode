//
//  RickyMortyViewModel.swift
//  MVVM-RickMorty-ViewCode
//
//  Created by Gabriel on 06/09/21.
//

import Foundation

protocol IRickyMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickyMortyCharacters: [Result] { get set }
    var rickyMortyService: IRickyMortyService { get }
    
    var rickyMortyOutPut: RickyMortyOutPut? { get }
    
    func setDelegate(output: RickyMortyOutPut)
}

final class RickyMortyViewModel: IRickyMortyViewModel {
    var rickyMortyOutPut: RickyMortyOutPut?
    
    func setDelegate(output: RickyMortyOutPut) {
        rickyMortyOutPut = output
    }
    
    var rickyMortyCharacters: [Result]  = []
    private var isLoading = false
    var rickyMortyService: IRickyMortyService
    
    
    init() {
        rickyMortyService = RickyMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickyMortyService.fetchAllData { [weak self] (response) in
            self?.changeLoading()
            self?.rickyMortyCharacters = response ?? []
            self?.rickyMortyOutPut?.saveDatas(values: self?.rickyMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickyMortyOutPut?.changeLoading(isLoad: isLoading)
    }

}
