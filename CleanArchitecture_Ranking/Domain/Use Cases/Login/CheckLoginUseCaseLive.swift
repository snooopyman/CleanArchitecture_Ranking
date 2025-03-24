//
//  CheckLoginUseCaseLive.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

actor CheckLoginUseCaseLive: CheckLoginUseCaseType {
    private let repository: CheckLoginRepositoryType
    
    init(repository: CheckLoginRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<LoginModel, APIDomainError> {
        let result = await repository.checkLogin()
        
        switch result {
        case .success(let loginDTO):
            let loginModel = LoginDTOMapper.map(loginDTO)
            return .success(loginModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
