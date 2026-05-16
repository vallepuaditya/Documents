# StaffPermissionsApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createStaffPermissionApiV1StaffPermissionsPost**](StaffPermissionsApi.md#createStaffPermissionApiV1StaffPermissionsPost) | **POST** /api/v1/staff-permissions | Create Staff Permission |
| [**deleteStaffPermissionApiV1StaffPermissionsPermissionIdDelete**](StaffPermissionsApi.md#deleteStaffPermissionApiV1StaffPermissionsPermissionIdDelete) | **DELETE** /api/v1/staff-permissions/{permission_id} | Delete Staff Permission |
| [**listStaffPermissionsApiV1StaffPermissionsGet**](StaffPermissionsApi.md#listStaffPermissionsApiV1StaffPermissionsGet) | **GET** /api/v1/staff-permissions | List Staff Permissions |
| [**updateStaffPermissionApiV1StaffPermissionsPermissionIdPut**](StaffPermissionsApi.md#updateStaffPermissionApiV1StaffPermissionsPermissionIdPut) | **PUT** /api/v1/staff-permissions/{permission_id} | Update Staff Permission |


<a name="createStaffPermissionApiV1StaffPermissionsPost"></a>
# **createStaffPermissionApiV1StaffPermissionsPost**
> oas_any_type_not_mapped createStaffPermissionApiV1StaffPermissionsPost(StaffPermissionCreate)

Create Staff Permission

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **StaffPermissionCreate** | [**StaffPermissionCreate**](../Models/StaffPermissionCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteStaffPermissionApiV1StaffPermissionsPermissionIdDelete"></a>
# **deleteStaffPermissionApiV1StaffPermissionsPermissionIdDelete**
> oas_any_type_not_mapped deleteStaffPermissionApiV1StaffPermissionsPermissionIdDelete(permission\_id)

Delete Staff Permission

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **permission\_id** | **UUID**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listStaffPermissionsApiV1StaffPermissionsGet"></a>
# **listStaffPermissionsApiV1StaffPermissionsGet**
> oas_any_type_not_mapped listStaffPermissionsApiV1StaffPermissionsGet()

List Staff Permissions

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateStaffPermissionApiV1StaffPermissionsPermissionIdPut"></a>
# **updateStaffPermissionApiV1StaffPermissionsPermissionIdPut**
> oas_any_type_not_mapped updateStaffPermissionApiV1StaffPermissionsPermissionIdPut(permission\_id, StaffPermissionUpdate)

Update Staff Permission

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **permission\_id** | **UUID**|  | [default to null] |
| **StaffPermissionUpdate** | [**StaffPermissionUpdate**](../Models/StaffPermissionUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

