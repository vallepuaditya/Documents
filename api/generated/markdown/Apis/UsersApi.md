# UsersApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**addUserIdentifierApiV1UsersUserIdIdentifiersPost**](UsersApi.md#addUserIdentifierApiV1UsersUserIdIdentifiersPost) | **POST** /api/v1/users/{user_id}/identifiers | Add User Identifier |
| [**anonymizeUserApiV1UsersUserIdAnonymizePost**](UsersApi.md#anonymizeUserApiV1UsersUserIdAnonymizePost) | **POST** /api/v1/users/{user_id}/anonymize | Anonymize User |
| [**archiveUserApiV1UsersUserIdArchivePost**](UsersApi.md#archiveUserApiV1UsersUserIdArchivePost) | **POST** /api/v1/users/{user_id}/archive | Archive User |
| [**banUserApiV1UsersUserIdBanPost**](UsersApi.md#banUserApiV1UsersUserIdBanPost) | **POST** /api/v1/users/{user_id}/ban | Ban User |
| [**createUserApiV1UsersPost**](UsersApi.md#createUserApiV1UsersPost) | **POST** /api/v1/users/ | Create User |
| [**deactivateUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdDelete**](UsersApi.md#deactivateUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdDelete) | **DELETE** /api/v1/users/{user_id}/identifiers/{identifier_id} | Deactivate User Identifier |
| [**getAuthLogApiV1UsersUserIdAuthLogsAuthLogIdGet**](UsersApi.md#getAuthLogApiV1UsersUserIdAuthLogsAuthLogIdGet) | **GET** /api/v1/users/{user_id}/auth-logs/{auth_log_id} | Get Auth Log |
| [**getUserApiV1UsersUserIdGet**](UsersApi.md#getUserApiV1UsersUserIdGet) | **GET** /api/v1/users/{user_id} | Get User |
| [**getUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdGet**](UsersApi.md#getUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdGet) | **GET** /api/v1/users/{user_id}/identifiers/{identifier_id} | Get User Identifier |
| [**insertAuthLogApiV1UsersUserIdAuthLogsPost**](UsersApi.md#insertAuthLogApiV1UsersUserIdAuthLogsPost) | **POST** /api/v1/users/{user_id}/auth-logs | Insert Auth Log |
| [**listAuthLogsByLocationApiV1UsersUserIdAuthLogsByLocationLocationIdGet**](UsersApi.md#listAuthLogsByLocationApiV1UsersUserIdAuthLogsByLocationLocationIdGet) | **GET** /api/v1/users/{user_id}/auth-logs/by-location/{location_id} | List Auth Logs By Location |
| [**listFailedAuthAttemptsApiV1UsersUserIdAuthLogsFailedGet**](UsersApi.md#listFailedAuthAttemptsApiV1UsersUserIdAuthLogsFailedGet) | **GET** /api/v1/users/{user_id}/auth-logs/failed | List Failed Auth Attempts |
| [**listUserAuthLogsApiV1UsersUserIdAuthLogsGet**](UsersApi.md#listUserAuthLogsApiV1UsersUserIdAuthLogsGet) | **GET** /api/v1/users/{user_id}/auth-logs | List User Auth Logs |
| [**listUserIdentifiersApiV1UsersUserIdIdentifiersGet**](UsersApi.md#listUserIdentifiersApiV1UsersUserIdIdentifiersGet) | **GET** /api/v1/users/{user_id}/identifiers | List User Identifiers |
| [**listUsersApiV1UsersGet**](UsersApi.md#listUsersApiV1UsersGet) | **GET** /api/v1/users/ | List Users |
| [**listUsersByLocationApiV1UsersByLocationLocationIdGet**](UsersApi.md#listUsersByLocationApiV1UsersByLocationLocationIdGet) | **GET** /api/v1/users/by-location/{location_id} | List Users By Location |
| [**lookupIdentifierByValueApiV1UsersUserIdIdentifiersLookupGet**](UsersApi.md#lookupIdentifierByValueApiV1UsersUserIdIdentifiersLookupGet) | **GET** /api/v1/users/{user_id}/identifiers/lookup | Lookup Identifier By Value |
| [**reinstateUserApiV1UsersUserIdReinstatePost**](UsersApi.md#reinstateUserApiV1UsersUserIdReinstatePost) | **POST** /api/v1/users/{user_id}/reinstate | Reinstate User |
| [**searchUsersAdvancedApiV1UsersSearchPost**](UsersApi.md#searchUsersAdvancedApiV1UsersSearchPost) | **POST** /api/v1/users/search | Search Users Advanced |
| [**searchUsersApiV1UsersSearchGet**](UsersApi.md#searchUsersApiV1UsersSearchGet) | **GET** /api/v1/users/search | Search Users |
| [**updateUserApiV1UsersUserIdPut**](UsersApi.md#updateUserApiV1UsersUserIdPut) | **PUT** /api/v1/users/{user_id} | Update User |


<a name="addUserIdentifierApiV1UsersUserIdIdentifiersPost"></a>
# **addUserIdentifierApiV1UsersUserIdIdentifiersPost**
> oas_any_type_not_mapped addUserIdentifierApiV1UsersUserIdIdentifiersPost(user\_id, UserIdentifierCreate)

Add User Identifier

    Add identifier for user (fn_user_identifiers mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **UserIdentifierCreate** | [**UserIdentifierCreate**](../Models/UserIdentifierCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="anonymizeUserApiV1UsersUserIdAnonymizePost"></a>
# **anonymizeUserApiV1UsersUserIdAnonymizePost**
> oas_any_type_not_mapped anonymizeUserApiV1UsersUserIdAnonymizePost(user\_id, UserAnonymizeRequest)

Anonymize User

    Anonymize user (fn_users mode 7).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **UserAnonymizeRequest** | [**UserAnonymizeRequest**](../Models/UserAnonymizeRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="archiveUserApiV1UsersUserIdArchivePost"></a>
# **archiveUserApiV1UsersUserIdArchivePost**
> oas_any_type_not_mapped archiveUserApiV1UsersUserIdArchivePost(user\_id, UserArchiveRequest)

Archive User

    Archive user (fn_users mode 8).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **UserArchiveRequest** | [**UserArchiveRequest**](../Models/UserArchiveRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="banUserApiV1UsersUserIdBanPost"></a>
# **banUserApiV1UsersUserIdBanPost**
> oas_any_type_not_mapped banUserApiV1UsersUserIdBanPost(user\_id, UserBanRequest)

Ban User

    Ban user (fn_users mode 5).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **UserBanRequest** | [**UserBanRequest**](../Models/UserBanRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="createUserApiV1UsersPost"></a>
# **createUserApiV1UsersPost**
> oas_any_type_not_mapped createUserApiV1UsersPost(UserCreate)

Create User

    Create user (fn_users mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **UserCreate** | [**UserCreate**](../Models/UserCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deactivateUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdDelete"></a>
# **deactivateUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdDelete**
> oas_any_type_not_mapped deactivateUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdDelete(user\_id, identifier\_id)

Deactivate User Identifier

    Deactivate identifier (fn_user_identifiers mode 4).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **identifier\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getAuthLogApiV1UsersUserIdAuthLogsAuthLogIdGet"></a>
# **getAuthLogApiV1UsersUserIdAuthLogsAuthLogIdGet**
> oas_any_type_not_mapped getAuthLogApiV1UsersUserIdAuthLogsAuthLogIdGet(user\_id, auth\_log\_id)

Get Auth Log

    Single auth log row (fn_user_auth_logs mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **auth\_log\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getUserApiV1UsersUserIdGet"></a>
# **getUserApiV1UsersUserIdGet**
> oas_any_type_not_mapped getUserApiV1UsersUserIdGet(user\_id)

Get User

    Get user by id (fn_users mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdGet"></a>
# **getUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdGet**
> oas_any_type_not_mapped getUserIdentifierApiV1UsersUserIdIdentifiersIdentifierIdGet(user\_id, identifier\_id)

Get User Identifier

    Get identifier by id (fn_user_identifiers mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **identifier\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="insertAuthLogApiV1UsersUserIdAuthLogsPost"></a>
# **insertAuthLogApiV1UsersUserIdAuthLogsPost**
> oas_any_type_not_mapped insertAuthLogApiV1UsersUserIdAuthLogsPost(user\_id, UserAuthLogCreate)

Insert Auth Log

    Insert auth log entry (fn_user_auth_logs mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **UserAuthLogCreate** | [**UserAuthLogCreate**](../Models/UserAuthLogCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="listAuthLogsByLocationApiV1UsersUserIdAuthLogsByLocationLocationIdGet"></a>
# **listAuthLogsByLocationApiV1UsersUserIdAuthLogsByLocationLocationIdGet**
> oas_any_type_not_mapped listAuthLogsByLocationApiV1UsersUserIdAuthLogsByLocationLocationIdGet(user\_id, location\_id)

List Auth Logs By Location

    Auth logs for a location (fn_user_auth_logs mode 5).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **location\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listFailedAuthAttemptsApiV1UsersUserIdAuthLogsFailedGet"></a>
# **listFailedAuthAttemptsApiV1UsersUserIdAuthLogsFailedGet**
> oas_any_type_not_mapped listFailedAuthAttemptsApiV1UsersUserIdAuthLogsFailedGet(user\_id, logon\_id)

List Failed Auth Attempts

    Recent failed attempts by logon id (fn_user_auth_logs mode 4).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **logon\_id** | **String**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listUserAuthLogsApiV1UsersUserIdAuthLogsGet"></a>
# **listUserAuthLogsApiV1UsersUserIdAuthLogsGet**
> oas_any_type_not_mapped listUserAuthLogsApiV1UsersUserIdAuthLogsGet(user\_id)

List User Auth Logs

    Auth logs for user (fn_user_auth_logs mode 1).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listUserIdentifiersApiV1UsersUserIdIdentifiersGet"></a>
# **listUserIdentifiersApiV1UsersUserIdIdentifiersGet**
> oas_any_type_not_mapped listUserIdentifiersApiV1UsersUserIdIdentifiersGet(user\_id)

List User Identifiers

    List identifiers for a user (fn_user_identifiers mode 1).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listUsersApiV1UsersGet"></a>
# **listUsersApiV1UsersGet**
> oas_any_type_not_mapped listUsersApiV1UsersGet(location\_id)

List Users

    List all active users (fn_users mode 1 or 10 if location_id provided).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**| Filter by location ID | [optional] [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listUsersByLocationApiV1UsersByLocationLocationIdGet"></a>
# **listUsersByLocationApiV1UsersByLocationLocationIdGet**
> oas_any_type_not_mapped listUsersByLocationApiV1UsersByLocationLocationIdGet(location\_id)

List Users By Location

    Filter users by location (fn_users mode 10).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="lookupIdentifierByValueApiV1UsersUserIdIdentifiersLookupGet"></a>
# **lookupIdentifierByValueApiV1UsersUserIdIdentifiersLookupGet**
> oas_any_type_not_mapped lookupIdentifierByValueApiV1UsersUserIdIdentifiersLookupGet(user\_id, value)

Lookup Identifier By Value

    Lookup identifier by scanned value (fn_user_identifiers mode 5).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **value** | **String**| Barcode / QR value | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="reinstateUserApiV1UsersUserIdReinstatePost"></a>
# **reinstateUserApiV1UsersUserIdReinstatePost**
> oas_any_type_not_mapped reinstateUserApiV1UsersUserIdReinstatePost(user\_id, UserReinstateRequest)

Reinstate User

    Reinstate / unban user (fn_users mode 6).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **UserReinstateRequest** | [**UserReinstateRequest**](../Models/UserReinstateRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="searchUsersAdvancedApiV1UsersSearchPost"></a>
# **searchUsersAdvancedApiV1UsersSearchPost**
> oas_any_type_not_mapped searchUsersAdvancedApiV1UsersSearchPost(UserSearchRequest)

Search Users Advanced

    Advanced search users with filters, pagination, and sorting.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **UserSearchRequest** | [**UserSearchRequest**](../Models/UserSearchRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="searchUsersApiV1UsersSearchGet"></a>
# **searchUsersApiV1UsersSearchGet**
> oas_any_type_not_mapped searchUsersApiV1UsersSearchGet(q)

Search Users

    Search users by term (fn_users mode 9).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **q** | **String**| Search term | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateUserApiV1UsersUserIdPut"></a>
# **updateUserApiV1UsersUserIdPut**
> oas_any_type_not_mapped updateUserApiV1UsersUserIdPut(user\_id, UserUpdate)

Update User

    Update user (fn_users mode 4).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_id** | **Integer**|  | [default to null] |
| **UserUpdate** | [**UserUpdate**](../Models/UserUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

