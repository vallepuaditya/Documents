# UserGroupsApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createUserGroupApiV1UserGroupsPost**](UserGroupsApi.md#createUserGroupApiV1UserGroupsPost) | **POST** /api/v1/user-groups/ | Create User Group |
| [**deactivateUserGroupApiV1UserGroupsUserGroupIdDelete**](UserGroupsApi.md#deactivateUserGroupApiV1UserGroupsUserGroupIdDelete) | **DELETE** /api/v1/user-groups/{user_group_id} | Deactivate User Group |
| [**getUserGroupApiV1UserGroupsUserGroupIdGet**](UserGroupsApi.md#getUserGroupApiV1UserGroupsUserGroupIdGet) | **GET** /api/v1/user-groups/{user_group_id} | Get User Group |
| [**listUserGroupsApiV1UserGroupsGet**](UserGroupsApi.md#listUserGroupsApiV1UserGroupsGet) | **GET** /api/v1/user-groups/ | List User Groups |
| [**updateUserGroupApiV1UserGroupsUserGroupIdPut**](UserGroupsApi.md#updateUserGroupApiV1UserGroupsUserGroupIdPut) | **PUT** /api/v1/user-groups/{user_group_id} | Update User Group |


<a name="createUserGroupApiV1UserGroupsPost"></a>
# **createUserGroupApiV1UserGroupsPost**
> oas_any_type_not_mapped createUserGroupApiV1UserGroupsPost(UserGroupCreate)

Create User Group

    Create group (fn_user_groups mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **UserGroupCreate** | [**UserGroupCreate**](../Models/UserGroupCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deactivateUserGroupApiV1UserGroupsUserGroupIdDelete"></a>
# **deactivateUserGroupApiV1UserGroupsUserGroupIdDelete**
> oas_any_type_not_mapped deactivateUserGroupApiV1UserGroupsUserGroupIdDelete(user\_group\_id)

Deactivate User Group

    Deactivate group (fn_user_groups mode 5).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_group\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getUserGroupApiV1UserGroupsUserGroupIdGet"></a>
# **getUserGroupApiV1UserGroupsUserGroupIdGet**
> oas_any_type_not_mapped getUserGroupApiV1UserGroupsUserGroupIdGet(user\_group\_id)

Get User Group

    Get group by id (fn_user_groups mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_group\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listUserGroupsApiV1UserGroupsGet"></a>
# **listUserGroupsApiV1UserGroupsGet**
> oas_any_type_not_mapped listUserGroupsApiV1UserGroupsGet(location\_id)

List User Groups

    List all active groups (fn_user_groups mode 1).

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

<a name="updateUserGroupApiV1UserGroupsUserGroupIdPut"></a>
# **updateUserGroupApiV1UserGroupsUserGroupIdPut**
> oas_any_type_not_mapped updateUserGroupApiV1UserGroupsUserGroupIdPut(user\_group\_id, UserGroupUpdate)

Update User Group

    Update group (fn_user_groups mode 4).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_group\_id** | **Integer**|  | [default to null] |
| **UserGroupUpdate** | [**UserGroupUpdate**](../Models/UserGroupUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

