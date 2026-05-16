# StaffRolesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createStaffRoleApiV1StaffRolesPost**](StaffRolesApi.md#createStaffRoleApiV1StaffRolesPost) | **POST** /api/v1/staff-roles | Create Staff Role |
| [**deleteStaffRoleApiV1StaffRolesRoleIdDelete**](StaffRolesApi.md#deleteStaffRoleApiV1StaffRolesRoleIdDelete) | **DELETE** /api/v1/staff-roles/{role_id} | Delete Staff Role |
| [**listStaffRolesApiV1StaffRolesGet**](StaffRolesApi.md#listStaffRolesApiV1StaffRolesGet) | **GET** /api/v1/staff-roles | List Staff Roles |
| [**updateStaffRoleApiV1StaffRolesRoleIdPut**](StaffRolesApi.md#updateStaffRoleApiV1StaffRolesRoleIdPut) | **PUT** /api/v1/staff-roles/{role_id} | Update Staff Role |


<a name="createStaffRoleApiV1StaffRolesPost"></a>
# **createStaffRoleApiV1StaffRolesPost**
> oas_any_type_not_mapped createStaffRoleApiV1StaffRolesPost(StaffRoleCreate)

Create Staff Role

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **StaffRoleCreate** | [**StaffRoleCreate**](../Models/StaffRoleCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteStaffRoleApiV1StaffRolesRoleIdDelete"></a>
# **deleteStaffRoleApiV1StaffRolesRoleIdDelete**
> oas_any_type_not_mapped deleteStaffRoleApiV1StaffRolesRoleIdDelete(role\_id)

Delete Staff Role

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **role\_id** | **UUID**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listStaffRolesApiV1StaffRolesGet"></a>
# **listStaffRolesApiV1StaffRolesGet**
> oas_any_type_not_mapped listStaffRolesApiV1StaffRolesGet()

List Staff Roles

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateStaffRoleApiV1StaffRolesRoleIdPut"></a>
# **updateStaffRoleApiV1StaffRolesRoleIdPut**
> oas_any_type_not_mapped updateStaffRoleApiV1StaffRolesRoleIdPut(role\_id, StaffRoleUpdate)

Update Staff Role

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **role\_id** | **UUID**|  | [default to null] |
| **StaffRoleUpdate** | [**StaffRoleUpdate**](../Models/StaffRoleUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

