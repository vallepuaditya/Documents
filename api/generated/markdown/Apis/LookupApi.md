# LookupApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createLookupApiV1LookupPost**](LookupApi.md#createLookupApiV1LookupPost) | **POST** /api/v1/lookup/ | Create Lookup |
| [**deleteLookupApiV1LookupSkDelete**](LookupApi.md#deleteLookupApiV1LookupSkDelete) | **DELETE** /api/v1/lookup/{sk} | Delete Lookup |
| [**getLookupApiV1LookupSkGet**](LookupApi.md#getLookupApiV1LookupSkGet) | **GET** /api/v1/lookup/{sk} | Get Lookup |
| [**listLookupActiveApiV1LookupGet**](LookupApi.md#listLookupActiveApiV1LookupGet) | **GET** /api/v1/lookup/ | List Lookup Active |
| [**lookupByCodeApiV1LookupCodeCodeGet**](LookupApi.md#lookupByCodeApiV1LookupCodeCodeGet) | **GET** /api/v1/lookup/code/{code} | Lookup By Code |
| [**lookupByTypeApiV1LookupTypeTypeNameGet**](LookupApi.md#lookupByTypeApiV1LookupTypeTypeNameGet) | **GET** /api/v1/lookup/type/{type_name} | Lookup By Type |
| [**updateLookupApiV1LookupSkPut**](LookupApi.md#updateLookupApiV1LookupSkPut) | **PUT** /api/v1/lookup/{sk} | Update Lookup |


<a name="createLookupApiV1LookupPost"></a>
# **createLookupApiV1LookupPost**
> oas_any_type_not_mapped createLookupApiV1LookupPost(LookupCreate)

Create Lookup

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **LookupCreate** | [**LookupCreate**](../Models/LookupCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteLookupApiV1LookupSkDelete"></a>
# **deleteLookupApiV1LookupSkDelete**
> oas_any_type_not_mapped deleteLookupApiV1LookupSkDelete(sk)

Delete Lookup

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **sk** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getLookupApiV1LookupSkGet"></a>
# **getLookupApiV1LookupSkGet**
> oas_any_type_not_mapped getLookupApiV1LookupSkGet(sk)

Get Lookup

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **sk** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listLookupActiveApiV1LookupGet"></a>
# **listLookupActiveApiV1LookupGet**
> oas_any_type_not_mapped listLookupActiveApiV1LookupGet(type)

List Lookup Active

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **type** | **String**|  | [optional] [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="lookupByCodeApiV1LookupCodeCodeGet"></a>
# **lookupByCodeApiV1LookupCodeCodeGet**
> oas_any_type_not_mapped lookupByCodeApiV1LookupCodeCodeGet(code)

Lookup By Code

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **code** | **String**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="lookupByTypeApiV1LookupTypeTypeNameGet"></a>
# **lookupByTypeApiV1LookupTypeTypeNameGet**
> oas_any_type_not_mapped lookupByTypeApiV1LookupTypeTypeNameGet(type\_name)

Lookup By Type

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **type\_name** | **String**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateLookupApiV1LookupSkPut"></a>
# **updateLookupApiV1LookupSkPut**
> oas_any_type_not_mapped updateLookupApiV1LookupSkPut(sk, LookupUpdate)

Update Lookup

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **sk** | **Integer**|  | [default to null] |
| **LookupUpdate** | [**LookupUpdate**](../Models/LookupUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

