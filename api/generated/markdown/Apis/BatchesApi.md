# BatchesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createBatchApiV1BatchesPost**](BatchesApi.md#createBatchApiV1BatchesPost) | **POST** /api/v1/batches | Create Batch |
| [**deleteBatchApiV1BatchesBatchIdDelete**](BatchesApi.md#deleteBatchApiV1BatchesBatchIdDelete) | **DELETE** /api/v1/batches/{batch_id} | Delete Batch |
| [**generateBatchUsersApiV1BatchesBatchIdGeneratePost**](BatchesApi.md#generateBatchUsersApiV1BatchesBatchIdGeneratePost) | **POST** /api/v1/batches/{batch_id}/generate | Generate Batch Users |
| [**getBatchApiV1BatchesBatchIdGet**](BatchesApi.md#getBatchApiV1BatchesBatchIdGet) | **GET** /api/v1/batches/{batch_id} | Get Batch |
| [**listBatchesApiV1BatchesGet**](BatchesApi.md#listBatchesApiV1BatchesGet) | **GET** /api/v1/batches | List Batches |
| [**updateBatchApiV1BatchesBatchIdPatch**](BatchesApi.md#updateBatchApiV1BatchesBatchIdPatch) | **PATCH** /api/v1/batches/{batch_id} | Update Batch |


<a name="createBatchApiV1BatchesPost"></a>
# **createBatchApiV1BatchesPost**
> oas_any_type_not_mapped createBatchApiV1BatchesPost(BatchCreate)

Create Batch

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **BatchCreate** | [**BatchCreate**](../Models/BatchCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteBatchApiV1BatchesBatchIdDelete"></a>
# **deleteBatchApiV1BatchesBatchIdDelete**
> oas_any_type_not_mapped deleteBatchApiV1BatchesBatchIdDelete(batch\_id)

Delete Batch

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **batch\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="generateBatchUsersApiV1BatchesBatchIdGeneratePost"></a>
# **generateBatchUsersApiV1BatchesBatchIdGeneratePost**
> oas_any_type_not_mapped generateBatchUsersApiV1BatchesBatchIdGeneratePost(batch\_id, BatchGenerateRequest)

Generate Batch Users

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **batch\_id** | **Integer**|  | [default to null] |
| **BatchGenerateRequest** | [**BatchGenerateRequest**](../Models/BatchGenerateRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="getBatchApiV1BatchesBatchIdGet"></a>
# **getBatchApiV1BatchesBatchIdGet**
> oas_any_type_not_mapped getBatchApiV1BatchesBatchIdGet(batch\_id)

Get Batch

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **batch\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listBatchesApiV1BatchesGet"></a>
# **listBatchesApiV1BatchesGet**
> oas_any_type_not_mapped listBatchesApiV1BatchesGet()

List Batches

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateBatchApiV1BatchesBatchIdPatch"></a>
# **updateBatchApiV1BatchesBatchIdPatch**
> oas_any_type_not_mapped updateBatchApiV1BatchesBatchIdPatch(batch\_id, BatchUpdate)

Update Batch

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **batch\_id** | **Integer**|  | [default to null] |
| **BatchUpdate** | [**BatchUpdate**](../Models/BatchUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

