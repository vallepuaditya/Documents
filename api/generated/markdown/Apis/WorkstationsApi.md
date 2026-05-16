# WorkstationsApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createWorkstationApiV1WorkstationsPost**](WorkstationsApi.md#createWorkstationApiV1WorkstationsPost) | **POST** /api/v1/workstations/ | Create Workstation |
| [**deleteWorkstationApiV1WorkstationsSystemIdDelete**](WorkstationsApi.md#deleteWorkstationApiV1WorkstationsSystemIdDelete) | **DELETE** /api/v1/workstations/{system_id} | Delete Workstation |
| [**getWorkstationApiV1WorkstationsSystemIdGet**](WorkstationsApi.md#getWorkstationApiV1WorkstationsSystemIdGet) | **GET** /api/v1/workstations/{system_id} | Get Workstation |
| [**listWorkstationsApiV1WorkstationsGet**](WorkstationsApi.md#listWorkstationsApiV1WorkstationsGet) | **GET** /api/v1/workstations/ | List Workstations |
| [**patchWorkstationStatusApiV1WorkstationsSystemIdStatusPatch**](WorkstationsApi.md#patchWorkstationStatusApiV1WorkstationsSystemIdStatusPatch) | **PATCH** /api/v1/workstations/{system_id}/status | Patch Workstation Status |
| [**updateWorkstationApiV1WorkstationsSystemIdPut**](WorkstationsApi.md#updateWorkstationApiV1WorkstationsSystemIdPut) | **PUT** /api/v1/workstations/{system_id} | Update Workstation |


<a name="createWorkstationApiV1WorkstationsPost"></a>
# **createWorkstationApiV1WorkstationsPost**
> oas_any_type_not_mapped createWorkstationApiV1WorkstationsPost(WorkStationCreate)

Create Workstation

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **WorkStationCreate** | [**WorkStationCreate**](../Models/WorkStationCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteWorkstationApiV1WorkstationsSystemIdDelete"></a>
# **deleteWorkstationApiV1WorkstationsSystemIdDelete**
> oas_any_type_not_mapped deleteWorkstationApiV1WorkstationsSystemIdDelete(system\_id)

Delete Workstation

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **system\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getWorkstationApiV1WorkstationsSystemIdGet"></a>
# **getWorkstationApiV1WorkstationsSystemIdGet**
> oas_any_type_not_mapped getWorkstationApiV1WorkstationsSystemIdGet(system\_id)

Get Workstation

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **system\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listWorkstationsApiV1WorkstationsGet"></a>
# **listWorkstationsApiV1WorkstationsGet**
> oas_any_type_not_mapped listWorkstationsApiV1WorkstationsGet(branch\_sk, area\_id)

List Workstations

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **branch\_sk** | **Integer**|  | [optional] [default to null] |
| **area\_id** | **Integer**|  | [optional] [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="patchWorkstationStatusApiV1WorkstationsSystemIdStatusPatch"></a>
# **patchWorkstationStatusApiV1WorkstationsSystemIdStatusPatch**
> oas_any_type_not_mapped patchWorkstationStatusApiV1WorkstationsSystemIdStatusPatch(system\_id, status)

Patch Workstation Status

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **system\_id** | **Integer**|  | [default to null] |
| **status** | **String**|  | [default to null] [enum: AVAILABLE, OFFLINE, MAINTENANCE] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateWorkstationApiV1WorkstationsSystemIdPut"></a>
# **updateWorkstationApiV1WorkstationsSystemIdPut**
> oas_any_type_not_mapped updateWorkstationApiV1WorkstationsSystemIdPut(system\_id, WorkStationUpdate)

Update Workstation

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **system\_id** | **Integer**|  | [default to null] |
| **WorkStationUpdate** | [**WorkStationUpdate**](../Models/WorkStationUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

