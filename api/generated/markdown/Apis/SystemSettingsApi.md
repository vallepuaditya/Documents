# SystemSettingsApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**getRolesPermissionsApiV1SystemSettingsRolesPermissionsGet**](SystemSettingsApi.md#getRolesPermissionsApiV1SystemSettingsRolesPermissionsGet) | **GET** /api/v1/system-settings/roles-permissions | Get Roles Permissions |
| [**getStaffAssignmentsApiV1SystemSettingsStaffAssignmentsGet**](SystemSettingsApi.md#getStaffAssignmentsApiV1SystemSettingsStaffAssignmentsGet) | **GET** /api/v1/system-settings/staff-assignments | Get Staff Assignments |
| [**syncRolePermissionsApiV1SystemSettingsRolesRoleIdPermissionsPut**](SystemSettingsApi.md#syncRolePermissionsApiV1SystemSettingsRolesRoleIdPermissionsPut) | **PUT** /api/v1/system-settings/roles/{role_id}/permissions | Sync Role Permissions |
| [**syncStaffRoleAssignmentApiV1SystemSettingsStaffStaffIdRoleAssignmentPut**](SystemSettingsApi.md#syncStaffRoleAssignmentApiV1SystemSettingsStaffStaffIdRoleAssignmentPut) | **PUT** /api/v1/system-settings/staff/{staff_id}/role-assignment | Sync Staff Role Assignment |


<a name="getRolesPermissionsApiV1SystemSettingsRolesPermissionsGet"></a>
# **getRolesPermissionsApiV1SystemSettingsRolesPermissionsGet**
> oas_any_type_not_mapped getRolesPermissionsApiV1SystemSettingsRolesPermissionsGet()

Get Roles Permissions

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getStaffAssignmentsApiV1SystemSettingsStaffAssignmentsGet"></a>
# **getStaffAssignmentsApiV1SystemSettingsStaffAssignmentsGet**
> oas_any_type_not_mapped getStaffAssignmentsApiV1SystemSettingsStaffAssignmentsGet()

Get Staff Assignments

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="syncRolePermissionsApiV1SystemSettingsRolesRoleIdPermissionsPut"></a>
# **syncRolePermissionsApiV1SystemSettingsRolesRoleIdPermissionsPut**
> oas_any_type_not_mapped syncRolePermissionsApiV1SystemSettingsRolesRoleIdPermissionsPut(role\_id, SyncRolePermissionsBody)

Sync Role Permissions

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **role\_id** | **UUID**|  | [default to null] |
| **SyncRolePermissionsBody** | [**SyncRolePermissionsBody**](../Models/SyncRolePermissionsBody.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="syncStaffRoleAssignmentApiV1SystemSettingsStaffStaffIdRoleAssignmentPut"></a>
# **syncStaffRoleAssignmentApiV1SystemSettingsStaffStaffIdRoleAssignmentPut**
> oas_any_type_not_mapped syncStaffRoleAssignmentApiV1SystemSettingsStaffStaffIdRoleAssignmentPut(staff\_id, SyncStaffAssignmentBody)

Sync Staff Role Assignment

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **staff\_id** | **UUID**|  | [default to null] |
| **SyncStaffAssignmentBody** | [**SyncStaffAssignmentBody**](../Models/SyncStaffAssignmentBody.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

