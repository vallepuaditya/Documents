# UserTypesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createUserTypeApiV1UserTypesPost**](UserTypesApi.md#createUserTypeApiV1UserTypesPost) | **POST** /api/v1/user-types/ | Create User Type |
| [**deactivateUserTypeApiV1UserTypesUserTypeIdDelete**](UserTypesApi.md#deactivateUserTypeApiV1UserTypesUserTypeIdDelete) | **DELETE** /api/v1/user-types/{user_type_id} | Deactivate User Type |
| [**getUserTypeApiV1UserTypesUserTypeIdGet**](UserTypesApi.md#getUserTypeApiV1UserTypesUserTypeIdGet) | **GET** /api/v1/user-types/{user_type_id} | Get User Type |
| [**listUserTypesApiV1UserTypesGet**](UserTypesApi.md#listUserTypesApiV1UserTypesGet) | **GET** /api/v1/user-types/ | List User Types |
| [**updateUserTypeApiV1UserTypesUserTypeIdPut**](UserTypesApi.md#updateUserTypeApiV1UserTypesUserTypeIdPut) | **PUT** /api/v1/user-types/{user_type_id} | Update User Type |


<a name="createUserTypeApiV1UserTypesPost"></a>
# **createUserTypeApiV1UserTypesPost**
> oas_any_type_not_mapped createUserTypeApiV1UserTypesPost(UserTypeCreate)

Create User Type

    Create user type (fn_user_types mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **UserTypeCreate** | [**UserTypeCreate**](../Models/UserTypeCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deactivateUserTypeApiV1UserTypesUserTypeIdDelete"></a>
# **deactivateUserTypeApiV1UserTypesUserTypeIdDelete**
> oas_any_type_not_mapped deactivateUserTypeApiV1UserTypesUserTypeIdDelete(user\_type\_id)

Deactivate User Type

    Deactivate user type (fn_user_types mode 5).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_type\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getUserTypeApiV1UserTypesUserTypeIdGet"></a>
# **getUserTypeApiV1UserTypesUserTypeIdGet**
> oas_any_type_not_mapped getUserTypeApiV1UserTypesUserTypeIdGet(user\_type\_id)

Get User Type

    Get user type by id (fn_user_types mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_type\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listUserTypesApiV1UserTypesGet"></a>
# **listUserTypesApiV1UserTypesGet**
> oas_any_type_not_mapped listUserTypesApiV1UserTypesGet(location\_id)

List User Types

    List all active user types (fn_user_types mode 1).

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

<a name="updateUserTypeApiV1UserTypesUserTypeIdPut"></a>
# **updateUserTypeApiV1UserTypesUserTypeIdPut**
> oas_any_type_not_mapped updateUserTypeApiV1UserTypesUserTypeIdPut(user\_type\_id, UserTypeUpdate)

Update User Type

    Update user type (fn_user_types mode 4).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_type\_id** | **Integer**|  | [default to null] |
| **UserTypeUpdate** | [**UserTypeUpdate**](../Models/UserTypeUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

