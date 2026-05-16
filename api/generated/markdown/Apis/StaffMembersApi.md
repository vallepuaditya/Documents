# StaffMembersApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**assignStaffRoleApiV1StaffMembersStaffIdAssignRolePost**](StaffMembersApi.md#assignStaffRoleApiV1StaffMembersStaffIdAssignRolePost) | **POST** /api/v1/staff-members/{staff_id}/assign-role | Assign Staff Role |
| [**createStaffMemberApiV1StaffMembersPost**](StaffMembersApi.md#createStaffMemberApiV1StaffMembersPost) | **POST** /api/v1/staff-members | Create Staff Member |
| [**deactivateStaffMemberApiV1StaffMembersStaffIdDelete**](StaffMembersApi.md#deactivateStaffMemberApiV1StaffMembersStaffIdDelete) | **DELETE** /api/v1/staff-members/{staff_id} | Deactivate Staff Member |
| [**getStaffMemberApiV1StaffMembersStaffIdGet**](StaffMembersApi.md#getStaffMemberApiV1StaffMembersStaffIdGet) | **GET** /api/v1/staff-members/{staff_id} | Get Staff Member |
| [**listStaffMembersApiV1StaffMembersGet**](StaffMembersApi.md#listStaffMembersApiV1StaffMembersGet) | **GET** /api/v1/staff-members | List Staff Members |
| [**revokeStaffRoleApiV1StaffMembersStaffIdRevokeRolePost**](StaffMembersApi.md#revokeStaffRoleApiV1StaffMembersStaffIdRevokeRolePost) | **POST** /api/v1/staff-members/{staff_id}/revoke-role | Revoke Staff Role |
| [**updateStaffMemberApiV1StaffMembersStaffIdPut**](StaffMembersApi.md#updateStaffMemberApiV1StaffMembersStaffIdPut) | **PUT** /api/v1/staff-members/{staff_id} | Update Staff Member |


<a name="assignStaffRoleApiV1StaffMembersStaffIdAssignRolePost"></a>
# **assignStaffRoleApiV1StaffMembersStaffIdAssignRolePost**
> oas_any_type_not_mapped assignStaffRoleApiV1StaffMembersStaffIdAssignRolePost(staff\_id, StaffAssignRoleBody)

Assign Staff Role

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **staff\_id** | **UUID**|  | [default to null] |
| **StaffAssignRoleBody** | [**StaffAssignRoleBody**](../Models/StaffAssignRoleBody.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="createStaffMemberApiV1StaffMembersPost"></a>
# **createStaffMemberApiV1StaffMembersPost**
> oas_any_type_not_mapped createStaffMemberApiV1StaffMembersPost(StaffMemberCreate)

Create Staff Member

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **StaffMemberCreate** | [**StaffMemberCreate**](../Models/StaffMemberCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deactivateStaffMemberApiV1StaffMembersStaffIdDelete"></a>
# **deactivateStaffMemberApiV1StaffMembersStaffIdDelete**
> oas_any_type_not_mapped deactivateStaffMemberApiV1StaffMembersStaffIdDelete(staff\_id)

Deactivate Staff Member

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **staff\_id** | **UUID**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getStaffMemberApiV1StaffMembersStaffIdGet"></a>
# **getStaffMemberApiV1StaffMembersStaffIdGet**
> oas_any_type_not_mapped getStaffMemberApiV1StaffMembersStaffIdGet(staff\_id)

Get Staff Member

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **staff\_id** | **UUID**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listStaffMembersApiV1StaffMembersGet"></a>
# **listStaffMembersApiV1StaffMembersGet**
> oas_any_type_not_mapped listStaffMembersApiV1StaffMembersGet()

List Staff Members

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="revokeStaffRoleApiV1StaffMembersStaffIdRevokeRolePost"></a>
# **revokeStaffRoleApiV1StaffMembersStaffIdRevokeRolePost**
> oas_any_type_not_mapped revokeStaffRoleApiV1StaffMembersStaffIdRevokeRolePost(staff\_id, StaffRevokeRoleBody)

Revoke Staff Role

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **staff\_id** | **UUID**|  | [default to null] |
| **StaffRevokeRoleBody** | [**StaffRevokeRoleBody**](../Models/StaffRevokeRoleBody.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="updateStaffMemberApiV1StaffMembersStaffIdPut"></a>
# **updateStaffMemberApiV1StaffMembersStaffIdPut**
> oas_any_type_not_mapped updateStaffMemberApiV1StaffMembersStaffIdPut(staff\_id, StaffMemberUpdate)

Update Staff Member

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **staff\_id** | **UUID**|  | [default to null] |
| **StaffMemberUpdate** | [**StaffMemberUpdate**](../Models/StaffMemberUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

