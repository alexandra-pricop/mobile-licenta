//
//  DemoAPI.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 05/02/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Moya

public enum ContaTrackerAPI {
    case login(email: String, password: String)
    case register(name: String, email: String, password: String, role: String)
    case addCompany(name: String, cui: String)
    case listCompanyRequests
    case uploadDocument(company_id: Int, title: String, description: String?, issue_date: String, category: String, file: Data)
    case listEmployeeRequests(company_id: Int)
    case acceptEmployeeJoin(company_id: Int, company_user_id: Int)
    case declineEmployeeJoin(company_id: Int, company_user_id: Int)
    case listCompanyEmployees(company_id: Int)
    case updateEmployeeRoles(company_id: Int, user_id: Int, roles: [String])
    case listDocuments(company_id: Int, current_date: String?)
    case listPendingEmployeeRequests
    case companySignup(company_cui: String)
    case accountantListCompanyRequests
    case acceptCompany(request_id: Int)
    case rejectCompany(request_id: Int)
    case listCompanies
    case approveDocument(company_id: Int, document_id: Int)
    case removeDocument(company_id: Int, document_id: Int)
    case listRoles(company_id: Int, user_id: Int)
    case listRolesEmployee(company_id: Int)
}

extension ContaTrackerAPI: TargetType {
    public var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .login: return "/users/sign_in"
        case .register: return "/users"
        case .addCompany: return "/api/v1/patron/create_company"
        case .listCompanyRequests: return "/api/v1/patron/list_company_requests"
        case let .uploadDocument(company_id, _, _, _, _, _): return "/api/v1/companies/\(company_id)/documents/upload_document"
        case .listEmployeeRequests: return "/api/v1/patron/list_join_requests"
        case .acceptEmployeeJoin: return "/api/v1/patron/accept_join"
        case .declineEmployeeJoin: return "/api/v1/patron/reject_join"
        case .listCompanyEmployees: return "/api/v1/patron/list_users"
        case .updateEmployeeRoles: return "/api/v1/patron/update_roles"
        case let .listDocuments(company_id, _): return "/api/v1/companies/\(company_id)/documents/list_documents"
        case .listPendingEmployeeRequests: return "/api/v1/angajat/list_requests"
        case .companySignup: return "/api/v1/angajat/join_company"
        case .accountantListCompanyRequests: return "/api/v1/contabil/list_company_requests"
        case .acceptCompany: return "/api/v1/contabil/approve_company"
        case .rejectCompany: return "/api/v1/contabil/reject_company"
        case .listCompanies: return "/api/v1/companies"
        case let .approveDocument(company_id, _): return "/api/v1/companies/\(company_id)/documents/approve_document"
        case let .removeDocument(company_id, _): return "/api/v1/companies/\(company_id)/documents/remove_document"
        case .listRoles: return "/api/v1/patron/list_roles"
        case .listRolesEmployee: return "/api/v1/angajat/list_roles"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        // swiftlint: disable line_length
        case .login, .register, .addCompany, .uploadDocument, .acceptEmployeeJoin, .declineEmployeeJoin, .updateEmployeeRoles, .companySignup, .acceptCompany, .rejectCompany, .approveDocument:
            return .post
        case .removeDocument:
            return .delete
        default:
            return .get
        }
    }
    
    public var headers: [String: String]? {
        if let token = AuthManager.shared.token {
            switch token.type() {
            case .bearer(let token): return ["Authorization": token]
            case .unauthorized: break
            }
        }
        return nil
    }
    
    public var sampleData: Data {
        return Data()//"".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(
                parameters: ["user": ["email": email, "password": password]],
                encoding: JSONEncoding.default
            )
        case let .register(name, email, password, role):
            return .requestParameters(
                parameters: ["user": ["name": name, "email": email, "password": password, "role": role]],
                encoding: JSONEncoding.default
            )
        case let .addCompany(name, cui):
            return .requestParameters(
                parameters: ["company": ["name": name, "cui": cui]],
                encoding: JSONEncoding.default)
            
        case let .uploadDocument(company_id, title, description, issue_date, category, file):
            let titleData = title.data(using: String.Encoding.utf8) ?? Data()
            let descriptionData = description!.data(using: String.Encoding.utf8) ?? Data()
            let issueDateData = issue_date.data(using: String.Encoding.utf8) ?? Data()
            let categoryData = category.data(using: String.Encoding.utf8) ?? Data()
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(file), name: "file", fileName: "mydoc", mimeType: "image/jpeg")]
            formData.append(Moya.MultipartFormData(provider: .data(titleData), name: "title"))
            formData.append(Moya.MultipartFormData(provider: .data(descriptionData), name: "description"))
            formData.append(Moya.MultipartFormData(provider: .data(issueDateData), name: "issue_date"))
            formData.append(Moya.MultipartFormData(provider: .data(categoryData), name: "category"))
            print("date date \(formData)")
            return .uploadMultipart(formData)
            
        case let .listEmployeeRequests(company_id):
            return .requestParameters(parameters: ["company_id": company_id], encoding: URLEncoding.queryString)
            
        case let .acceptEmployeeJoin(company_id, company_user_id):
            return .requestParameters(parameters: ["company_id": company_id, "company_user_id": company_user_id], encoding: JSONEncoding.default)
            
        case let .declineEmployeeJoin(company_id, company_user_id):
            return .requestParameters(parameters: ["company_id": company_id, "company_user_id": company_user_id], encoding: JSONEncoding.default)
        
        case let .listCompanyEmployees(company_id):
            return .requestParameters(
                parameters: ["company_id": company_id],
                encoding: URLEncoding.queryString
            )
            
        case let .updateEmployeeRoles(company_id, user_id, roles):
            return .requestParameters(
                parameters: ["company_id": company_id, "user_id": user_id, "roles": roles],
                encoding: JSONEncoding.default
            )
            
        case let .companySignup(company_cui):
            return .requestParameters(
                parameters: ["cui": company_cui],
                encoding: JSONEncoding.default
            )
            
        case let .acceptCompany(request_id):
            return .requestParameters(
                parameters: ["company_id": request_id],
                encoding: JSONEncoding.default
            )
            
        case let .rejectCompany(request_id):
            return .requestParameters(
                parameters: ["company_id": request_id],
                encoding: JSONEncoding.default
            )
            
        case let .approveDocument(company_id, document_id):
            return .requestParameters(
                parameters: ["document_id": document_id],
                encoding: JSONEncoding.default
            )
            
        case let .removeDocument(company_id, document_id):
            return .requestParameters(
                parameters: ["document_id": document_id],
                encoding: JSONEncoding.default
            )
            
        case let .listDocuments(_, current_date):
            if let currentDate = current_date {
                return .requestParameters(
                    parameters: ["date": currentDate],
                    encoding: URLEncoding.queryString
                )
            } else {
                return .requestPlain
            }
            
        case let .listRoles(company_id, user_id):
            return .requestParameters(
                parameters: ["company_id": company_id, "user_id": user_id],
                encoding: URLEncoding.queryString
            )
            
        case let .listRolesEmployee(company_id):
            return .requestParameters(
                parameters: ["company_id": company_id],
                encoding: URLEncoding.queryString
            )
        
        default:
            return .requestPlain
        }
    }
    
    public func url(route: TargetType) -> String {
        return route.baseURL.appendingPathComponent(route.path).absoluteString
    }
}
