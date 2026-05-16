# KioskResourcesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**kioskResourceAddonsApiV1KioskResourcesResourceIdAddonsGet**](KioskResourcesApi.md#kioskResourceAddonsApiV1KioskResourcesResourceIdAddonsGet) | **GET** /api/v1/kiosk/resources/{resource_id}/addons | Returns self + linked resource rows for addons at this kiosk location |
| [**kioskResourceCategoriesApiV1KioskResourceCategoriesGet**](KioskResourcesApi.md#kioskResourceCategoriesApiV1KioskResourceCategoriesGet) | **GET** /api/v1/kiosk/resource-categories | Returns all active resource categories (global) |
| [**kioskResourceTypesApiV1KioskResourceTypesGet**](KioskResourcesApi.md#kioskResourceTypesApiV1KioskResourceTypesGet) | **GET** /api/v1/kiosk/resource-types | Returns resource type cards for a category |
| [**kioskResourcesApiV1KioskResourcesGet**](KioskResourcesApi.md#kioskResourcesApiV1KioskResourcesGet) | **GET** /api/v1/kiosk/resources | [Legacy] Simple resource list by type (not for booking) |


<a name="kioskResourceAddonsApiV1KioskResourcesResourceIdAddonsGet"></a>
# **kioskResourceAddonsApiV1KioskResourcesResourceIdAddonsGet**
> List kioskResourceAddonsApiV1KioskResourcesResourceIdAddonsGet(resource\_id)

Returns self + linked resource rows for addons at this kiosk location

    Calls fn_kiosk_resource_addons; 404 when resource is not at this location.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_id** | **Integer**|  | [default to null] |

### Return type

[**List**](../Models/KioskResourceWithRole.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="kioskResourceCategoriesApiV1KioskResourceCategoriesGet"></a>
# **kioskResourceCategoriesApiV1KioskResourceCategoriesGet**
> List kioskResourceCategoriesApiV1KioskResourceCategoriesGet()

Returns all active resource categories (global)

### Parameters
This endpoint does not need any parameter.

### Return type

[**List**](../Models/KioskCategory.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="kioskResourceTypesApiV1KioskResourceTypesGet"></a>
# **kioskResourceTypesApiV1KioskResourceTypesGet**
> List kioskResourceTypesApiV1KioskResourceTypesGet(category\_id)

Returns resource type cards for a category

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **category\_id** | **Integer**|  | [default to null] |

### Return type

[**List**](../Models/KioskResourceType.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="kioskResourcesApiV1KioskResourcesGet"></a>
# **kioskResourcesApiV1KioskResourcesGet**
> List kioskResourcesApiV1KioskResourcesGet(resource\_type\_id)

[Legacy] Simple resource list by type (not for booking)

    Legacy endpoint: returns rows from &#x60;fn_kiosk_resources&#x60; for browsing only. **Do not use for the reservation booking flow** — no slot, overlap, or &#x60;display_status&#x60;. For booking, call **GET /api/v1/kiosk/resources/availability** with date, time, and &#x60;booking_mode&#x60;.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_type\_id** | **Integer**|  | [default to null] |

### Return type

[**List**](../Models/KioskResource.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

